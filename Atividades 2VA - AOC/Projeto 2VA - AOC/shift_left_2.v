/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da Silva
           Joao Victor Morais Barreto da Silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
   Descrição do arquivo: Shift Left 2 (desloca 2 bits a esquerda)
*/

module shift_left_2 (endereco_in, endereco_out);

   // Descrição das entradas e saídas:
   input wire [31:0] endereco_in;  		// Endereço expandido em 32 bits
   output wire [31:0] endereco_out; 	// Endereço deslocado 2 bits a esquerda

   // Comportamento:
   assign endereco_out = endereco_in << 2; // Multiplica por 4 deslocando 2 bits à esquerda

endmodule