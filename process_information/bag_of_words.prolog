% TRANSFORMA TODAS AS PALAVRAS EM PARES COM APPREARED 1.      ([cachorro, gato]) => [[cachorro, 1], [gato, 1]]
transform_in_pair([Head | Tail], [[Head, Appeared] | ResultTail]) :-
    Appeared is 1,
    transform_in_pair(Tail, ResultTail).
transform_in_pair([], []).


% RETORNA CONTENT DE LISTA [CONTENT, APPEARED].        ([cachorro, 1]) => cachorro
get_item_content([Content | Appeared], Result) :- Result = Content.

% SETA VALOR DE APPEARED.
set_appeared_value(Item, Total, [Result, Total]) :- get_item_content(Item, Result).

% set_appeared_value(Content, Total) :- write(Total), write(Content), Content = [Total].



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
set_all_appeared([Head | Tail], FinalList) :-
    get_item_content(Head, Result),
    count(Tail, Result, Total),
    % write(Total),
    set_appeared_value(Head, Total, ResultItem),
    % write(ResultItem),
    append(FinalList, ResultItem),
    set_all_appeared(Tail),
    write(FinalList).




bag_of_words(List, Result) :- transform_in_pair(List, Result), write(Result).
