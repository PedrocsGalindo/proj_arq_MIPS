module mux_pcsrc (
    input wire [31:0] PC4, BranchAddr, JumpAddr,
    input wire [1:0] PCSrc,
    output reg [31:0] NextPC
);
    always @(*) begin
        case (PCSrc)
            2'b00: NextPC = PC4;
            2'b01: NextPC = BranchAddr;
            default: NextPC = JumpAddr;
        endcase
    end
endmodule