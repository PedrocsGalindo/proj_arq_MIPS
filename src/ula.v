module ula (
    input wire [31:0] In1,    
    input wire [31:0] In2,
    input wire [3:0] OP,
    output wire [31:0] result,
    output wire Zero_flag
);
    always @(*) begin
        case (OP)
            4'b0001: result = In1 + In2;                        // 1. Soma
            4'b0010: result = In1 - In2;                        // 2. Subtração
            4'b0011: result = In1 & In2;                        // 3. AND bit a bit
            4'b0100: result = In1 | In2;                        // 4. OR bit a bit
            4'b0101: result = In1 ^ In2;                        // 5. XOR bit a bit
            4'b0110: result = ~In1;                             // 6. NOT bit a bit (aplicado apenas a In1)
            4'b0111: result = In1 << In2;                       // 7. Deslocamento lógico à esquerda
            4'b1000: result = In1 >> In2;                       // 8. Deslocamento lógico à direita
            4'b1001: result = $signed(In1) >>> In2;             // 9. Deslocamento aritmético à direita
            4'b1010: result = (In1 < In2) ? 1 : 0;              // 10. Set Less Than (SLT)
            4'b1011: result = (In1 < In2) ? 1 : 0;              // 11. Set Less Than Unsigned (SLTU)
            4'b1100: result = In1 * In2;                        // 12. Multiplicação (se suportada)
            4'b1101: result = (In2 != 0) ? In1 / In2 : 32'b0;   // 13. Divisão (evita divisão por zero)
            4'b1110: result = In1 + 1;                          // 14. Incremento
            4'b1111: result = In1 - 1;                          // 15. Decremento
            default: result = 32'b0;                            // Caso padrão (operação inválida retorna 0)
        endcase
    
        if (result == 32'b0) begin                              // 16. Comparação de igualdade (Zero_flag)
            Zero_flag = 1'b1;       // Ativa se for 0
        end else begin
            Zero_flag = 1'b0;       // desativa
        end
            Zero_flag = (result == 32'b0) ? 1'b1 : 1'b0;            
        end
    
endmodule