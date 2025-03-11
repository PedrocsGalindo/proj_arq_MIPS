module pc (
    input wire clock,
    input wire reset,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            PC <= 32'b0; // Resetar o PC para 0
        end else begin
            PC <= nextPC; // Atualizar o PC com o próximo valor
        end
    end

endmodule