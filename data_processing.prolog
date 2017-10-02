use_module(library(csv)).

% Definindo os fatos que serão utilizados no algoritmo.
set_facts:-
  consult('stop_words_facts_database.prolog'),
  consult('stemming_facts_database.prolog').

read_data_loop(N, Result, Label, Path):-
  csv_read_file(Path, Data),
  nth0(N,Data,Row),
  row(X,_) = Row,
  row(_,Y) = Row,

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

  Label = [LabelToCsv],
  Result = DataToCsv.

read_data(Init, PathInput, PathOutput):-
  read_data_loop(0, List0, Label, PathInput),
  read_data_loop(1, List1, Label, PathInput),
  read_data_loop(2, List2, Label, PathInput),
  read_data_loop(3, List3, Label, PathInput),
  read_data_loop(4, List4, Label, PathInput),
  read_data_loop(5, List5, Label, PathInput),
  read_data_loop(6, List6, Label, PathInput),
  read_data_loop(7, List7, Label, PathInput),
  read_data_loop(8, List8, Label, PathInput),
  read_data_loop(9, List9, Label, PathInput),
  read_data_loop(10, List10, Label, PathInput),
  read_data_loop(11, List11, Label, PathInput),
  read_data_loop(12, List12, Label, PathInput),
  read_data_loop(13, List13, Label, PathInput),
  read_data_loop(14, List14, Label, PathInput),
  read_data_loop(15, List15, Label, PathInput),
  read_data_loop(16, List16, Label, PathInput),
  read_data_loop(17, List17, Label, PathInput),
  read_data_loop(18, List18, Label, PathInput),
  read_data_loop(19, List19, Label, PathInput),
  ListFinal = [List0,List1,List2,List3,List4,List5,List6,List7,List8,List9,List10,List11,List12,List13,List14,List15,List16,List17,List18,List19],
  writeln(ListFinal),
  findall(row(B,A), (member(B, Label), member(A, ListFinal)), Row),
  %findall(row(A,B), (member(A, List), member(B, Label)), Row),
  csv_write_file(PathOutput, Row).

%Regra para fazer a remoção de um elemento dentro de um array.
remove_stop_words([],[]).
remove_stop_words([Head|Tail],Result):- it_is_stop_word(Head), remove_stop_words(Tail,Result).
remove_stop_words([Head|Tail],[Head|Result]):- remove_stop_words(Tail,Result).

%Regra para remover os elementos com sufixos iguais aos stemming
remove_stemming_one([],[]).
remove_stemming_one([Head|Tail],Result):-
  atom_length(Head, Length),
  Length > 1,
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
  Length > 2,
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
  Length > 3,
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
  Length > 4,
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
  atom_length(Head, Length),i
  Length > 5,
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

%main process
main:-
  set_facts,
  read_data('./Input/soc.religion.christian.csv','./Output/output1.csv'),
  read_data('./Input/talk.religion.misc.csv','./Output/output2.csv'),
  read_data('./Input/talk.politics.mideast.csv','./Output/output3.csv'),
  read_data('./Input/talk.politics.guns.csv','./Output/output4.csv'),
  read_data('./Input/talk.politics.misc.csv','./Output/output5.csv').
