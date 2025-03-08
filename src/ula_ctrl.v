module ula_ctrl(
    input wire [1;0] ALUOp,
    input wire [5:0] func,
    output wire [3:0] OP
);
    always @(*) begin
        case(ALUOp)
            2'b00: OP = 4'b0010;    // Soma (usado por LW, SW)
            2'b01: OP = 4'b0110;    // Subtração (usado por BEQ)
            2'b10: begin            // Instruções do tipo R
                case(func)
                    6'b100000: OP = 4'b0001; // ADD
                    6'b100010: OP = 4'b0010; // SUB
                    6'b100100: OP = 4'b0011; // AND
                    6'b100101: OP = 4'b0100; // OR
                    6'b100110: OP = 4'b0101; // XOR
                    6'b100111: OP = 4'b0110; // NOT (somente In1)
                    6'b000000: OP = 4'b0111; // SLL (Shift Left Logical)
                    6'b000010: OP = 4'b1000; // SRL (Shift Right Logical)
                    6'b000011: OP = 4'b1001; // SRA (Shift Right Arithmetic)
                    6'b101010: OP = 4'b1010; // SLT (Set Less Than)
                    6'b101011: OP = 4'b1011; // SLTU (Set Less Than Unsigned)
                    6'b011000: OP = 4'b1100; // MULT (Multiplicação)
                    6'b011001: OP = 4'b1100; // MULTU (Multiplicação sem sinal) - mesmo código
                    6'b011010: OP = 4'b1101; // DIV (Divisão)
                    6'b011011: OP = 4'b1101; // DIVU (Divisão sem sinal) - mesmo código
                    6'b100001: OP = 4'b1110; // ADDI (Incremento de 1)
                    6'b100011: OP = 4'b1111; // SUBI (Decremento de 1)
                    default: OP = 4'b0000;   // Caso inválido
                endcase
            end
            default: OP = 4'b1111;  // Operação invalida
        endcase
    end

endmodule