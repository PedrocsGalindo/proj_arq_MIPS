`timescale 1ns/1ps  // Define unidade de tempo como 1ns e precisão de 1ps, pode causar problemas sem isso

module top_level (
    input wire clock,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);