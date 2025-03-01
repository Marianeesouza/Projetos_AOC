/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  mux2x1 
*/

module mux2x1 (in1, in2, sel, out);
    
	//Descrição das entradas e sinais:
	input wire [31:0] in1;  	  // Entrada 1
   input wire [31:0] in2;  	  // Entrada 2
   input wire sel;              // Sinal de seleção
   output wire [31:0] out;  	  // Saída do mux

	//Comportamento:
   assign out = sel ? in2 : in1; // Seleciona in2 se sel = 1, senão seleciona in1

endmodule

