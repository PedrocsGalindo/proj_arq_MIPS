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
    
    reg [31:0] registradores[31:0]; // vetor de 32 registradores de 32 bits 
    interger i; // ponteiro para os registradores

    //dados lidos
    assign ReadData1 = regs[ReadAddr1];
    assign ReadData2 = regs[ReadAddr2];

    // subida do clock ou reset = 1
    always @(posedge Clock or posedge Reset) begin

        // verifica se foi o reset
        if(Reset) begin

            //Reseta todos os registradores
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        
        // Caso tenha sido na subida do clock
        end else begin

        // verifica se RegWrite = 1, e se não é o $0
        if (RegWrite && (WriteAddr != 5'd0))
        
            regs[WriteAddr] <= WriteData;       //escrita no registrador desejado
        end
    end
endmodule

