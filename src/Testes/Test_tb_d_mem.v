module tb_d_mem;

    // Definindo os sinais para o módulo de memória
    reg [31:0] Address;
    reg [31:0] WriteData;
    reg MemWrite;
    reg MemRead;
    wire [31:0] ReadData;

    // Instanciando o módulo d_mem
    d_mem uut (
        .Address(Address),
        .WriteData(WriteData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(ReadData)
    );

    // Inicialização
    initial begin
        // Inicializando os sinais
        MemWrite = 0;
        MemRead = 0;
        Address = 32'b0;
        WriteData = 32'b0;

        // Teste de escrita na memória
        #10;
        Address = 32'h4;  // Endereço 4 (palavra 1)
        WriteData = 32'hA5A5A5A5;  // Dados a serem escritos
        MemWrite = 1;  // Ativar MemWrite
        #10;
        MemWrite = 0;  // Desativar MemWrite

        // Teste de leitura da memória
        #10;
        MemRead = 1;  // Ativar MemRead
        #10;
        MemRead = 0;  // Desativar MemRead

        // Verificando o resultado
        if (ReadData != 32'hA5A5A5A5) begin
            $display("Erro: Dados lidos não correspondem aos dados escritos!");
        end else begin
            $display("Sucesso: Dados lidos correspondem aos dados escritos.");
        end

        // Teste de escrita em outro endereço
        #10;
        Address = 32'h8;  // Endereço 8 (palavra 2)
        WriteData = 32'h12345678;  // Novos dados a serem escritos
        MemWrite = 1;  // Ativar MemWrite
        #10;
        MemWrite = 0;  // Desativar MemWrite

        // Teste de leitura do novo endereço
        #10;
        MemRead = 1;  // Ativar MemRead
        #10;
        MemRead = 0;  // Desativar MemRead

        // Verificando o resultado
        if (ReadData != 32'h12345678) begin
            $display("Erro: Dados lidos não correspondem aos dados escritos!");
        end else begin
            $display("Sucesso: Dados lidos correspondem aos dados escritos.");
        end

        // Finalizando a simulação
        $finish;
    end

endmodule
