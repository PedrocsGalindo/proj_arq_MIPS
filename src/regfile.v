module regfile (
    input wire [4:0] ReadAddr1,  
    input wire [4:0] ReadAddr2,  
    input wire clock,            
    input wire [4:0] WriteAddr,  
    input wire [31:0] WriteData, 
    input wire RegWrite,         
    input wire Reset,            
    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2 
);

    reg [31:0] registradores [31:0]; 
    integer i;

    assign ReadData1 = registradores[ReadAddr1];
    assign ReadData2 = registradores[ReadAddr2];

    always @(posedge clock or posedge Reset) begin
        if (Reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registradores[i] <= 32'b0;
            end
        end else if (RegWrite && (WriteAddr != 5'd0)) begin
            registradores[WriteAddr] <= WriteData;
        end
    end

endmodule