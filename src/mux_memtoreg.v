module mux_memtoreg (
    input wire [31:0] ALUResult, MemData,
    input wire MemToReg,
    output wire [31:0] WriteData
);
    always @(*) begin
        if (MemToReg) 
            WriteData = MemData;
        else 
            RegDstOut = ALUResult;
    end
endmodule