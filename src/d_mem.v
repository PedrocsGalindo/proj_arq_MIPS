module d_mem #(
    parameter SIZE = 1024       
)(
    input wire [31:0] Address,   
    input wire [31:0] WriteData, 
    input wire MemWrite,         
    input wire MemRead,          
    output reg [31:0] ReadData   
);

    always @(*) begin
        if (MemRead) begin
            ReadData = memory[Address >> 2]; 
        end else begin
            ReadData = 32'bz;               // valor padrao (Z) quando não estiver lendo
        end
    end

    always @(*) begin
        if (MemWrite) begin
            memory[Address >> 2] = WriteData;
        end
    end

endmodule