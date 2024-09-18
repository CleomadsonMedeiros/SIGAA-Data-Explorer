%Usado parenteses para representa uma condição (If->Then), ; == Operador de OU/Else, dependendo do contexto.
%Funciona como um printf, onde nele você pode fazer tratamento explicitando variáveis com ~w e quebra de linhas com ~n.
carregar_arquivo(Arquivo) :-
    ( exists_file(Arquivo) ->
        consult(Arquivo)
    ;   format('O arquivo ~w não existe.~n~n', [Arquivo])
    ).

%Uso o predicado para carregar os arquivos com os dados dos alunos.
:- carregar_arquivo('alunos_DSI.pl').
:- carregar_arquivo('alunos_DCOMP.pl').
:- carregar_arquivo('professores_DSI.pl').
:- carregar_arquivo('professores_DCOMP.pl').

verificarAluno(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('A matrícula ~w foi encontrada em alunos_DSI.~n', [Matricula])
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('A matrícula ~w foi encontrada em alunos_DCOMP.~n', [Matricula])
    ;   format('A matrícula ~w não foi encontrada em nenhum dos registros.~n', [Matricula]),
        fail
    ).

verificarDepartamento(Matricula) :-
    (   aluno_DSI(_, Matricula, _) ->
        format('Departamento de Sistemas de Informação (DSI).~n')
    ;   aluno_DCOMP(_, Matricula, _) ->
        format('Departamento de Computação (DCOMP).~n')
    ;   format('A matrícula ~w não foi encontrada em nenhum dos departamentos.~n', [Matricula]),
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





