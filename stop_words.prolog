
% Definindo os fatos que serão utilizados no algoritmo.
set_facts:-
  consult('stop_words_facts_database.prolog').

%Regra para fazer a remoção de um elemento dentro de um array.
deleteall([],Element,[]).
deleteall([H|T],Element,Result) :- H=Element, deleteall(T,Element,Result).
deleteall([H|T],Element,[H|Result]) :- deleteall(T,Element,Result).

/*
Regra que recebe um array de strings, verifica se o head é stop-word, caso
seja stop-word, ele remove a palavra do array.

ps: Falta deixar recursivo, sem loop infinito.
*/
remove_stop_words([Word|Tail]):-
  if_then_else(it_is_stop_word(Word), deleteall([Word|Tail], Word, NewList), _),
  write(NewList).

/*
Regra para verificar se a palavra é stop-word.
*/
it_is_stop_word(Word):-stopWord(Word).

/*
Simulação do if then else em prolog.
*/
if_then_else(X,Y,_):-X,!,Y.
if_then_else(_,_,Z):-Z.

main:-
  set_facts,
  remove_stop_words(["the", "and", "maria"]).
