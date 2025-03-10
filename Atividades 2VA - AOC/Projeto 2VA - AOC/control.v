/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  somador PC + 4
*/


module control(opcode, RegDst, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);

	input wire [5:0] opcode;
	output reg RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Jump;
	output reg [1:0] ALUOp;

	
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
    ALUOp    = 2'b00; // vetor de 2 bits iniciado com 00
	 
	 
		case(opcode)
	 // Instrucao lw
		6'b100011: begin
			ALUSrc   = 1;
			MemToReg = 1;
			RegWrite = 1;
			ALUOp    = 2'b00;
		end
	 // Instrucao sw
	   6'b101011: begin
			ALUSrc	= 1;
			MemWrite = 1;
			ALUOp		= 2'b00;
			
		end
	 // Instrucoes tipo R
		6'b000000: begin
			RegDst   = 1;
			RegWrite = 1;
			ALUOp    = 2'b10;
		end
		// Instrucao BEQ
		6'b000100: begin
		Branch=1;
		ALUOp=01;
		end
		
		// Instrucao BNE
		6'b000101: begin
		Branch=1;
		ALUOp=01;
		end
		
		// Instrução J (Jump)
		6'b000010: begin
			Jump = 1;
		end

      // Instrução JAL (Jump and Link)
		6'b000011: begin          
			RegWrite = 1;
			Jump = 1;
		end

      // Instrução ADDI (Add Immediate)
		6'b001000: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 2'b00;
		end

      // Instrução ANDI (And Immediate)
		6'b001100: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 2'b10;
		end

      // Instrução ORI (Or Immediate)
		6'b001101: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 2'b10;
		end
		
		// Instruçao XORI (XOR Imadiate)
		6'b001110: begin
			ALUSrc = 1;
			RegWrite = 1;
			ALUOp = 2'b10;
		end 

		// Instrução SLTI (Set Less Than Immediate)
		6'b001010: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 2'b11;			
		end
		
		// Instrução SLTIU (Set Less Than Immediate Unsigned)
		6'b001011: begin
			ALUSrc   = 1;
			RegWrite = 1;
			ALUOp    = 2'b11;			
		end
		
		// Instruçao LUI
		6'b001111: begin
			ALUSrc = 1;
			RegWrite = 1;
		end
		
		default: begin
		end
	 endcase
	 
	end
	
endmodule 
