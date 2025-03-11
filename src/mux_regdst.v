module mux_regdst (
    input wire [4:0] rt,
    input wire [4:0] rd,
    input wire RegDst,
    output wire [4:0] RegDstOut
);
    assign RegDstOut = RegDst ? rd : rt;
endmodule