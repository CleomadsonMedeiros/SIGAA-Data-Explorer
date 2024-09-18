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

% Verificar o departamento de um professor com base no nome completo
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
obter_primeiro_nome([' '|_], []). % Se encontrar um espaço, retorna uma lista vazia
obter_primeiro_nome([Caractere|Resto], [Caractere|PrimeiroNome]) :- % Se não for espaço, acumula o caractere
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

% Predicado para buscar o aluno a partir do primeiro nome fornecido
buscar_aluno(PrimeiroNomeFornecido) :-
    (   aluno_DSI(_, Matricula, Nome), % Obtém o nome completo do aluno
        primeiro_nome(Nome, PrimeiroNomeAluno), % Extrai o primeiro nome do aluno
        PrimeiroNomeFornecido = PrimeiroNomeAluno -> % Compara os nomes
        format('A matrícula ~w corresponde ao aluno ~w em DSI.~n', [Matricula, Nome])
    ;   aluno_DCOMP(_, Matricula, Nome),
        primeiro_nome(Nome, PrimeiroNomeAluno),
        PrimeiroNomeFornecido = PrimeiroNomeAluno ->
        format('A matrícula ~w corresponde ao aluno ~w em DCOMP.~n', [Matricula, Nome])
    ;   format('Nenhum aluno encontrado com o primeiro nome ~w.~n', [PrimeiroNomeFornecido]), fail
    ).