module mux_regdst (
    input wire [4:0] rt, rd,
    input wire RegDst,
    output wire [4:0] RegDstOut
);
    always @(*) begin
        if (RegDst) 
            RegDstOut = rt
        else 
            RegDstOut = rd
    end
endmodule