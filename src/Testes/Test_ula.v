module testbench;

    // Declaração de variáveis
    reg [31:0] In1, In2;
    reg [3:0] OP;
    wire [31:0] result;
    wire Zero_flag;

    // Instancia o módulo ULA
    ula uut (
        .In1(In1),
        .In2(In2),
        .OP(OP),
        .result(result),
        .Zero_flag(Zero_flag)
    );

    // Teste
    initial begin
        // Inicializando sinais
        In1 = 32'b0;
        In2 = 32'b0;
        OP = 4'b0000;

        // Teste de operação de adição (OP = 0001)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b0001;  // 10 + 5
        #10;  // Espera 10 unidades de tempo
        $display("Resultado de %d + %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de subtração (OP = 0010)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b0010;  // 10 - 5
        #10;
        $display("Resultado de %d - %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação AND (OP = 0011)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b0011;  // 10 & 5
        #10;
        $display("Resultado de %d & %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação OR (OP = 0100)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b0100;  // 10 | 5
        #10;
        $display("Resultado de %d | %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação XOR (OP = 0101)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b0101;  // 10 ^ 5
        #10;
        $display("Resultado de %d ^ %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de NOT (OP = 0110)
        In1 = 32'd10;  In2 = 32'b0; OP = 4'b0110;  // ~10
        #10;
        $display("Resultado de ~%d = %d, Zero_flag = %b", In1, result, Zero_flag);

        // Teste de operação de deslocamento à esquerda (OP = 0111)
        In1 = 32'd10;  In2 = 32'd2; OP = 4'b0111;  // 10 << 2
        #10;
        $display("Resultado de %d << %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de deslocamento à direita (OP = 1000)
        In1 = 32'd10;  In2 = 32'd2; OP = 4'b1000;  // 10 >> 2
        #10;
        $display("Resultado de %d >> %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de deslocamento aritmético à direita (OP = 1001)
        In1 = 32'd10;  In2 = 32'd2; OP = 4'b1001;  // 10 >>> 2
        #10;
        $display("Resultado de %d >>> %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de comparação (OP = 1010)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b1010;  // 10 < 5
        #10;
        $display("Resultado de %d < %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de multiplicação (OP = 1100)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b1100;  // 10 * 5
        #10;
        $display("Resultado de %d * %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de divisão (OP = 1101)
        In1 = 32'd10;  In2 = 32'd5; OP = 4'b1101;  // 10 / 5
        #10;
        $display("Resultado de %d / %d = %d, Zero_flag = %b", In1, In2, result, Zero_flag);

        // Teste de operação de incremento (OP = 1110)
        In1 = 32'd10;  In2 = 32'b0; OP = 4'b1110;  // 10 + 1
        #10;
        $display("Resultado de %d + 1 = %d, Zero_flag = %b", In1, result, Zero_flag);

        // Teste de operação de decremento (OP = 1111)
        In1 = 32'd10;  In2 = 32'b0; OP = 4'b1111;  // 10 - 1
        #10;
        $display("Resultado de %d - 1 = %d, Zero_flag = %b", In1, result, Zero_flag);

        // Finaliza a simulação
        $finish;
    end
endmodule
