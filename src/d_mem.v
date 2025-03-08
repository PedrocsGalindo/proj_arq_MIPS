module d_mem #(
    parameter SIZE = 1024       
)(
    input wire [31:0] Address,   
    input wire [31:0] WriteData, 
    input wire MemWrite,         
    input wire MemRead,          
    output reg [31:0] ReadData   
);

    reg [31:0] memory [0:SIZE-1]

    always @(posedge MemWrite) begin

    end
    always @(posedge MemRead) begin

    end