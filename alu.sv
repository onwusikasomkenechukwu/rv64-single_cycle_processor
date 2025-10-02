module alu (
    input  [63:0] op1,
    input  [63:0] op2,
    input  [3:0]  alu_op,
    output [63:0] result,
    output        zero
);

    assign zero = (result == 64'h0);

    assign result = (alu_op == 4'b0000) ? (op1 & op2) :
                    (alu_op == 4'b0001) ? (op1 | op2) :
                    (alu_op == 4'b0010) ? (op1 + op2) :
                    (alu_op == 4'b0110) ? (op1 - op2) :
                    (alu_op == 4'b0111) ? ((op1 < op2) ? 64'h1 : 64'h0) :
                    (alu_op == 4'b1100) ? (op1 << op2[5:0]) :
                    (alu_op == 4'b1101) ? (op1 >> op2[5:0]) :
                    (alu_op == 4'b1110) ? (op1 >>> op2[5:0]) :
                    64'h0;

endmodule