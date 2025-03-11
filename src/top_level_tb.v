`timescale 1ns/1ps

module top_level_tb;

    reg clock;
    reg reset;
    wire [31:0] PC_out;
    wire [31:0] ULA_out;
    wire [31:0] MemData_out;
    wire [31:0] instruction_out; // Adicione esta linha para monitorar a instrução

    // Instância do módulo top_level
    top_level uut (
        .clock(clock),
        .reset(reset),
        .PC_out(PC_out),
        .ULA_out(ULA_out),
        .MemData_out(MemData_out),
        .instruction_out(instruction_out) // Adicione esta linha para conectar a instrução
    );

    // Gerador de clock
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Clock com período de 10 unidades de tempo
    end

    // Sequência de reset e simulação
    initial begin
        // Inicialização
        reset = 1;
        #10;
        reset = 0;

        // Tempo de simulação
        #1000;
        $finish;
    end

    // Monitoramento
    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %b | ALUResult: %d | MemData: %h", $time, PC_out, instruction_out, ULA_out, MemData_out);
    end

    // Gerar arquivo de dump para visualização no GTKWave
    initial begin
        $dumpfile("top_level_tb.vcd");
        $dumpvars(0, top_level_tb);
    end

endmodule