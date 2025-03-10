module pc (
    input wire clock,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);
    initial begin
        PC = 0;  
    end

    always @(posedge clock) begin
        PC <= nextPC;  
    end
endmodule