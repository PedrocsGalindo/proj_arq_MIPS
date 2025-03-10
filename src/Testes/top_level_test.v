`timescale 1ns/1ps

module top_level_tb;
    reg clock;
    reg reset;
    wire [31:0] PC_out;
    wire [31:0] ULA_out;
    wire [31:0] MemData_out;
    
    // Instância do módulo top_level
    top_level uut (
        .clock(clock),
        .reset(reset),
        .PC_out(PC_out),
        .ULA_out(ULA_out),
        .MemData_out(MemData_out)
    );
    
    // Geração de clock (50MHz -> 20ns de período)
    always #10 clock = ~clock;
    
    initial begin
        // Inicialização
        $dumpfile("top_level_tb.vcd"); // Arquivo para visualizar a simulação
        $dumpvars(0, top_level_tb);
        
        clock = 0;
        reset = 1;
        
        // Aguarda alguns ciclos e libera o reset
        #50 reset = 0;
        
        // Simulação por alguns ciclos
        #500;
        
        // Finaliza a simulação
        $finish;
    end
    
    // Monitoramento das principais saídas
    initial begin
        $monitor("Time: %0t | PC: %h | ULA_out: %h | MemData_out: %h", $time, PC_out, ULA_out, MemData_out);
    end
    
endmodule