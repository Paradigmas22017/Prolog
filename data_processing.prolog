/* Arquivo destinado ao processamento de dados realizado pelo prolog. */

read_data:-
  csv_read_file('sample_data.csv', Data),
  nth1(2,Data,SecondRow), % Considera o index da lista iniciando com 1;
