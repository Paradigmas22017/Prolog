% Definindo os fatos que serão utilizados no algoritmo.
set_facts:-
  consult('stop_words_facts_database.prolog').

read_data:-
  csv_read_file('sample_data.csv', Data),
  nth1(2,Data,SecondRow),
  row(X,_) = SecondRow,
  row(_,Y) = SecondRow,
  atomic_list_concat(TextList,' ',X),
  atomic_list_concat(LabelList,' ',Y),
  writeln(TextList),
  process_array_of_words(TextList).

%Regra para fazer a remoção de um elemento dentro de um array.
remove_stop_words([],[]).
remove_stop_words([Head|Tail],Result):- it_is_stop_word(Head), remove_stop_words(Tail,Result).
remove_stop_words([Head|Tail],[Head|Result]):- remove_stop_words(Tail,Result).

%Regra para remover os elementos com sufixos iguais aos stemming
remove_stemming([],[]).
remove_stemming([Head|Tail],Result):- it_is_stemming(Head), remove_stemming(Tail,Result).
remove_stemming([Head|Tail],[Head|Result]):- remove_stemming(Tail,Result).

%Regra para verificar se a palavra é stop-word.
it_is_stop_word(Word):-stopWord(Word).

%Regra para verificar se a palavra é stemming.
it_is_stemming(Word):-suffix(Word).

%Simulação do if then else em prolog.
if_then_else(X,Y,_):-X,!,Y.
if_then_else(_,_,Z):-Z.

process_array_of_words(DataTest):-

  %open('array_of_words.txt', read, Str),
  %read_file(Str,Lines),
  %close(Str),
  %nth1(1,Lines,Data),
  %atomic_list_concat(DataTest, ' ', Data),
  remove_stop_words(DataTest, Result),
  writeln(Result).

%main process
main:-
  set_facts,
  read_data.

/*
read_file(Stream, []):-
  at_end_of_stream(Stream).

read_file(Stream, [X|L]):-
  \+ at_end_of_stream(Stream),
  read_line_to_codes(Stream,Codes),
  atom_chars(X, Codes),
  read_file(Stream,L), !.
*/
