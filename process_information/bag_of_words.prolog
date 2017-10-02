:-dynamic(repreated/1).
repeated(pneumoultramicroscopicosilico).

% [cachorro, galinha, gato, gato, gato, galinha, cachorro, galinha, gato, cachorro, gato]
bag_of_words(List) :- transform_in_pair(List, Pair), set_all_appeared(Pair, PairCount), process_array_of_words(PairCount).

% TRANSFORMA TODAS AS PALAVRAS EM PARES COM APPREARED 1.      ([cachorro, gato]) => [[cachorro, 1], [gato, 1]]
transform_in_pair([Head | Tail], [[Head, Appeared] | ResultTail]) :-
    Appeared is 1,
    transform_in_pair(Tail, ResultTail).
transform_in_pair([], []).


% RETORNA CONTENT DE LISTA [CONTENT, APPEARED].        ([cachorro, 1]) => cachorro
get_item_content([Content | Appeared], Result) :- Result = Content.

% SETA VALOR DE APPEARED.
set_appeared_value(Item, Total, [Result, Total]) :- get_item_content(Item, Result).



% RETORNA QTD DE VEZES QUE O PAR É REPETIDO.    ([[cachorro, 1], [gato, 1], [gato, 1]], gato) => 2
count([], Looked, 1).

count([SameContent      | Tail], Looked, Total) :-
    get_item_content(SameContent, Result),
    Result == Looked,
    count(Tail, Looked, PreviousTotal),
    Total is 1+PreviousTotal.

count([DifferentContent | Tail], Looked, Total) :-
    get_item_content(DifferentContent, Result),
    Result \= Looked,
    count(Tail ,Looked, Total).



% CONTA QUANTIDADE DE VEZES QUE CONTENT APARECE NA LISTA E SETA APPREARED.
set_all_appeared([], []).
set_all_appeared([Head | Tail], [ ResultItem | FinalTail]) :-
    get_item_content(Head, Result),
    count(Tail, Result, Total),
    set_appeared_value(Head, Total, ResultItem),
    set_all_appeared(Tail, FinalTail).


process_array_of_words([]).
process_array_of_words([Head | Tail]) :-
    write(Head), nl,
    % is_repeated(Head),
    process_array_of_words(Tail).
%
%
% remove_repeated_words([],[]).
% remove_repeated_words([Head|Tail],Result):- is_repeated(Head), remove_repeated_words(Tail,Result).
% % remove_repeated_words([Head|Tail],[Head|Result]):- remove_repeated_words(Tail,Result).
% %
% is_repeated([Content, Number]) :-
%     repeated(Content),
%     assert(repeated(Content)).
