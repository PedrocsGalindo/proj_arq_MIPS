module mux_alu_src (
    input wire [31:0] reg_data,    // Valor ReadData2
    input wire [31:0] imm_ext,     // Valor imediato 
    input wire ALUSrc,             // 0 = registrador, 1 = imediato
    output reg [31:0] mux_out     
);
    always @(*) begin
        if (ALUSrc)
            mux_out = imm_ext;
        else
            mux_out = reg_data;
    end
endmodule