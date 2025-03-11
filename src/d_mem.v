module d_mem (
    input wire [31:0] Address,
    input wire [31:0] WriteData,
    input wire MemWrite,
    input wire MemRead,
    output reg [31:0] ReadData
);
    reg [31:0] memory [0:63]; // Memória de 64 palavras de 32 bits

    always @(posedge MemWrite) begin
        if (MemWrite) begin
            memory[Address >> 2] <= WriteData; // Escreve na memória
        end
    end

    always @(posedge MemRead) begin
        if (MemRead) begin
            ReadData <= memory[Address >> 2]; // Lê da memória
        end else begin
            ReadData <= 32'bz; // High impedance quando não está lendo
        end
    end
endmodule