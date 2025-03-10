module ula (
    input wire [31:0] In1,    
    input wire [31:0] In2,
    input wire [3:0] OP,
    output reg [31:0] result,
    output reg Zero_flag
);
    always @(*) begin
        case (OP)
            4'b0001: result = In1 + In2;                        
            4'b0010: result = In1 - In2;                        
            4'b0011: result = In1 & In2;                        
            4'b0100: result = In1 | In2;                        
            4'b0101: result = In1 ^ In2;                        
            4'b0110: result = ~In1;                             
            4'b0111: result = In1 << In2;                       
            4'b1000: result = In1 >> In2;                       
            4'b1001: result = $signed(In1) >>> In2;             
            4'b1010: result = (In1 < In2) ? 1 : 0;              
            4'b1011: result = (In1 < In2) ? 1 : 0;              
            4'b1100: result = In1 * In2;                        
            4'b1101: result = (In2 != 0) ? In1 / In2 : 32'b0;   
            4'b1110: result = In1 + 1;                          
            4'b1111: result = In1 - 1;                          
            default: result = 32'b0;                            
        endcase
    
        Zero_flag = (result == 32'b0) ? 1'b1 : 1'b0;            
    end
    
endmodule