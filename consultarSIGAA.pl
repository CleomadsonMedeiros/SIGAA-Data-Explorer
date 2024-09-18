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

verificarAluno(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('A matricula ~w foi encontrada em alunos_DSI.~n', [Matricula])
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('A matricula ~w foi encontrada em alunos_DCOMP.~n', [Matricula])
    ;   format('A matricula ~w não foi encontrada em nenhum dos registros.~n', [Matricula]),
        fail
    ).

verificarDepartamento(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('Departamento de Sistemas de Informacao (DSI).~n')
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('Departamento de Computacao (DCOMP).~n')
    ;   format('A matricula ~w não foi encontrada em nenhum dos departamentos.~n', [Matricula]),
        fail
    ).

%Ser alterada para não precisar colocar o título
verificarProfessor(NomeCompleto) :-
    (   professor_DSI(_, NomeCompleto) ->
        format('O professor ~w foi encontrado em professores_DSI.~n', [NomeCompleto])
    ;   professor_DCOMP(_, NomeCompleto) ->
        format('O professor ~w foi encontrado em professores_DCOMP.~n', [NomeCompleto])
    ;   format('O professor ~w foi encontrado em nenhum dos registros.~n', [NomeCompleto]),
        fail
    ).

% Buscar nome do aluno a partir da matrícula
buscarAluno(Matricula) :-
    (   aluno_DSI(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DSI.~n', [Matricula, Nome])
    ;   aluno_DCOMP(_, Matricula, Nome) ->
        format('A matricula ~w corresponde ao aluno ~w em DCOMP.~n', [Matricula, Nome])
    ;   format('A matricula ~w não foi encontrada em nenhum dos registros.~n', [Matricula]),
        fail
    ).

% Buscar matrícula do aluno a partir do nome completo
buscarAluno(NomeCompleto) :-
    (   aluno_DSI(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DSI.~n', [NomeCompleto, Matricula])
    ;   aluno_DCOMP(_, Matricula, NomeCompleto) ->
        format('O aluno ~w tem a matrícula ~w em DCOMP.~n', [NomeCompleto, Matricula])
    ;   format('O aluno ~w não foi encontrado em nenhum dos registros.~n', [NomeCompleto]),
        fail
    ).