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
                    6'b100000: OP = 4'b0010; // ADD
                    6'b100010: OP = 4'b0110; // SUB
                    6'b100100: OP = 4'b0000; // AND
                    6'b100101: OP = 4'b0001; // OR
                    6'b101010: OP = 4'b0111; // SLT
                    default: OP = 4'b1111;   // Operação invalida
                endcase
            end
            default: OP = 4'b1111;  // Operação invalida
        endcase
    end

endmodule