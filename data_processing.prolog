/* Arquivo destinado ao processamento de dados realizado pelo prolog. */

read_data:-
  csv_read_file('sample_data.csv', Data),
  nth1(2,Data,SecondRow),
  row(X,_) = SecondRow,
  row(_,Y) = SecondRow,
  atomic_list_concat(L, ' ', X),
  atomic_list_concat(L2, ' ', Y),
  writeln(L),
  writeln(L2). % Considera o index da lista iniciando com 1;
