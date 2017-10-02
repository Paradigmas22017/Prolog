% transform_in_pair([Head | Tail], [[Head, Apprerance] | ResultTail]) :-
%     Apprerance is 1,
%     transform_in_pair(Tail, ResultTail).
% transform_in_pair([], []).

transform_in_pair([Head | Tail], [[Head, Apprerance] | ResultTail]) :-
    Apprerance is 1,
    transform_in_pair(Tail, ResultTail).
transform_in_pair([], []).

count([], Head, 0).
count([Head|Tail], Head, Total):- count(Tail, Head, PreviousTotal), Total is 1+PreviousTotal.
count([Different|Tail ], Head, Total):- Different \= Head,count(Tail ,Head, Total).

bag_of_words(List, Result) :- transform_in_pair(List, Result), write(Result).
