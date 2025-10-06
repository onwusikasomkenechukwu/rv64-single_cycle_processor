// registers.sv
// 32x64 register file for RV64 with x0 hardwired to zero
module registers (
  input  wire        clk,
  input  wire        resetn,
  input  wire [4:0]  readReg1,
  input  wire [4:0]  readReg2,
  input  wire [4:0]  writeReg,
  input  wire        regWrite,
  input  wire [63:0] writeData,
  output wire [63:0] readData1,
  output wire [63:0] readData2
);

  // 32 registers of 64 bits
  reg [63:0] reg_file [31:0];

  integer i;
  // Synchronous reset: clear registers (x0 remains zero)
  always @(posedge clk) begin
    if (!resetn) begin
      for (i = 0; i < 32; i = i + 1) begin
        reg_file[i] <= 64'h0;
      end
    end else begin
      // Synchronous write (writes are ignored for x0)
      if (regWrite && (writeReg != 5'd0)) begin
        reg_file[writeReg] <= writeData;
      end
      // Ensure x0 is always zero
      reg_file[0] <= 64'h0;
    end
  end

  // Asynchronous read ports
  assign readData1 = reg_file[readReg1];
  assign readData2 = reg_file[readReg2];

endmodule