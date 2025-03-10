`timescale 1ns / 1ps

module control_tb;
    // Entradas
    reg [5:0] opcode;
    reg [5:0] func;
    
    // Saídas
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, Jr, ExtOp;
    wire [1:0] ALUOp;
    
    // Instância do módulo de controle
    control uut (
        .opcode(opcode),
        .func(func),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .Jump(Jump),
        .Jal(Jal),
        .Jr(Jr),
        .ExtOp(ExtOp)
    );
    
    initial begin
        // Inicializar entradas
        opcode = 0;
        func = 0;
        
        // Monitorar saídas
        $monitor(
            "Opcode=%6b | Func=%6b | RegDst=%b ALUSrc=%b MemtoReg=%b RegWrite=%b | Branch=%b Jump=%b Jal=%b Jr=%b | ALUOp=%2b ExtOp=%b",
            opcode, func, RegDst, ALUSrc, MemtoReg, RegWrite, Branch, Jump, Jal, Jr, ALUOp, ExtOp
        );
        
        // Testar todas as instruções
        // Tipo R (opcode = 000000)
        #10 opcode = 6'b000000; func = 6'b100000; // add
        #10 opcode = 6'b000000; func = 6'b100010; // sub
        #10 opcode = 6'b000000; func = 6'b100100; // and
        #10 opcode = 6'b000000; func = 6'b100101; // or
        #10 opcode = 6'b000000; func = 6'b100110; // xor
        #10 opcode = 6'b000000; func = 6'b100111; // nor
        #10 opcode = 6'b000000; func = 6'b101010; // slt
        #10 opcode = 6'b000000; func = 6'b101011; // sltu
        #10 opcode = 6'b000000; func = 6'b000000; // sll
        #10 opcode = 6'b000000; func = 6'b000010; // srl
        #10 opcode = 6'b000000; func = 6'b001000; // jr

        // Tipo I
        #10 opcode = 6'b001000; func = 0; // addi
        #10 opcode = 6'b001100; func = 0; // andi
        #10 opcode = 6'b001101; func = 0; // ori
        #10 opcode = 6'b001110; func = 0; // xori
        #10 opcode = 6'b001010; func = 0; // slti
        #10 opcode = 6'b001011; func = 0; // sltiu
        #10 opcode = 6'b001111; func = 0; // lui
        #10 opcode = 6'b100011; func = 0; // lw
        #10 opcode = 6'b101011; func = 0; // sw
        #10 opcode = 6'b000100; func = 0; // beq
        #10 opcode = 6'b000101; func = 0; // bne

        // Tipo J
        #10 opcode = 6'b000010; func = 0; // j
        #10 opcode = 6'b000011; func = 0; // jal

        // Caso inválido
        #10 opcode = 6'b111111; func = 0;

        #10 $finish;
    end
    
    initial begin
        // Gerar arquivo de waveform
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);
    end
endmodule