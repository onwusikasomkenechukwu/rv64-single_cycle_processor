module reg_file(
  input clk,
  input rst_n,
  input [4:0] rs1,
  input [4:0] rs2,
  input [4:0] rd,
  input RegWrite,
  input [63:0] write_data,
  output [63:0] rs1_out,
  output [63:0] rs2_out
);

  logic [63:0] registers [31:0];

  always@(posedge clk)begin
    if(!rst_n) begin
      integer i;
      for(i = 0; i < 32; i = i + 1) begin
        register_file[i] <= 0;
      end
    end
    else begin
      if(RegWrite == 1) begin
        register_file[rd] <= write_data;
      end
    end
  
  end

  assign rs1_out = register_file[rs1];
  assign rs2_out = register_file[rs2];


endmodule