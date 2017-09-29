# Pré-Processamento

Precisamos utilizar algumas técnicas de pré-processamento de dados. Iremos fazer isso com python. Temos alguns passos que precisamos seguir...

**1.** Estabelecer qual serão os emails. Estava pensando em 200 emails de 5 categorias. Ou seja, 1000 emails. (É uma quantidade reduzida para trabalhar com prolog)

**2.** Criar um csv com duas colunas, o conteúdo do email, e seu assunto. O assunto é definido pelo nome das pastas. (Um CSV com 1000 emails);


Essas duas partes serão feitas em python, por conta da velocidade de processamento. Prolog demora muito. Para ter um exemplo de como fazer isso, basta acessar o [link](https://github.com/Segmentation-Fault-Machine-Learning/Emails-Problem/blob/Pre-processing/Data%20Pre-Processing/Pre_processing.ipynb)

**3.**  Após o csv com todos os emails criado, precisamos refinar esses dados, ou seja, utilizar algumas técnicas de processamento de dados textuais. Nessa parte o prolog é muito foda, basicamente precisamos remover palavras conectivas, que não servem para o entendimento do contexto. O nome dessa técnica é Stop-Words. Precisamos utilizar esse tratamento no csv existe também muitas técnicas para esse refinamento, vocês podem saber mais nesse [link](https://github.com/Segmentation-Fault-Machine-Learning/Knowledge/wiki/Processamento-dos-Dados).

Todas essas técnicas possuem suporte para aplicação no prolog.

# Criação do modelo

O modelo consiste em uma diversidade de dados colhidos para fazer a relação entre o conteúdo dos emails e o seu assunto. Existem diversas técnicas que podemos usar... As principais são Bag of Words (N grams), isso é bem tranquilo de fazer com prolog, basicamente você precisa criar uma matriz com as palavras mais encontradas dependendo do assunto (TDF-IF). Para saber mais sobre isso acesse o [link](https://github.com/Segmentation-Fault-Machine-Learning/Knowledge/wiki/Processamento-dos-Dados)


Após a aplicação desses algoritmos, precisamos quantificar esses dados em números, para fazer operações com esses dados e essas matrizes, dessa forma será possível aplicar alguns algoritmos de aprendizado. Existem os seguintes algoritmos [link](https://github.com/Segmentation-Fault-Machine-Learning/Knowledge/wiki/An%C3%A1lise-dos-algoritmos)


Temos um exemplo de tudo isso implementado em python, ou seja, o maior desafio seria traduzir o que está sendo feito em python para prolog.
