module i_mem (
  input wire [31:0] adress,    // Endereço da linha, dentro do arquivo "instructin.list"
  output wire [31:0] i_out	   // Conteudo lido
);
  parameter MEM_SIZE = 1024;   // numero de linhas lidas
  
  reg [31:0] memory [0: MEM_SIZE];	//array contendo o as instruções, 1024 linhas
  
  // Passar no maximo 1024 linhas do arquivo instruction.list para a memoria
  initial begin
    $readmemb("instruction.list", memory); // Lê arquivo binário linha por linha
  end
  
  // Leitura assíncrona da memória
  // O address fornecido pelo PC é um endereço de byte
  always @(address) begin
    i_out = memory[address >> 2]; // alinhamento com 32 bits
  end


endmodule