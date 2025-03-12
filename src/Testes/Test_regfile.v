module tb_regfile;

    // Definindo os sinais de entrada e saída
    reg [4:0] ReadAddr1;
    reg [4:0] ReadAddr2;
    reg clock;
    reg [4:0] WriteAddr;
    reg [31:0] WriteData;
    reg RegWrite;
    reg Reset;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    // Instanciando o módulo regfile
    regfile uut (
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .clock(clock),
        .WriteAddr(WriteAddr),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .Reset(Reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Gerador de clock
    always begin
        #5 clock = ~clock; // Gera um clock de 10 unidades de tempo
    end

    // Inicialização do teste
    initial begin
        // Inicializando sinais
        clock = 0;
        Reset = 0;
        RegWrite = 0;
        WriteAddr = 5'b0;
        WriteData = 32'b0;
        ReadAddr1 = 5'b0;
        ReadAddr2 = 5'b0;

        // Teste 1: Reset dos registradores
        #10;
        Reset = 1;  // Ativa o Reset
        #10;
        Reset = 0;  // Desativa o Reset

        // Verifica se todos os registradores foram zerados
        if (ReadData1 != 32'b0) $display("Erro: Registrador 1 não está zerado após reset.");
        if (ReadData2 != 32'b0) $display("Erro: Registrador 2 não está zerado após reset.");

        // Teste 2: Escrita no registrador
        #10;
        WriteAddr = 5'b00001; // Endereço de registrador 1
        WriteData = 32'hDEADBEEF; // Dados a serem escritos
        RegWrite = 1; // Ativa a escrita
        #10;
        RegWrite = 0; // Desativa a escrita

        // Lendo o valor gravado
        ReadAddr1 = 5'b00001; // Lê o registrador 1
        #10;
        if (ReadData1 != 32'hDEADBEEF) $display("Erro: Dados não gravados corretamente no registrador 1.");

        // Teste 3: Leitura de dois registradores
        #10;
        WriteAddr = 5'b00010; // Endereço de registrador 2
        WriteData = 32'hCAFEBABE; // Dados a serem escritos
        RegWrite = 1; // Ativa a escrita
        #10;
        RegWrite = 0; // Desativa a escrita

        // Lendo o registrador 2
        ReadAddr2 = 5'b00010; // Lê o registrador 2
        #10;
        if (ReadData2 != 32'hCAFEBABE) $display("Erro: Dados não gravados corretamente no registrador 2.");

        // Teste 4: Verificando que a leitura de um registrador não afeta outro
        #10;
        if (ReadData1 != 32'hDEADBEEF) $display("Erro: Dados de registrador 1 foram alterados inesperadamente.");

        // Finalizando o teste
        $finish;
    end

endmodule
