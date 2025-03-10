module ShiftLeft2 (
    input wire [31:0] in,   // Entrada de 32 bits
    output wire [31:0] out  // Saída de 32 bits
);
    assign out = in << 2; // Desloca 2 posições à esquerda
endmodule
