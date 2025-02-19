`timescale 1ns/1ps  // Define unidade de tempo como 1ns e precisão de 1ps, pode causar problemas sem isso

module pc (
    input wire clock,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);
    
    initial begin
        PC = 0;  // Inicializa PC em 0
    end

    always @(posedge clock) begin
        PC <= nextPC;  // Atualiza PC na subida do clock
    end

endmodule
