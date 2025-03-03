/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da Silva
           Joao Victor Morais Barreto da Silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
   Descrição do arquivo: Banco de Registradores (regfile)
*/

module regfile (rReg1, rReg2, rData1, rData2, wData, wRegAddrs, RegWrite, clock, reset);
	
	//Descrição das entradas e saidas:
	input wire clock, reset, RegWrite; 				// Sinais relacionados ao clock e o módulo de controle
	// Os endereços dos registradores são de 0 até 31, ou seja, são constituídos por 5bits
	input wire [4:0] rReg1, rReg2, wRegAddrs; 	//endereços dos dois registradores de entrada e do de saída
	// Os valores que podem ser escritos nos registradores têm 32 bits
	input wire [31:0] wData;							// Valor a ser colocado no registrador de destino
	output wire [31:0] rData1, rData2;				// Valores dos registradores de entrada
	
	// Banco de Registradores
	// São 32 registradores, cada um com 32 bits
	input wire [31:0] regs [0:31];
	
	