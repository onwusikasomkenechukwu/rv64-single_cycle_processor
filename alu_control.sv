// alu_control.sv
// Translate ALUOp selector and instruction funct fields into a 4-bit ALU control code
module alu_control (
    input  wire [31:0] instruction,
    input  wire [1:0]  alu_op_sel,
    output wire [3:0]  alu_op
);

    // alu_op[3] unused/reserved in this design
    assign alu_op[3] = 1'b0;

    // Compute alu_op bits from alu_op_sel and instruction funct fields
    assign alu_op[2] = alu_op_sel[0] | (~alu_op_sel[0] & alu_op_sel[1] & instruction[30]);
    assign alu_op[1] = alu_op_sel[0] | ~instruction[14] | ~alu_op_sel[1];
    assign alu_op[0] = alu_op_sel[1] & instruction[13] & ~instruction[12];

endmodule