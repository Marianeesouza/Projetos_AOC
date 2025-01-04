# MIPShelf
Livro
O sistema deve ser capaz de cadastrar livros no acervo, permitindo o registro de título, autor, ISBN e quantidade de exemplares disponíveis.
O sistema deve ser capaz de registrar a devolução de livros, atualizando o status de disponibilidade no acervo e confirmando a data de devolução efetiva.
O sistema deve ser capaz de consultar a disponibilidade de livros no acervo, informando se estão disponíveis para empréstimo ou não.
O sistema deve ser capaz de remover registros de livros do acervo.
Usuário
O sistema deve ser capaz de cadastrar usuários, armazenando nome, matrícula e curso.
O sistema deve ser capaz de remover registros de usuários.
Empréstimo
O sistema deve ser capaz de registrar empréstimos de livros, vinculando-os a usuários previamente cadastrados e armazenando as datas de retirada e devolução previstas.
O sistema deve ser capaz de calcular automaticamente atrasos com base na data atual do sistema e na data de devolução prevista.
O sistema deve ser capaz de gerar relatórios que listem os livros atualmente emprestados, os usuários em atraso e o tempo de atraso (em dias).
Geral
O sistema deve ser capaz de salvar todos os dados registrados em arquivos, de modo que as informações sejam recuperadas na inicialização.
O sistema deve permitir o ajuste manual da data e hora do sistema.
O sistema deve ter um relógio interno que atualiza constantemente a data e hora atual, utilizando o serviço 30 do syscall do MARS.
O sistema deve exibir uma string padrão (banner) no início de cada linha do terminal, utilizando o formato: xxxxxx-shell>>, em que xxxxxx é o nome do sistema a escolha dos alunos.
O sistema vai ficar constantemente checando por entradas de texto
