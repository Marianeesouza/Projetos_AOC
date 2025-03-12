/* Projeto 2° VA - Arquitetura e Organização de Computadores - 2024.2
   Alunos: Heitor Leander Feitosa da silva
           Joao victor Morais Barreto da silva
           Mariane Elisa dos Santos Souza
           Samuel Roberto de Carvalho Bezerra
    Descrição do arquivo:  Contador de Programa (PC)
*/

module PC (clock, next_PC, PC, reset);

    // Descrição das entradas e saídas:
    input wire clock;               // Clock (atualiza na borda de subida)
    input wire [31:0] next_PC;      // Próximo valor do PC 
    input wire reset;               // Sinal de reset
    output reg [31:0] PC;           // Valor atual do PC

    // Comportamento:
    always @(posedge clock) begin
        if (reset)
            PC <= 32'b0;            // Se reset for 1, PC recebe 0
        else
            PC <= next_PC;          // Se reset for 0, PC recebe next_PC
    end

endmodule