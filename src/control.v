module control (
    input [5:0] opcode,      // Opcode da instrução
    input [5:0] func,        // Campo func (para instruções tipo R)
    output reg RegDst,       // Seleciona rd (1) ou rt (0) como destino
    output reg ALUSrc,       // Seleciona imediato (1) ou registrador (0)
    output reg MemtoReg,     // Seleciona memória (1) ou ULA (0) para WriteData
    output reg RegWrite,     // Habilita escrita no regfile
    output reg MemRead,      // Habilita leitura da memória de dados
    output reg MemWrite,     // Habilita escrita na memória de dados
    output reg Branch,       // Habilita desvio condicional (beq/bne)
    output reg [1:0] ALUOp,  // Define operação da ULA (00: ADD, 01: SUB, 10: func, 11: lógica)
    output reg Jump,         // Habilita salto incondicional (j/jal)
    output reg Jal,          // Indica instrução jal (escreve PC+8 em $31)
    output reg Jr,           // Habilita salto por registrador (jr)
    output reg ExtOp         // Extensão de sinal (1) ou zero (0)
);

always @(*) begin
    // Valores padrão para evitar latches
    RegDst = 0;
    ALUSrc = 0;
    MemtoReg = 0;
    RegWrite =0; 
    MemRead = 0; 
    MemWrite =0; 
    Branch = 0;
    ALUOp = 0;
    Jump = 0;
    Jal = 0;
    Jr = 0;
    ExtOp = 0;

    case (opcode)
        // Instruções Tipo R (opcode = 0)
        6'b000000: begin
            RegDst = 1;      // Destino é rd
            RegWrite = 1;    // Habilita escrita
            ALUOp = 2'b10;   // Operação definida pelo campo func

            // Trata instrução jr (func = 8)
            if (func == 6'b001000) begin
                Jr = 1;     // Ativa sinal Jr
                RegWrite = 0; // Não escreve no regfile
            end
        end

        // Instruções Tipo I
        6'b001000: begin // addi
            ALUSrc = 1;
            RegWrite = 1;
            ExtOp = 1;      // Extensão de sinal
            ALUOp = 2'b00;  // ADD
        end

        6'b001100: begin // andi
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b11;  // Operação lógica (AND)
            ExtOp = 0;      // Extensão zero
        end

        6'b001101: begin // ori
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b11;  // Operação lógica (OR)
            ExtOp = 0;
        end

        6'b001110: begin // xori
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b11;  // Operação lógica (XOR)
            ExtOp = 0;
        end

        6'b001010: begin // slti (signed)
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b01;  // SLT
            ExtOp = 1;
        end

        6'b001011: begin // sltiu (unsigned)
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b01;  // SLTU
            ExtOp = 1;
        end

        6'b001111: begin // lui
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b00;  // Shift left 16 bits (tratado na ULA)
            ExtOp = 0;      // Não importa (imediado já está nos 16 bits superiores)
        end

        6'b000100: begin // beq
            Branch = 1;
            ALUOp = 2'b01;  // SUB (para comparação)
            ExtOp = 1;
        end

        6'b000101: begin // bne
            Branch = 1;
            ALUOp = 2'b01;  // SUB (para comparação)
            ExtOp = 1;
        end

        6'b100011: begin // lw
            ALUSrc = 1;
            MemtoReg = 1;   // Dado vem da memória
            RegWrite = 1;
            MemRead = 1;    // Habilita leitura da memória
            ExtOp = 1;
            ALUOp = 2'b00;  // ADD (cálculo do endereço)
        end

        6'b101011: begin // sw
            ALUSrc = 1;
            MemWrite = 1;   // Habilita escrita na memória
            ExtOp = 1;
            ALUOp = 2'b00;  // ADD (cálculo do endereço)
        end

        // Instruções Tipo J
        6'b000010: begin // j
            Jump = 1;
        end

        6'b000011: begin // jal
            Jump = 1;
            Jal = 1;
            RegWrite = 1;   // Escreve PC+8 em $31
        end

        default: ; // Instrução inválida (NOP)
    endcase
end

endmodule