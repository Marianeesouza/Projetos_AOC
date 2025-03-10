/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
	Descrição do arquivo:  Módulo ULA 
	
	Realiza operações aritméticas e lógicas conforme o sinal OP recebido.

*/ 

module ULA(in1, in2, OP, shamt, result, zero_flag);
    // Descrição das portas
    input  wire [31:0] in1;   // Operando 1 (32 bits)
    input  wire [31:0] in2;   // Operando 2 (32 bits)
    input  wire [3:0]  OP;    // Operação a ser realizada (4 bits) – vindo da ULA_CTRL
    input  wire [4:0]  shamt; // Quantidade de deslocamento para shift
    output reg  [31:0] result;  // Resultado da operação (32 bits)
    output wire       zero_flag; // Flag que indica se o resultado é zero

    // Bloco combinacional: Seleciona a operação com base no código OP
    always @(*) begin
        case(OP)
            4'b0000: result = in1 & in2;               // AND
            4'b0001: result = in1 | in2;               // OR
            4'b0010: result = in1 + in2;               // ADD
            4'b0011: result = in1 << in2;              // SLLV (Shift Left Logical Variable)
            4'b0100: result = in1 >> in2;              // SRLV (Shift Right Logical Variable)
            4'b0101: result = $signed(in1) >>> in2;    // SRAV (Shift Right Arithmetic Variable)
            4'b0110: result = in1 - in2;               // SUB
            4'b0111: result = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0; // SLT
            4'b1000: result = in1 - in2;               // Caso especial para BNE
            4'b1001: result = in1 << shamt;            // SLL (Shift Left Logical com shamt)
            4'b1010: result = in1 >> shamt;            // SRL (Shift Right Logical com shamt)
            4'b1011: result = in1 ^ in2;               // XOR
            4'b1100: result = ~(in1 | in2);            // NOR
            4'b1101: result = $signed(in1) >>> shamt;  // SRA (Shift Right Arithmetic com shamt)
            4'b1111: result = (in1 < in2) ? 32'b1 : 32'b0; // SLTU (Set Less Than Unsigned)
            default: result = 32'b0;                   // Valor padrão
        endcase
    end

    // A flag zero_flag é ativada se o resultado for zero ou se for BNE e resultado diferente de zero
    assign zero_flag = (result == 32'b0) || (OP == 4'b1000 && result != 32'b0);

endmodule
