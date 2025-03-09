// Projeto 2 VA - Arquitetura e Organização de Computadores - 2024.2
// Alunos: Heitor Leander Feitosa da silva,
//                   Joao victor Morais Barreto da silva
//                   Mariane Elisa dos Santos Souza
//                   Samuel Roberto de Carvalho Bezerra
// Descrição do arquivo:  Unidade de controle


module unidade_controle(opcode, RegDst, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);

	input logic [31:26] opcode;
	output logic RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
	output logic [1:0] ALUOp;

	
	always_comb begin
	// Inicializa todos os sinais com 0
    RegDst   = 0;
    ALUSrc   = 0;
    MemToReg = 0;
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    ALUOp    = 2'b00; // vetor de 2 bits iniciado com 00
	 
	 
		case(opcode)
	 // Instrucao lw
		6'b100011
			ALUSrc   = 1;
			MemToReg = 1;
			RegWrite = 1;
			ALUOp    = 2'b00;
		end
	 // Instrucao sw
	   6'b101011
			ALUSrc	= 1;
			MemWrite = 1;
			ALUOp		= 2'b00;
			
		end
	 // Instrucoes tipo R
		6'b000000
			RegDst   = 1;
			RegWrite = 1;
			ALUOp    = 2'b10;
		end
		
	 endcase
	
endmodule 
