module ula_ctrl(
    input wire [1:0] ALUOp,
    input wire [5:0] func,
    output reg [3:0] OP
);
    always @(*) begin
        case(ALUOp)
            2'b00: OP = 4'b0010;    
            2'b01: OP = 4'b0110;    
            2'b10: begin            
                case(func)
                    6'b100000: OP = 4'b0001; 
                    6'b100010: OP = 4'b0010; 
                    6'b100100: OP = 4'b0011; 
                    6'b100101: OP = 4'b0100; 
                    6'b100110: OP = 4'b0101; 
                    6'b100111: OP = 4'b0110; 
                    6'b000000: OP = 4'b0111; 
                    6'b000010: OP = 4'b1000; 
                    6'b000011: OP = 4'b1001; 
                    6'b101010: OP = 4'b1010; 
                    6'b101011: OP = 4'b1011; 
                    6'b011000: OP = 4'b1100; 
                    6'b011001: OP = 4'b1100; 
                    6'b011010: OP = 4'b1101; 
                    6'b011011: OP = 4'b1101; 
                    6'b100001: OP = 4'b1110; 
                    6'b100011: OP = 4'b1111; 
                    default: OP = 4'b0000;   
                endcase
            end
            default: OP = 4'b1111;  
        endcase
    end

endmodule