% Usado parenteses para representa uma condição (If->Then), ; == Operador de OU/Else, dependendo do contexto.
% Funciona como um printf, onde nele você pode fazer tratamento explicitando variáveis com ~w e quebra de linhas com ~n.
carregar_arquivo(Arquivo) :-
    ( exists_file(Arquivo) ->
        consult(Arquivo)
    ;   format('O arquivo ~w nao existe.~n~n', [Arquivo])
    ).

% Predicado para carregar os arquivos com os dados dos alunos.
:- carregar_arquivo('alunos_DSI.pl').
:- carregar_arquivo('alunos_DCOMP.pl').
:- carregar_arquivo('professores_DSI.pl').
:- carregar_arquivo('professores_DCOMP.pl').

% Verificar se a matrícula existe em alunos_DSI ou alunos_DCOMP
verificar_aluno(Matricula) :-
    (   aluno_DSI(_, Matricula, _)
    ;   aluno_DCOMP(_, Matricula, _)
    ).

% Verificar se o nome do professor existe em professores_DSI ou professores_DCOMP
verificar_professor(NomeCompleto) :-
    (   professor_DSI(_, NomeCompleto)
    ;   professor_DCOMP(_, NomeCompleto)
    ).

% Verificar o departamento de um aluno com base na matrícula
verificar_departamento_aluno(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('Departamento de Sistemas de Informacao (DSI).~n')
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('Departamento de Computacao (DCOMP).~n')
    ;   format('A matricula ~w nao foi encontrada em nenhum dos departamentos.~n', [Matricula]),
        fail
    ).

% Verificar o departamento de um professor com base no nome completo e título
verificar_departamento_professor(NomeCompleto) :-
    (   professor_DSI(_, NomeCompleto) ->
        format('Departamento de Sistemas de Informacao (DSI).~n')
    ;   professor_DCOMP(_, NomeCompleto) ->
        format('Departamento de Computacao (DCOMP).~n')
    ;   format('O nome ~w nao foi encontrado em nenhum dos departamentos.~n', [NomeCompleto]),
        fail
    ).

% Predicado para obter o primeiro nome de uma lista de caractere
obter_primeiro_nome([], []). % Se a lista estiver vazia, retorna uma lista vazia
obter_primeiro_nome([' '|_], []). % Se encontrar um espaço, retorna uma lista vazia, caso não tem um nome válido
obter_primeiro_nome([Caractere|Resto], [Caractere|PrimeiroNome]) :- % Se não for espaço, acumula o caractere em PrimeiroNome
    Caractere \= ' ', % Garante que não é um espaço
    obter_primeiro_nome(Resto, PrimeiroNome). % Continua a busca no restante da lista

% Recebe um nome e retorna o primeiro nome em PrimeiroNome
primeiro_nome(Nome, PrimeiroNome) :-
    atom_chars(Nome, Lista), % Transforma o nome (átomo) em uma lista de caracteres
    obter_primeiro_nome(Lista, ListaPrimeiroNome), % Chama o predicado auxiliar para obter os caracteres do primeiro nome
    atom_chars(PrimeiroNome, ListaPrimeiroNome). % Converte a lista de caracteres de volta para um nome (átomo)

% Buscar o aluno a partir da matrícula
buscar_aluno(Matricula) :-
    (   aluno_DSI(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DSI.~n', [Matricula, Nome]),!
    ;   aluno_DCOMP(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DCOMP.~n', [Matricula, Nome]),!
    ;   fail
    ).

% Buscar o aluno a partir do nome completo
buscar_aluno(NomeCompleto) :-
    (   aluno_DSI(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DSI.~n', [NomeCompleto, Matricula]),!
    ;   aluno_DCOMP(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DCOMP.~n', [NomeCompleto, Matricula]),!
    ;   fail
    ).

% Buscar o aluno a partir do primeiro nome fornecido
buscar_aluno(PrimeiroNomeFornecido) :-
    (   aluno_DSI(_, Matricula, Nome), % Obtém o nome completo do aluno
        primeiro_nome(Nome, PrimeiroNomeAluno), % Extrai o primeiro nome do aluno
        PrimeiroNomeFornecido = PrimeiroNomeAluno -> % Compara os nomes
        format('A matrícula ~w corresponde ao aluno ~w em DSI.~n', [Matricula, Nome])
    ;   aluno_DCOMP(_, Matricula, Nome),
        primeiro_nome(Nome, PrimeiroNomeAluno),
        PrimeiroNomeFornecido = PrimeiroNomeAluno ->
        format('A matrícula ~w corresponde ao aluno ~w em DCOMP.~n', [Matricula, Nome])
    ;   format('Nenhum aluno encontrado com o primeiro nome ~w.~n', [PrimeiroNomeFornecido]), 
        fail
    ).

% Buscar o aluno a partir do nome completo
buscar_professor(NomeCompleto) :-
    (   professor_DSI(_, NomeCompleto) ->
        format('O professor ~w foi encontrado em DSI.~n', [NomeCompleto]),!
    ;   professor_DCOMP(_, NomeCompleto) ->
        format('O professor ~w foi encontrado em DCOMP.~n', [NomeCompleto]),!
    ;   fail
    ).

% Buscar o professor a partir do primeiro nome fornecido
buscar_professor(PrimeiroNomeFornecido) :-
    (   professor_DSI(_, NomeCompleto),
        primeiro_nome(NomeCompleto, PrimeiroNomeProfessor),
        PrimeiroNomeFornecido = PrimeiroNomeProfessor ->
        format('O professor ~w pertence ao DSI.~n', [NomeCompleto])
    ;   professor_DCOMP(_, NomeCompleto),
        primeiro_nome(NomeCompleto, PrimeiroNomeProfessor),
        PrimeiroNomeFornecido = PrimeiroNomeProfessor ->
        format('O professor ~w pertence ao DCOMP.~n', [NomeCompleto])
    ;   format('Nenhum professor encontrado com o primeiro nome ~w.~n', [PrimeiroNomeFornecido]), 
        fail
    ).

% Predicado auxiliar que realiza a inversão, ou seja, Se a lista original estiver vazia ([]), 
% A lista invertida é simplesmente o acumulador (ListaInvertida). 
% Significa que quando não há mais elementos para processar, a inversão está completa.
inverter_aux([], ListaInvertida, ListaInvertida). % Caso base: se a lista original estiver vazia, retorna a lista invertida

% Predicado auxiliar, que recebe a lista, um acumulador (lista invertida), saída
inverter_aux([Cabeca|Cauda], Acumulador, ListaInvertida) :- 
    inverter_aux(Cauda, [Cabeca|Acumulador], ListaInvertida). % Adiciona a cabeça da lista original ao acumulador

% Predicado principal para inverter uma lista
inverter(ListaOriginal, ListaInvertida) :-
    inverter_aux(ListaOriginal, [], ListaInvertida).

% Predicado para obter o título isolado
titulo_professor(TituloCompleto, TituloIsolado) :-
    atom_chars(TituloCompleto, Lista), % Converte o título completo em uma lista de caracteres
    inverter(Lista, ListaInvertida), % Inverte a lista de caracteres
    obter_primeiro_nome(ListaInvertida, ListaTitulo), % Obtém o primeiro nome da lista invertida
    inverter(ListaTitulo, TituloInvertido), % Inverte novamente para obter o título correto
    atom_chars(TituloIsolado, TituloInvertido). % Converte a lista de volta para átomo

% Predicado auxiliar para imprimir uma lista de nomes
print_lista([]).

print_lista([Nome|Resto]) :-
    format('~w~n', [Nome]),
    print_lista(Resto).

% Predicado para buscar professores com um título específico e imprimir seus nomes
buscar_professor_titulo(Titulo) :-
    findall(NomeCompleto, (
        professor_DSI(_, NomeCompleto),
        titulo_professor(NomeCompleto, TituloIsolado),
        TituloIsolado = Titulo
    ), DoutoresDSI),
    
    findall(NomeCompleto, (
        professor_DCOMP(_, NomeCompleto),
        titulo_professor(NomeCompleto, TituloIsolado), % Obtemos o título do professor
        TituloIsolado = Titulo % Verifica se o título isolado é igual ao título procurado
    ), DoutoresDCOMP),

    (   DoutoresDSI \= [] -> 
        format('Professores do DSI com o titulo ~w:~n', [Titulo]),
        print_lista(DoutoresDSI)
    ;   true
    ),
    
    (   DoutoresDCOMP \= [] -> 
        format('Professores do DCOMP com o titulo ~w:~n', [Titulo]),
        print_lista(DoutoresDCOMP)
    ;   true
    ).