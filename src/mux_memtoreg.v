module mux_memtoreg (
    input wire [31:0] ALUResult,
    input wire [31:0] MemData,
    input wire MemToReg,
    output wire [31:0] WriteData
);
    assign WriteData = MemToReg ? MemData : ALUResult;
endmodule