Feature: Importação de alunos por planilha
As a professor da disciplina "Engenharia de Software e Sistemas"
I want to importar os alunos de uma turma por meio de uma planilha
So that os alunos sejam cadastrados no sistema de forma rápida e correta.

#Serviço
Scenario: Importação de planilha em formato incompatível
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br” e suas MATRICULAS “123” e “543”.
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro.

Scenario:  Importar planilha de turma de forma correta
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br” e CPFs “123.433.444-10” e “123.533.444-10”.
Then os dois novos alunos são inseridos no sistema com os respectivos dados.

Scenario:  Importar planilha com coluna incorreta
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, suas matriculas “123” e “543” e CPFs “123.433.444-10” e “123.533.444-10”.
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro "Coluna esperada: E-MAIL".

Scenario:  Importar planilha com coluna faltante
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius” e seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br”.
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro "Coluna esperada: CPF".

Scenario:  Importar planilha com coluna extra
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br”, CPFs “123.433.444-10” e “123.533.444-10” e telefones "10991234567" e "10919891122".
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro "Coluna extra: TELEFONE".

Scenario: Importar planilha com dados faltando
Given o sistema não possui os alunos “Norman Osborn” e “Otto Octavius”
When envio a planilha contendo os nomes “Norman Osborn” e “Otto Octavius”, seus e-mails “no@cin.ufpe.br” e “oo@cin.ufpe.br”, e seus CPFS vazios.
Then os dois novos alunos não são inseridos no sistema e é retornada uma mensagem de erro "CPF obrigatório".

Scenario: Importar planilha com e-mail no formato incorreto
Given o sistema não possui o aluno “Norman Osborn”
When envio a planilha contendo o nome “Norman Osborn”, seu e-mail “no.cin.ufpe.br” e seu CPF “123.433.444-10”.
Then o aluno não é inserido no sistema e é retornada uma mensagem de erro "E-MAIL inválido".

Scenario: Importar planilha com CPF no formato incorreto
Given o sistema não possui o aluno “Peter Parker”
When envio a planilha contendo o nome “Peter Parker”, seu e-mail “pp@cin.ufpe.br” e seu CPF “12345678910”.
Then o aluno não é inserido no sistema e é retornada uma mensagem de erro "CPF inválido".

Scenario: Importar planilha com aluno já cadastrado
Given o sistema já possui o aluno “Gwen Stacy”
When envio a planilha contendo o nome “Gwen Stacy”, seu e-mail “gs@cin.ufpe.br” e seu CPF “111.333.222-10”.
Then o aluno não é duplicado no sistema e é retornada uma mensagem informando que o aluno já está cadastrado.

Scenario: Importar planilha vazia
Given o sistema não possui alunos cadastrados
When envio a planilha com uma única linha contendo nome " ", e-mail " " e CPF " ".
Then nenhum aluno é inserido no sistema e é retornada uma mensagem de erro.


# GUI
Scenario: Acessar a funcionalidade de importação
Given estou na página de gerenciamento dos alunos da disciplina "Engenharia de Software e Sistemas"
When acesso a opção de importar alunos por planilha
Then é exibida a interface de importação de alunos.

Scenario: Exibir seletor de arquivo
Given estou na interface de importação de alunos
When seleciono a opção para escolher uma planilha
Then é exibida a janela de seleção de arquivos do sistema.

Scenario: Selecionar uma planilha válida
Given estou na interface de importação de alunos
When seleciono uma planilha em formato compatível contendo alunos
Then o nome do arquivo selecionado é exibido na interface
And a opção de importar os alunos fica disponível.

Scenario: Importar planilha válida pela interface
Given estou na interface de importação de alunos
And selecionei uma planilha válida contendo os alunos “Norman Osborn” e “Otto Octavius”
When aciono a opção de importar os alunos
Then é exibida uma mensagem de sucesso
And os alunos “Norman Osborn” e “Otto Octavius” são exibidos na lista de alunos.

Scenario: Cancelar a seleção da planilha
Given estou na interface de importação de alunos
And a janela de seleção de arquivos está aberta
When cancelo a seleção do arquivo
Then retorno para a interface de importação
And nenhuma planilha é selecionada.

Scenario: Tentar importar sem selecionar uma planilha
Given estou na interface de importação de alunos
And nenhuma planilha foi selecionada
When aciono a opção de importar os alunos
Then a importação não é realizada
And é exibida uma mensagem informando que uma planilha deve ser selecionada.

Scenario: Exibir erro ao importar planilha em formato incompatível
Given estou na interface de importação de alunos
When seleciono uma planilha em formato incompatível
And aciono a opção de importar os alunos
Then a importação não é realizada
And é exibida uma mensagem de erro informando que o formato da planilha não é compatível.

Scenario: Exibir erro de validação da planilha
Given estou na interface de importação de alunos
When seleciono uma planilha com uma coluna obrigatória faltante
And aciono a opção de importar os alunos
Then a importação não é realizada
And é exibida a mensagem de erro retornada pelo sistema.

Scenario: Exibir confirmação após importação
Given estou na interface de importação de alunos
When importo uma planilha válida contendo novos alunos
Then é exibida uma confirmação de que os alunos foram importados com sucesso
And a lista de alunos é atualizada com os novos alunos.

Scenario: Impedir importação durante o processamento
Given estou na interface de importação de alunos
And selecionei uma planilha válida
When aciono a opção de importar os alunos
Then o botão de importação fica indisponível durante o processamento
And é exibido um indicador de carregamento
And após o processamento o botão volta a ficar disponível.
