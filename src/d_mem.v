module i_mem (
    input wire [31:0] Adress,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData,
    input wire MemWrite
);
    always @(posedge MemWrite) begin
        
    end