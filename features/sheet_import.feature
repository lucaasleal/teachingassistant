Feature: Self evaluation
As a student of Course “Engenharia de Software e Sistemas”
I want to see received grades by teacher and put my self evalution for each goal
So that I can send grades that I think deserve to me .

Scenario: Cadastrar notas na autoavaliação
Given O sistema não possui notas inseridas pelo aluno
When Envio MANA em “Entender conceitos de requisitos”, MA em “Entender requisitos com qualidade”,  MPA em “Entender gerência de configuração” e MA em “Entender Testes de Software”
Then Minhas notas são inseridas no sistema e estarão visíveis na tela de autoavaliação.

Scenario: Visualização da análise de autoavaliações
Given Eu estou na página de autoavaliações dos alunos
And Consigo ver a quantidade de alunos discrepantes e normais
And Consigo ver uma tabela vazia com as colunas “Nome do aluno” e “Porcentagem”.