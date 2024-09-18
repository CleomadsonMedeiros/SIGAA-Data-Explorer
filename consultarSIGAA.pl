%Usado parenteses para representa uma condição (If->Then), ; == Operador de OU/Else, dependendo do contexto.
%Funciona como um printf, onde nele você pode fazer tratamento explicitando variáveis com ~w e quebra de linhas com ~n.
carregar_arquivo(Arquivo) :-
    ( exists_file(Arquivo) ->
        consult(Arquivo)
    ;   format('O arquivo ~w nao existe.~n~n', [Arquivo])
    ).

%Uso o predicado para carregar os arquivos com os dados dos alunos.
:- carregar_arquivo('alunos_DSI.pl').
:- carregar_arquivo('alunos_DCOMP.pl').
:- carregar_arquivo('professores_DSI.pl').
:- carregar_arquivo('professores_DCOMP.pl').

% Verificar se a matrícula existe em alunos_DSI ou alunos_DCOMP
verificarAluno(Matricula) :-
    (   aluno_DSI(_, Matricula, _)
    ;   aluno_DCOMP(_, Matricula, _)
    ).

% Verificar o departamento de um aluno com base na matrícula
verificarDepartamento(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('Departamento de Sistemas de Informacao (DSI).~n')
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('Departamento de Computacao (DCOMP).~n')
    ;   format('A matricula ~w nao foi encontrada em nenhum dos departamentos.~n', [Matricula]),
        fail
    ).

% Verificar se o professor existe em professores_DSI ou professores_DCOMP
verificarProfessor(NomeCompleto) :-
    (   professor_DSI(_, NomeCompleto)
    ;   professor_DCOMP(_, NomeCompleto)
    ).

% Buscar nome do aluno a partir da matrícula
buscarAluno(Matricula) :-
    (   aluno_DSI(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DSI.~n', [Matricula, Nome])
    ;   aluno_DCOMP(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DCOMP.~n', [Matricula, Nome])
    ;   format('A matricula ~w nao foi encontrada em nenhum dos registros.~n', [Matricula]),
        fail
    ).

% Buscar matrícula do aluno a partir do nome completo
buscarAluno(NomeCompleto) :-
    (   aluno_DSI(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DSI.~n', [NomeCompleto, Matricula])
    ;   aluno_DCOMP(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DCOMP.~n', [NomeCompleto, Matricula])
    ;   format('O aluno ~w nao foi encontrado em nenhum dos registros.~n', [NomeCompleto]),
        fail
    ).
