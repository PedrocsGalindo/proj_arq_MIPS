module mux_regdst (
    input wire [4:0] rt, rd,
    input wire RegDst,
    output reg [4:0] RegDstOut
);
    always @(*) begin
        if (RegDst) 
            RegDstOut = rd;
        else 
            RegDstOut = rt;
    end
endmodule