/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da Silva
           Joao Victor Morais Barreto da Silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
   Descrição do arquivo: Memória de Dados (d_mem)
*/

module d_mem (addrs, wData, rData, MemWrite, MemRead);

	//Descrição das entradas e saidas:
	// O endereço de memória e o valor a ser escrito na memória (em caso de MemWrite=1) tem 32 bits
	input wire [0:31] addrs, rData;
	// Sinais de controle 
	input wire MemWrite, MemRead;
	// Valor de saída lido no endereço dado tem 32 bits
	output wire [0:31] wData;
	
	// A memória em si tem 32 regs, de 32 bits cada, totalizando 1024 bits
	reg [31:0] mem [0:1023];
	assign entrada = addrs % 1024