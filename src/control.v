module control(
    input logic [5:0] opcode,  // Código da operação da instrução
    output logic RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump,
    output logic [1:0] ALUOp
);
    always @(*) begin
        // Valores padrão
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        Jump = 0;
        ALUOp = 2'b00;

        case (opcode)
            6'b000000: begin // Tipo R (add, sub, and, or, slt, etc.)
                RegDst = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                ALUOp = 2'b10;
            end
            6'b100011: begin // lw (Load Word)
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                ALUOp = 2'b00;
            end
            6'b101011: begin // sw (Store Word)
                ALUSrc = 1;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                ALUOp = 2'b00;
            end
            6'b000100: begin // beq (Branch if Equal)
                ALUSrc = 0;
                RegWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
            end
            6'b000010: begin // j (Jump)
                Jump = 1;
            end
            default: begin // Caso padrão (NOP ou instrução desconhecida)
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                ALUOp = 2'b00;
            end
        endcase
    end
endmodule

 