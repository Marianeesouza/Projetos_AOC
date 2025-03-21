/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  somador PC + 4
*/

module somador_PC_4 (PC, somador_out);

	//Descrição das entradas e saídas:
   input wire [31:0] PC;   	 		// Valor atual do PC (Entrada)
   output wire [31:0] somador_out;  // Valor do pc + 4 (saída)

	//Comportamento:
   assign somador_out = PC + 4;   // Soma 4 ao endereço do PC e retorna o valor da soma

endmodule