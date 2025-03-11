/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da Silva
           Joao Victor Morais Barreto da Silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
   Descrição do arquivo: Memória de Dados (d_mem)
*/

					// O parametro MemSize tem por padrão valor 10, mas pode ser alterado no módulo top-level
module d_mem (Address, WriteData, ReadData, MemWrite, MemRead, clock);
	
	//Descrição das entradas e saidas:
	// O endereço de memória e o valor a ser escrito na memória (em caso de MemWrite=1) tem 32 bits
	input wire [31:0] Address, WriteData;
	// Sinais de controle 
	input wire MemWrite, MemRead;
	input wire clock;
	// Valor de saída lido no endereço dado tem 32 bits
	output reg [31:0] ReadData;
	
	parameter MemSize = 5;
	
	// A memória em si tem (2^MemSize) espaços de memória, de 32 bits cada
	reg [31:0] mem [0:(1 << MemSize) -1];
	
	
	always @ (posedge clock) begin // É ativado em qualquer mudança do cabeçalho
		if (Address > ((1 << MemSize) - 1))
			$display ("Endereço %d fora do limite!", Address);
		else begin
			if (MemRead)
				ReadData = mem[Address];
			else begin
				ReadData = 32'b0;
				if (MemWrite)
					mem[Address] = WriteData;
			end
		end
	end
endmodule