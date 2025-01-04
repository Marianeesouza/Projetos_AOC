# MIPShelf
Livro
1 - O sistema deve ser capaz de cadastrar livros no acervo, permitindo o registro de título, autor, ISBN e quantidade de exemplares disponíveis.

2 - O sistema deve ser capaz de registrar a devolução de livros, atualizando o status de disponibilidade no acervo e confirmando a data de devolução efetiva.

3 - O sistema deve ser capaz de consultar a disponibilidade de livros no acervo, informando se estão disponíveis para empréstimo ou não.

4 - O sistema deve ser capaz de remover registros de livros do acervo.
Usuário

5 - O sistema deve ser capaz de cadastrar usuários, armazenando nome, matrícula e curso.

6 - O sistema deve ser capaz de remover registros de usuários.
Empréstimo

7 - O sistema deve ser capaz de registrar empréstimos de livros, vinculando-os a usuários previamente cadastrados e armazenando as datas de retirada e devolução previstas.

8 - O sistema deve ser capaz de calcular automaticamente atrasos com base na data atual do sistema e na data de devolução prevista.

9 - O sistema deve ser capaz de gerar relatórios que listem os livros atualmente emprestados, os usuários em atraso e o tempo de atraso (em dias).

Geral

10 - O sistema deve ser capaz de salvar todos os dados registrados em arquivos, de modo que as informações sejam recuperadas na inicialização.

11 - O sistema deve permitir o ajuste manual da data e hora do sistema.

12 - O sistema deve ter um relógio interno que atualiza constantemente a data e hora atual, utilizando o serviço 30 do syscall do MARS.

13 - O sistema deve exibir uma string padrão (banner) no início de cada linha do terminal, utilizando o formato: xxxxxx-shell>>, em que xxxxxx é o nome do sistema a escolha dos alunos.

14 - O sistema vai ficar constantemente checando por entradas de texto
