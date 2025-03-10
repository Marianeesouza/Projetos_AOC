/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  Núcleo MIPS Monociclo
*/

/*Go to list: (apague a linha assim que você concluir ela)
			1 - Mari, após vc terminar o regfile e criar o cabo do read data 2, 
				 escreva entre os parênteses da entrada0 do mux2x1 mux_in_2_ALU o
				 nome dessa linha.
				 
			2 - Mari, após vc criar o cabo de saída do d_men não se esqueça de inicializar
				 o ALU_out (nas ultimas linhas desse arquivo tem um trecho pra isso, onde eu
				 já inicializei o PC_out) 
				 
			3 - Heitor, após vc criar o cabo de saída do ALU não se esqueça de inicializar
				 o d_mem_out  (nas ultimas linhas desse arquivo tem um trecho pra isso, onde eu
				 já inicializei o PC_out)
				 
			4- Heitor, após criar os cabos da ALU, fazer um assign do cabo_and_out inicializando ele
			   por meio de um and entre branch com o cabo Zero_flag
*/

module MIPS_Monociclo(clock, reset, PC_out, ALU_out, d_mem_out);
	
	//Descrição das entradas e saídas:
	input wire clock;                // sinal do clock
	input wire reset;			         // sinal do reset
	output wire [31:0] PC_out; 		// saida do pc
	output wire [31:0] ALU_out; 		// saida da ula
	output wire [31:0] d_mem_out; 	// saida da d_mem
	
	//Declaração dos cabos relacionado aos módulos:
	wire [31:0] cabo_PC_out; 						 			// cabo da saída do PC que conecta com outros 2 módulos (i_men e somador_pc_4)
	wire [31:0] cabo_somador_PC_4_out;     	 			// cabo da saída do somador do pc + 4 que conecta com outros 2 módulos (somador_pc_jump e mux_PC_next)
	wire [31:0] cabo_shift_left_2_para_somador_PC_jump;// Cabo de saída do Shift Left 2 que conecta com o somador_PC_jump
	wire [31:0] cabo_somador_PC_jump_para_mux_PC_next; // cabo de saída do cabo_somador_PC que conecta com mux_PC_next
	wire [31:0] cabo_mux_PC_next_para_PC;      			// cabo de saída do mux_PC_next que conecta com PC contendo o próximo valor do PC
	wire [31:0] cabo_i_men_out; 					 			// cabo de saída do i_men (esse cabo sera dividido em trocentas partes)
	wire [31:0] cabo_extensor_de_sinal_out; 	 			// cabo de saída do extensor de sinal que conecta 2 módulos (mux_in_2_ALU e shif_left_2)
	wire [31:0] cabo_mux_dest_reg_para_regfile;      	// cabo de saída do mux_dest_reg que conecta com regfile
	wire cabo_and_out;                         			// cabo de saída do and que sinaliza se irá ter um jump
	wire [31:0] cabo_mux_valor_write_data;					// cabo de saída do mux_valor_write_data que diz qual valor a ser escrito no reg destino
	wire [31:0] cabo_mux_in_2_ALU;							// cado de saída do mux_in_2_ALU que diz qual o 2º operando da ALU
	
	//Declaração do conjunto de cabos do i_men que conecta com 4 módulos (control, regfile, mux_dest_reg, extensor_de_sinal)
	wire [5:0] cabo_opcode, cabo_funct; 					// cabos dos bits para opcode e funct
	wire [4:0] cabo_rs, cabo_rt, cabo_rd, cabo_shamt;  // cabos dos bit para rs, rt, rd, shamt
	wire [15:0] cabo_extensor_de_sinal;                 // cabo para o extensor de sinal
	
	//separador dos campos da instrução vinda do cabo_i_men_out
	assign cabo_opcode = cabo_i_men_out[31:26];  				// separa os bits para opcode
	assign cabo_rs = cabo_i_men_out[25:21];  						// separa os bits para rs
	assign cabo_rt = cabo_i_men_out[20:16];  						// separa os bits para rt
	assign cabo_rd = cabo_i_men_out[15:11];  						// separa os bits para rd
	assign cabo_shamt = cabo_i_men_out[10:6]; 					// separa os bits para shamt
	assign cabo_funct = cabo_i_men_out[5:0];   					// separa os bits para funct
	assign cabo_extensor_de_sinal = cabo_i_men_out[15:0];  	// separa os bits para extensor de sinal
	
	// Cabos saídos do banco de registradores
	wire [31:0] valor_reg1;
	wire [31:0] valor_reg2;
	
	// Cabo do valor lido da memória
	wire [31:0] cabo_d_mem_out;
	 
	//Declaração do conjunto de cabos da unidade de controle:
	wire RegDst; 
	wire Branch;
	wire MemRead;	
	wire MemtoReg;
	wire [1:0] ALUOp;
	wire MemWrite; 
	wire ALUSrc;
	wire RegWrite; 
	wire Link;
	wire Jump;
	
	//Declaração dos módulos:
	
	//Declaração da instância do PC
	PC pc(
		.clock (clock),                  // Entrada: Cabo que contém o clock   
		.next_PC (cabo_mux_PC_next_PC),  // Entrada: cabo de saída do mux_PC_next contendo o valor do próximo pc
		.PC (cabo_PC_out)						// Saida:   cabo de saída do PC que possui o endereco atual do PC
	);
	
	i_men imen(
		endereco_PC(cabo_PC_out),      // Entrada: cabo que possui o valor atual do PC
		instrucao_out(cabo_i_men_out)  // Saída:   cabo que contém a intrução correspondente ao valor do PC
	);
	
	//Declaração  do somador do pc + 4
	somador_PC_4 somador_pc4(            		
		.PC(cabo_PC_out),                     	// Entrada: Cabo que contem o valor atual do PC
		.somador_out(cabo_somador_PC_4_out)    // Saida:   Cabo de saída do somador que possui o valor do PC + 4
	);
	
	//Declaração  do somador do pc jump
	somador_PC_jump somador_jump(
		.endereco_PC(cabo_somador_PC_4_out),                         // Entrada:  Cabo que possui o valor do PC + 4
		.endereco_deslocado(cabo_shift_left_2_para_somador_PC_jump), // Entrada:  cabo que possui o endereço com 2 bits deslocado
		.endereco_jump(cabo_somador_PC_jump_para_mux_PC_next)        // Saida:    cabo que possui o novo endereco do PC
	);
	
	//Declaração da instância do shift left 2
	shift_left_2 sll2(
		.endereco_in(cabo_extensor_de_sinal_out),              // Entrada: cabo de saída do extensor de sinal, contendo o endereço em 32 bits
		.endereco_out(cabo_shift_left_2_para_somador_PC_jump)  // Saída: 	 cabo de saída que contem o endereço 2 bits deslocado que vai para somardor_PC_jump  
	);
	
	//Declaração da instância do extensor de sinal
	extensor_de_sinal extensor (
		.imediato(cabo_extensor_de_sinal),         // Entrada: parte imediata da instrução
		.extensor_out(cabo_extensor_de_sinal_out)  // Saída: 	 imediato estendido para 32 bits
	);
	
	//Declaração da instância da Memória de Dados
	//MemSize define a quantidade de endereços disponíveis (2^MemSize endereços disponíveis)
	d_mem #(MemSize(10)) d_mem (
	.Address(ALU_out), 
	.WriteData(valor_reg2), 
	.ReadData(cabo_d_mem_out), 
	.MemWrite(MemWrite), 
	.MemRead(MemRead)
	);
	
	//Declaração da instância do Banco de Registradores
	regfile regfile (
		.ReadAddr1(cabo_rs), 
		.ReadAddr2(cabo_rt), 
		.ReadData1(valor_reg1), 
		.ReadData2(valor_reg2), 
		.WriteAddr(cabo_mux_dest_reg_regfile), 
		.WriteData(cabo_mux_valor_write_data), 
		.clock(clock), 
		.reset(reset), 
		.RegWrite(RegWrite)
	);
	
	//Declaração dos multiplexadores:
	
	//Declaração da instância do mux2x1 que une a saída do somador_pc_4 com a saída do somador_pc_jump para definir qual será o próximo valor do pc
	mux2x1 mux_PC_next (
      .entrada0(somador_PC_4_out),  	 // Entrada: Cabo que contém PC + 4
		.entrada1(jump_address),          // Entrada: Cabo que contem o endereco do pc jump 
		.seletor(cabo_and_out),           // Entrada: Cabo que tem o sinal para ocorrer o jump
		.saida(cabo_mux_PC_next_PC)       // Saída: 	 Cabo que vai para o PC
	);
	
	//Declaração da instância do mux 2x1 que une a saída de Read data 2 com cabo_extensor_de_sinal_out para definir a caminho da ALU 
	mux2x1 mux_in_2_ALU (
		.entrada0(valor_reg2),  	 		  			// Entrada: Cabo do read data 2
		.entrada1(cabo_extensor_de_sinal_out),   	// Entrada: Cabo que que contem a saída do extensor de sinal 
		.seletor(ALUSrc),           		 		  	// Entrada: Cabo que tem o sinal para definir o 2° operando da ula 
		.saida(cabo_mux_dest_reg_para_regfile)   	// Saída:   Cabo que vai para o 2° operando da ula 
	);
	
	//Declaração da instância do mux 2x1 que define se o reg de destino é o rt ou rd
	mux2x1 mux_dest_reg (
		.entrada0(cabo_rt),  	 		  			  // Entrada: Cabo rs
		.entrada1(cabo_rd),   						  // Entrada: Cabo rd 
		.seletor(RegDst),           		 		  // Entrada: Cabo que tem o sinal para definir o reg de destino
		.saida(cabo_mux_dest_reg_regfile)        // Saída:   Cabo que vai para write register em regfile
	);
	
	//Declaração da instância do mux2x1 que diz se o WriteData vem da memória ou da ALU
	mux2x1 mux_valor_write_data (
		.entrada0(ALU_out),  	 		  			  	// Entrada: Valor calculado pela ALU
		.entrada1(d_mem_out),   						// Entrada: Valor lido da memória 
		.seletor(MemtoReg),           		 		// Entrada: Cabo que tem o sinal para definir qual o valor a ser usado
		.saida(cabo_mux_valor_write_data)        	// Saída:   Cabo que vai para WriteData em regfile
	);
	
	control uc (
        .opcode(cabo_opcode),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .Link(Link)
    );
	
	// Inicialização das saídas do programa
	assign PC_out = cabo_PC_out;
	assign d_mem_out = cabo_d_mem_out;
	
	
endmodule