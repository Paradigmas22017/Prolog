use_module(library(csv)).

% Definindo os fatos que serão utilizados no algoritmo.
set_facts:-
  consult('stop_words_facts_database.prolog'),
  consult('stemming_facts_database.prolog').

read_data:-
  csv_read_file('sample_data.csv', Data),
  nth1(2,Data,SecondRow),
  row(X,_) = SecondRow,
  row(_,Y) = SecondRow,
  atomic_list_concat(TextList,' ',X),
  atomic_list_concat(LabelList,' ',Y),
  process_array_of_words(TextList, TextListWithoutStepWords),
  remove_stemming_five(TextListWithoutStepWords, TextListWithoutStemmingFive),
  remove_stemming_four(TextListWithoutStemmingFive, TextListWithoutStemmingFour),
  remove_stemming_three(TextListWithoutStemmingFour, TextListWithoutStemmingThree),
  remove_stemming_two(TextListWithoutStemmingThree, TextListWithoutStemmingTwo),
  remove_stemming_one(TextListWithoutStemmingTwo, TextListWithoutStemmingOne),
  atomic_list_concat(TextListWithoutStemmingOne, ' ', DataToCsv),
  atomic_list_concat(LabelList, ' ', LabelToCsv),
  List = [DataToCsv],
  Label = [LabelToCsv],
  findall(row(A,B), (member(A, List), member(B, Label)), Row),
  csv_write_file('output.csv', Row).

%Regra para fazer a remoção de um elemento dentro de um array.
remove_stop_words([],[]).
remove_stop_words([Head|Tail],Result):- it_is_stop_word(Head), remove_stop_words(Tail,Result).
remove_stop_words([Head|Tail],[Head|Result]):- remove_stop_words(Tail,Result).

%Regra para remover os elementos com sufixos iguais aos stemming
remove_stemming_one([],[]).
remove_stemming_one([Head|Tail],Result):-
  atom_length(Head, Length),
  if_then_else(Length > 1,
  (it_is_stemming_one(Head, SizeSuffix),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  remove_stemming_one([Prefix|Tail], Result)),
  it_is_stemming_one(Head, SizeSuffix)).
remove_stemming_one([Head|Tail],[Head|Result]):-
  remove_stemming_one(Tail,Result).

remove_stemming_two([],[]).
remove_stemming_two([Head|Tail],Result):-
  atom_length(Head, Length),
  if_then_else(Length > 2,
  (it_is_stemming_two(Head, SizeSuffix),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  remove_stemming_two([Prefix|Tail], Result)),
  it_is_stemming_two(Head, SizeSuffix)).
remove_stemming_two([Head|Tail],[Head|Result]):-
  remove_stemming_two(Tail,Result).

remove_stemming_three([],[]).
remove_stemming_three([Head|Tail],Result):-
  atom_length(Head, Length),
  if_then_else(Length > 3,
  (it_is_stemming_three(Head, SizeSuffix),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  remove_stemming_three([Prefix|Tail], Result)),
  it_is_stemming_three(Head, SizeSuffix)).
remove_stemming_three([Head|Tail],[Head|Result]):-
  remove_stemming_three(Tail,Result).

remove_stemming_four([],[]).
remove_stemming_four([Head|Tail],Result):-
  atom_length(Head, Length),
  if_then_else(Length > 4,
  (it_is_stemming_four(Head, SizeSuffix),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  remove_stemming_four([Prefix|Tail], Result)),
  it_is_stemming_four(Head, SizeSuffix)).
remove_stemming_four([Head|Tail],[Head|Result]):-
  remove_stemming_four(Tail,Result).

remove_stemming_five([],[]).
remove_stemming_five([Head|Tail],Result):-
  atom_length(Head, Length),
  if_then_else(Length > 5,
  (it_is_stemming_five(Head, SizeSuffix),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  remove_stemming_five([Prefix|Tail], Result)),
  it_is_stemming_five(Head, SizeSuffix)).
remove_stemming_five([Head|Tail],[Head|Result]):-
  remove_stemming_five(Tail,Result).

%Regra para verificar se a palavra é stop-word.
it_is_stop_word(Word):-stopWord(Word).

%Regra para verificar se a palavra é stemming.
it_is_stemming_one(Word, SizeSuffix):-
  atom_length(Word, Length),
  LengthTo is Length - 1,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 1.

it_is_stemming_two(Word, SizeSuffix):-
  atom_length(Word, Length),
  Length > 2,
  LengthTo is Length - 2,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 2.

it_is_stemming_three(Word, SizeSuffix):-
  atom_length(Word, Length),
  Length > 3,
  LengthTo is Length - 3,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 3.

it_is_stemming_four(Word, SizeSuffix):-
  atom_length(Word, Length),
  Length > 4,
  LengthTo is Length - 4,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 4.

it_is_stemming_five(Word, SizeSuffix):-
  atom_length(Word, Length),
  Length > 5,
  LengthTo is Length - 5,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 5.

%Simulação do if then else em prolog.
if_then_else(X,Y,_):-X,!,Y.
if_then_else(_,_,Z):-Z.

%Processando a lista de palavras retirando as stop-words.
process_array_of_words(DataTest, DataTestResult):-
  remove_stop_words(DataTest, DataTestResult).


    %open('array_of_words.txt', read, Str),
    %read_file(Str,Lines),
    %close(Str),
    %nth1(1,Lines,Data),
    %atomic_list_concat(DataTest, ' ', Data),

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
