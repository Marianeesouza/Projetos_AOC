/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  Contador de Programa (PC)
*/

module PC (clock, next_PC, PC);

	//Descrição das entradas e saidas:
   input wire clock;             	 // Clock (atualiza na borda de subida)
   input wire [31:0] next_PC;     	 // Próximo valor do PC 
   output reg [31:0] PC;     			 // Valor atual do PC   

	//Comportamento:
   always @(posedge clock) begin
      PC <= next_PC; 			 		 // Atualiza o PC atual para o próximo endereço fornecido pelo next_PC
   end

endmodule