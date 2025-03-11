/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  somador PC + 4
*/


module control(opcode, RegDst, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, Link);

	input wire [5:0] opcode;
	output reg RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Jump, Link;
	output reg [3:0] ALUOp;

	
	always @ (opcode) begin	            // Sensível a mudança de opcode
	// Inicializa todos os sinais com 0
    RegDst   = 0;
    ALUSrc   = 0;
    MemToReg = 0;
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
	 Jump 	 = 0;
	 Link		 = 0;
    ALUOp    = 4'b0000; // vetor de 2 bits iniciado com 00
	 
	 
		case(opcode)
	 // Instrucao lw
		6'b100011: begin
			ALUSrc   = 1;
			MemRead	= 1;
			MemToReg = 1;
			RegWrite = 1;
		end
	 // Instrucao sw
	   6'b101011: begin
			ALUSrc	= 1;
			MemWrite = 1;
			
		end
	 // Instrucoes tipo R
		6'b000000: begin
			RegDst   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1111;
		end
		// Instrucao BEQ
		6'b000100: begin
			Branch=1;
			ALUOp=4'b0100;
		end
		
		// Instrucao BNE
		6'b000101: begin
			Branch=1;
			ALUOp=4'b0101;
		end
		
		// Instrução J (Jump)
		6'b000010: begin
			Jump = 1;
		end

      // Instrução JAL (Jump and Link)
		6'b000011: begin          
			RegWrite = 1;
			Link	= 1;
			Jump = 1;
		end

      // Instrução ADDI (Add Immediate)
		6'b001000: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1000;
		end

      // Instrução ANDI (And Immediate)
		6'b001100: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1100;
		end

      // Instrução ORI (Or Immediate)
		6'b001101: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1101;
		end
		
		// Instruçao XORI (XOR Imadiate)
		6'b001110: begin
			ALUSrc = 1;
			RegWrite = 1;
			ALUOp = 4'b1110;
		end 

		// Instrução SLTI (Set Less Than Immediate)
		6'b001010: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1010;			
		end
		
		// Instrução SLTIU (Set Less Than Immediate Unsigned)
		6'b001011: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 4'b1011;			
		end
		
		// Instruçao LUI (Load Unsigned Immediate)
		6'b001111: begin
			ALUSrc 	= 1;
			RegWrite = 1;
			ALUOp 	= 4'b1111;
		end
		
		default: begin
		end
	 endcase
	 
	end
	
endmodule 
