module regfile(
    input wire [4:0] ReadAddr1,
    input wire [4:0] ReadAddr2, 
    input wire clock,
    input wire [4:0] WriteAddr,
    input wire [31:0] WriteData,
    input wire RegWrite, 
    input wire Reset
    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2
);