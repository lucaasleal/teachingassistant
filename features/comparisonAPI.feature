Feature: API de Comparação de Desempenho
  As a sistema cliente
  I want to solicitar cálculos de comparação de desempenho entre turmas
  So that eu possa exibir os dados consolidados para o professor

Scenario: Requisição válida de comparação
  Given as turmas "T1-25.1" e "T2-25.2" da disciplina "Sistemas Operacionais" estão armazenadas no sistema com suas respectivas notas
  When eu solicito ao sistema a comparação da métrica "Média" entre as turmas "T1-25.1" e "T2-25.2" da disciplina "Sistemas Operacionais"
  Then o sistema retorna o status "HTTP 200 OK"
  And o sistema retorna um JSON contendo o valor "8.5" para a turma "T1-25.1" e "9.2" para a turma "T2-25.2"
  And as turmas "T1-25.1" e "T2-25.2" permanecem inalteradas no sistema com suas respectivas notas

Scenario: Requisição inválida por falta de parâmetros mínimos
  Given a disciplina "Banco de Dados" possui turmas cadastradas no sistema
  When eu envio uma requisição de comparação de "Média" informando apenas a disciplina "Banco de Dados" e a turma "T1-25.1"
  Then o sistema rejeita a requisição e retorna o código de erro "HTTP 400 Bad Request"
  And o sistema retorna a mensagem "ERRO: É necessário fornecer ao menos duas turmas" no payload

Scenario: Requisição para turma sem dados cadastrados
  Given a turma "T1-26.1" da disciplina "Engenharia de Software e Sistemas" possui notas cadastradas no sistema
  And a turma "T2-26.2" da mesma disciplina está cadastrada no sistema sem alunos ou notas avaliadas
  When eu solicito ao sistema a comparação da métrica "Média" entre as turmas "T1-26.1" e "T2-26.2"
  Then o sistema retorna o status "HTTP 200 OK"
  And o sistema retorna o valor "8.9" para "T1-26.1" no JSON de resposta
  And o sistema retorna o valor "N/A" para "T2-26.2" no JSON de resposta

Scenario: Requisição burlando regras de negócio da GUI
  Given as disciplinas "Inteligência Artificial" e "Banco de Dados" possuem suas respectivas turmas cadastradas no sistema
  When eu envio um payload de requisição tentando comparar a turma "T1" de "Inteligência Artificial" diretamente com a turma "T1" de "Banco de Dados"
  Then o sistema intercepta a inconsistência e retorna o código de erro "HTTP 422 Unprocessable Entity"
  And o sistema não realiza nenhum cálculo de métrica
  And o sistema retorna a mensagem "ERRO: Só é permitida a comparação entre turmas de uma única disciplina"

Scenario: Requisição com múltiplas métricas simultâneas
  Given as turmas "T1-25.1" e "T2-25.2" da disciplina "Sistemas Operacionais" estão armazenadas no sistema com suas respectivas notas
  When eu solicito ao sistema a comparação das métricas "Média" e "Número de aprovados" entre as turmas "T1-25.1" e "T2-25.2" da disciplina "Sistemas Operacionais"
  Then o sistema retorna o status "HTTP 200 OK"
  And o sistema retorna um JSON contendo o valor "8.1" para a média da turma "T1-25.1" e "9.0" para a média da turma "T2-25.2"
  And o sistema retorna no mesmo JSON o valor "58" para o número de aprovados da turma "T1-25.1" e "47" para a turma "T2-25.2"

Scenario: Requisição sem o parâmetro de métrica
  Given a disciplina "Banco de Dados" possui turmas cadastradas no sistema
  When eu envio uma requisição de comparação informando as turmas "T1-25.1" e "T2-25.2" da disciplina "Banco de Dados" sem especificar uma métrica
  Then o sistema rejeita a requisição e retorna o código de erro "HTTP 400 Bad Request"
  And o sistema retorna a mensagem "ERRO: Selecione ao menos 1 métrica" no payload

Scenario: Requisição de uma métrica inválida ou inexistente
  Given as turmas "T1-26.1" e "T2-26.1" da disciplina "Engenharia de Software e Sistemas" estão cadastradas no sistema
  When eu envio uma requisição de comparação informando a métrica "Taxa de Evasão" entre as turmas "T1-26.1" e "T2-26.1" da disciplina "Engenharia de Software e Sistemas"
  Then o sistema rejeita a requisição e retorna o código de erro "HTTP 422 Unprocessable Entity"
  And o sistema retorna a mensagem "ERRO: Métrica solicitada não é suportada pelo sistema"
  And o sistema retorna o valor "N/A" no campo de resultados do JSON de resposta
