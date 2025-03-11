module i_mem (
    input wire [31:0] address,
    output reg [31:0] i_out
);
    reg [31:0] memory [0:63]; // Memória de 64 palavras de 32 bits

    initial begin
        $readmemb("instructions.list", memory); // Lê o arquivo binário linha por linha
    end

    always @(address) begin
        i_out = memory[address >> 2]; // Alinhamento com 32 bits
    end
endmodule