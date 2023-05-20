# API do Plumbum para conexão com Banco de Dados MySQl

## Instruções para deploy
1. Para prosseguir é necessário fazer o download e a instalação do [MAMP](https://www.mamp.info/en/mamp) (disponível para Windows e MAC). Utilizaremos o servidor Apache da aplicação para enviar os dados do Plumbum para um banco de dados em MySQL.<br>

2. Após a instalação, abra a aplicação e se certifique que o servidor está em execução. Se o programa for fechado, provavelmente o servidor será interrompido.<br>

![Arquivos para deploy do Plumbum](imgsReadme\mampHome.png)

O MAMP possui servidor do Apache e do MySQL, mas utilizaremos apenas o do Apache.

3. Feito isso, vamos criar o banco de dados que será utilizado. Para isso é necessário ter o [MySQL 8](https://dev.mysql.com/downloads/mysql/) instalado e configurado na sua máquina. Com o SGBD pronto, utilize uma IDE de sua preferência (VS Code, MySQL Workbench ou Navicat) para executar a query _plumbum_estrutura.sql_. É só copiar todos os comandos, colar e executar. <br>
Essa consulta cria o banco de dados plumbum, incluindo as tabelas e as foreign keys.
<br>
**Vale lembrar que todo o projeto ainda está em desenvolvimento então o banco ainda não está totalmente construído.**

## Arquivos do Plumbum referentes a essa API
* **DbConnect.php**: Arquivo responsável pela conexão com o banco de dados. Nele estão presentes os parâmetros da conexão:
    * Server: IP do servidor MySQL,
    * Port: Porta que será utilizada. Geralmente 3306,
    * User: Usuário que será utilizado,
    * Pass: Senha do Usuário.

Nesse arquivo também temos a função _connect()_, que faz a conexão direta com o banco.

* **index.php**: O código presente nesse arquivo serve para receber uma requisição HTTP do tipo POST e inserir dados no banco de dados informado. Essa requisição está sendo utilziada para salvar novos usuários que se cadastrarem no site do plumbum, no banco de dados do Plumbum. 


### Arquivos do Plumbum referentes a essa API **no repositório principal**

Como esperado de um projeto em React, utilizamos o Axios para enviar uma solicitação do tipo POST para inserir dados na nossa API.

Os códigos referentes ao Axios estão no diretório abaixo no repositório do [Plumbum](https://github.com/emn-f/plumbum).

~~~~
src\shared\services
~~~~