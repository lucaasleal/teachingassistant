Feature: Importação de alunos por planilha
As a professor da disciplina "Engenharia de Software e Sistemas"
I want to importar os alunos de uma turma por meio de uma planilha
So that os alunos sejam cadastrados no sistema de forma rápida e correta.

Scenario: Importação de planilha em formato incompatível
Given O sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When Envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br” e suas MATRICULAS“123” e “543”.
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro.

Scenario:  Importar planilha de turma de forma correta
Given O sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When Envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br” e CPFs “123.433.444-10” e “123.533.444-10”.
Then os dois novos alunos são inseridos no sistema com os respectivos dados.
