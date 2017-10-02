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
  writeln(TextList),
  process_array_of_words(TextList, TextListWithoutStepWords),
  writeln(TextListWithoutStepWords),
  remove_stemming(TextListWithoutStepWords, TextListWithoutStemming),
  writeln(TextListWithoutStemming).

%Regra para fazer a remoção de um elemento dentro de um array.
remove_stop_words([],[]).
remove_stop_words([Head|Tail],Result):- it_is_stop_word(Head), remove_stop_words(Tail,Result).
remove_stop_words([Head|Tail],[Head|Result]):- remove_stop_words(Tail,Result).

%Regra para remover os elementos com sufixos iguais aos stemming
remove_stemming([],[]).
remove_stemming([Head|Tail],Result):- it_is_stemming_one(Head, SizeSuffix),
  atom_length(Head, Length),
  LengthTo is Length - SizeSuffix,
  sub_atom(Head, 0, LengthTo, _After, Prefix),
  %Salvar a Head e Prefix em um arquivo para troca-los depois.
  writeln(Prefix),
  remove_stemming(Tail, Result).
remove_stemming([Head|Tail],[Head|Result]):-
  remove_stemming(Tail,Result).

%Regra para verificar se a palavra é stop-word.
it_is_stop_word(Word):-stopWord(Word).

%Regra para trocar o elemento de uma lista
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

%Regra para verificar se a palavra é stemming.
it_is_stemming_one(Word, SizeSuffix):-
  atom_length(Word, Length),
  LengthTo is Length - 1,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 1.

it_is_stemming_two(Word, SizeSuffix):-
  atom_length(Word, Length),
  LengthTo is Length - 2,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 2.

it_is_stemming_three(Word, SizeSuffix):-
  atom_length(Word, Length),
  LengthTo is Length - 3,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 3.

it_is_stemming_four(Word, SizeSuffix):-
  atom_length(Word, Length),
  LengthTo is Length - 4,
  sub_atom(Word, LengthTo, _Length, 0, Suffix),
  suffix(Suffix),
  SizeSuffix is 4.

it_is_stemming_five(Word, SizeSuffix):-
  atom_length(Word, Length),
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
