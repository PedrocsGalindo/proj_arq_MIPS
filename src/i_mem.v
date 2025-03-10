module i_mem (
  input wire [31:0] address,    // Endereço da linha, dentro do arquivo "instructions.list"
  output reg [31:0] i_out       // Conteúdo lido
);
  parameter MEM_SIZE = 64;    // Número de linhas lidas (ajustado para o número de instruções no arquivo)
  
  reg [31:0] memory [0:MEM_SIZE-1]; // Array contendo as instruções, 64 linhas
  
  // Passar no máximo 64 linhas do arquivo instructions.list para a memória
  initial begin
    $readmemb("instructions.list", memory); // Lê arquivo binário linha por linha
  end
  
  // Leitura assíncrona da memória
  // O address fornecido pelo PC é um endereço de byte
  always @(address) begin
    i_out = memory[address >> 2]; // Alinhamento com 32 bits
  end

endmodule