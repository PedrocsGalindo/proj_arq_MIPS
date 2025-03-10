`timescale 1ns/1ps  // Define unidade de tempo como 1ns e precisão de 1ps, pode causar problemas sem isso

module top_level (
    input wire clock,       
    input wire reset,               // Reset do regfile
    output wire [31:0] PC_out,      // Saída do valor atual do PC
    output wire [31:0] ULA_out,     // Saída da ULA
    output wire [31:0] MemData_out  // Saída da Memória de Dados
);
    reg [31:0] PC;          // Registrador que guarda o valor atual do PC
    wire [31:0] nextPC;     // mux -- pc

    mux_pcsrc mux_pcsrc_i (
        .PC4(), 
        .BranchAddr(),
        .JumpAddr(),
        .PCSrc(),
        .NextPC(nextPC)
    );
    pc pc_i (
        .clock(clock),
        .nextPC(nextPC),      
        .PC(PC)
    );
    i_mem i_mem_i (
        .adress(PC)
        .i_out()        //instrução
    );

endmodule


//Não sei se está correto, por isso precisa testar e ver se está tudo correto 

`timescale 1ns/1ps

module top_level (
    input wire clock,
    input wire reset,
    output wire [31:0] PC_out,
    output wire [31:0] ULA_out,
    output wire [31:0] MemData_out
);

    // Sinais internos
    wire [31:0] PC, nextPC, instruction, ReadData1, ReadData2, ALUResult, MemData, WriteData;
    wire [31:0] SignExtImm, ALUSrcB, BranchAddr, JumpAddr;
    wire [4:0] WriteReg;
    wire [3:0] ALUControl;
    wire [1:0] ALUOp;
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, Jal, Jr, ExtOp, Zero;

    // Instância do PC
    pc pc_inst (
        .clock(clock),
        .nextPC(nextPC),
        .PC(PC)
    );

    // Instância da memória de instruções
    i_mem i_mem_inst (
        .address(PC),
        .i_out(instruction)
    );

    // Instância do banco de registradores
    regfile regfile_inst (
        .ReadAddr1(instruction[25:21]),
        .ReadAddr2(instruction[20:16]),
        .clock(clock),
        .WriteAddr(WriteReg),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .Reset(reset),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Instância da unidade de controle
    control control_inst (
        .opcode(instruction[31:26]),
        .func(instruction[5:0]),
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

    // Instância da unidade de controle da ULA
    ula_ctrl ula_ctrl_inst (
        .ALUOp(ALUOp),
        .func(instruction[5:0]),
        .OP(ALUControl)
    );

    // Instância da ULA
    ula ula_inst (
        .In1(ReadData1),
        .In2(ALUSrcB),
        .OP(ALUControl),
        .result(ALUResult),
        .Zero_flag(Zero)
    );

    // Instância da memória de dados
    d_mem d_mem_inst (
        .Address(ALUResult),
        .WriteData(ReadData2),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(MemData)
    );

    // Multiplexador para ALUSrc
    mux_alu_src mux_alu_src_inst (
        .reg_data(ReadData2),
        .imm_ext(SignExtImm),
        .ALUSrc(ALUSrc),
        .mux_out(ALUSrcB)
    );

    // Multiplexador para MemtoReg
    mux_memtoreg mux_memtoreg_inst (
        .ALUResult(ALUResult),
        .MemData(MemData),
        .MemToReg(MemtoReg),
        .WriteData(WriteData)
    );

    // Multiplexador para RegDst
    mux_regdst mux_regdst_inst (
        .rt(instruction[20:16]),
        .rd(instruction[15:11]),
        .RegDst(RegDst),
        .RegDstOut(WriteReg)
    );

    // Extensão de sinal
    assign SignExtImm = ExtOp ? {{16{instruction[15]}}, instruction[15:0]} : {16'b0, instruction[15:0]};

    // Calcular endereço de desvio
    assign BranchAddr = PC + (SignExtImm << 2);

    // Calcular endereço de salto
    assign JumpAddr = {PC[31:28], instruction[25:0], 2'b00};

    // Multiplexador para PCSrc
    assign nextPC = (Jr) ? ReadData1 :
                    (Jump) ? JumpAddr :
                    (Branch && Zero) ? BranchAddr :
                    PC + 4;

    // Saídas
    assign PC_out = PC;
    assign ULA_out = ALUResult;
    assign MemData_out = MemData;

endmodule