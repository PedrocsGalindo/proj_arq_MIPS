`timescale 1ns/1ps  // Define unidade de tempo como 1ns e precisão de 1ps, pode causar problemas sem isso

module top_level (
    input wire clock,       
    input wire reset,               // Reset do regfile
    output wire [31:0] PC_out,      // Saída do valor atual do PC
    output wire [31:0] ULA_out,     // Saída da ULA
    output wire [31:0] MemData_out  // Saída da Memória de Dados
);