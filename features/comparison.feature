Feature: Comparação de Desempenho
  As a professor
  I want to ver um gráfico de desempenho entre turmas
  So that eu posso comparar turmas baseado em uma métrica

Scenario: Comparação usando a média dos alunos como métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Engenharia de Software e Sistemas"
  And Eu seleciono a turma "T0" de "2024.1"
  And Eu seleciono a turma "T0" de "2024.2"
  And Eu seleciono a métrica "Média"
  Then Eu consigo ver um gráfico de "Média" abaixo das seleções
  And O gráfico mostra "8.4" para a turma "T0-24.1"
  And O gráfico mostra "7.8" para a turma "T0-24.2"

Scenario: Comparação usando o número de alunos aprovados como métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Sinais e Sistemas para Computação"
  And Eu seleciono a turma "T1" de "2026.1"
  And Eu seleciono a turma "T2" de "2026.1"
  And Eu seleciono a turma "T3" de "2026.1"
  And Eu seleciono a métrica "Número de alunos aprovados"
  Then Eu consigo ver um gráfico de "Número de alunos aprovados" abaixo das seleções
  And O gráfico mostra "42" para a turma "T1-26.1"
  And O gráfico mostra "37" para a turma "T2-26.1"
  And O gráfico mostra "40" para a turma "T3-26.1"

Scenario: Comparação usando o número de alunos aprovados por nota como métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Teoria da Computação"
  And Eu seleciono a turma "T1" de "2024.2"
  And Eu seleciono a turma "T2" de "2024.2"
  And Eu seleciono a turma "T1" de "2025.1"
  And Eu seleciono a turma "T2" de "2025.1"
  And Eu seleciono a métrica "Número de alunos aprovados por nota"
  Then Eu consigo ver um gráfico de "Número de alunos aprovados por nota" abaixo das seleções
  And O gráfico mostra "5" para a turma "T1-24.2"
  And O gráfico mostra "2" para a turma "T2-24.2"
  And O gráfico mostra "1" para a turma "T1-25.1"
  And O gráfico mostra "7" para a turma "T2-25.1"

Scenario: Comparação usando o número de alunos reprovados por nota como métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Fundamentos de Redes de Computadores"
  And Eu seleciono a turma "T0" de "2025.2"
  And Eu seleciono a turma "T2" de "2026.1"
  And Eu seleciono a métrica "Número de alunos reprovados por nota"
  Then Eu consigo ver um gráfico de "Número de alunos reprovados por nota" abaixo das seleções
  And O gráfico mostra "1" para a turma "T0-25.2"
  And O gráfico mostra "3" para a turma "T2-26.1"

Scenario: Comparação usando o número de alunos reprovados por falta como métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Complementos da Matemática para Computação"
  And Eu seleciono a turma "T1" de "2026.1"
  And Eu seleciono a turma "T2" de "2026.1"
  And Eu seleciono a métrica "Número de alunos reprovados por falta"
  Then Eu consigo ver um gráfico de "Número de alunos reprovados por falta" abaixo das seleções
  And O gráfico mostra "2" para a turma "T1-26.1"
  And O gráfico mostra "0" para a turma "T2-26.1"

Scenario: Tentativa de gerar comparação selecionando apenas uma turma
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Banco de Dados"
  And Eu seleciono a turma "T1" de "2025.1"
  And Eu seleciono a métrica "Média"
  Then O sistema não exibe o gráfico de comparação de desempenho
  And Eu consigo ver a mensagem "ERRO: Selecione ao menos 2 turmas"

Scenario: Tentativa de gerar comparação sem selecionar uma disciplina
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a métrica "Número de alunos aprovados"
  Then O sistema não permite selecionar turmas
  And O sistema não exibe o gráfico de comparação de desempenho
  And Eu consigo ver a mensagem "ERRO: Selecione uma disciplina"

Scenario: Tentativa de gerar comparação sem selecionar uma métrica
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Engenharia de Software e Sistemas"
  And Eu seleciono a turma "T1" de "2026.1"
  And Eu seleciono a turma "T2" de "2026.1"
  Then O sistema não exibe o gráfico de comparação de desempenho
  And Eu consigo ver a mensagem "ERRO: Selecione ao menos 1 métrica"

Scenario: Comparação utilizando múltiplas métricas simultâneas
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Sistemas Operacionais"
  And Eu seleciono a turma "T1" de "2025.1"
  And Eu seleciono a turma "T2" de "2025.2"
  And Eu seleciono a métrica "Média"
  And Eu seleciono a métrica "Número de aprovados"
  Then Eu consigo ver um gráfico de "Média" abaixo das seleções
  And O gráfico mostra "8.1" para a turma "T1-25.1"
  And O gráfico mostra "9.0" para a turma "T2-25.2"
  And Eu consigo ver um gráfico de "Número de aprovados" abaixo do primeiro gráfico
  And O gráfico mostra "58" para a turma "T1-25.1"
  And O gráfico mostra "47" para a turma "T2-25.2"

Scenario: Comportamento ao tentar selecionar a mesma turma mais de uma vez
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Lógica para Computação"
  And Eu seleciono a turma "T1" de "2026.1"
  And Eu seleciono novamente a turma "T1" de "2026.1"
  Then O sistema remove a turma "T1" de "2026.1" da seleção

Scenario: Comportamento ao tentar selecionar múltiplas disciplinas
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Introdução à Programação"
  And Eu seleciono a disciplina "Aprendizado de Máquina"
  Then O sistema mantém a disciplina "Aprendizado de Máquina" selecionada
  And O sistema remove a seleção da disciplina "Introdução à Programação"

Scenario: Comportamento ao selecionar turma sem dados ou sem alunos cadastrados
  Given Eu estou na página de comparação de desempenho
  When Eu seleciono a disciplina "Engenharia de Software e Sistemas"
  And Eu seleciono a turma "T1" de "2026.1" que possui notas cadastradas
  And Eu seleciono a turma "T2" de "2026.2" que não possui alunos avaliados
  Then Eu consigo ver um gráfico de "Média" abaixo das seleções
  And O gráfico mostra "9.3" para a turma "T1-26.1"
  And O gráfico mostra "N/A" para a turma "T2-26.2"
  
