module regfile (
    input wire [4:0] ReadAddr1,
    input wire [4:0] ReadAddr2,
    input wire clock,
    input wire [4:0] WriteAddr,
    input wire [31:0] WriteData,
    input wire RegWrite,
    input wire Reset,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2
);
    reg [31:0] registers [0:31]; // 32 registradores de 32 bits

    integer i;

    always @(posedge clock or posedge Reset) begin
        if (Reset) begin
            // Inicializa os registradores com 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (RegWrite) begin
            registers[WriteAddr] <= WriteData; // Escreve no registrador
        end
    end

    always @(*) begin
        ReadData1 = registers[ReadAddr1]; // Lê do registrador
        ReadData2 = registers[ReadAddr2]; // Lê do registrador
    end
endmodule