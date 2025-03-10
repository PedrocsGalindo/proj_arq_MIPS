module BranchAdder (
    input wire [31:0] pc,        // Endereço atual do PC
    input wire [31:0] offset,    // Offset já deslocado à esquerda
    output wire [31:0] branch    // Endereço de destino do branch
);
    assign branch = pc + offset; // Apenas soma o PC com o deslocamento já ajustado
endmodule
