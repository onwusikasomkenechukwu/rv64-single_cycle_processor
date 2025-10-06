// ALU (Arithmetic Logic Unit)
// Clean, synthesizable SystemVerilog implementation with named opcodes
module alu #(
    parameter int WIDTH = 64
) (
    input  logic [WIDTH-1:0] op1,
    input  logic [WIDTH-1:0] op2,
    input  logic [3:0]       alu_op,
    output logic [WIDTH-1:0] result,
    output logic             zero
);

    // Named ALU operation codes (keep these synchronized with control logic)
    localparam logic [3:0]
        ALU_AND = 4'b0000,
        ALU_OR  = 4'b0001,
        ALU_ADD = 4'b0010,
        ALU_SUB = 4'b0110,
        ALU_SLT = 4'b0111, // set less than (unsigned)
        ALU_SLL = 4'b1100, // shift left logical
        ALU_SRL = 4'b1101, // shift right logical
        ALU_SRA = 4'b1110; // shift right arithmetic

    // Combinational ALU implementation
    always_comb begin
        // Default output
        result = '0;

        case (alu_op)
            ALU_AND: result = op1 & op2;
            ALU_OR : result = op1 | op2;
            ALU_ADD: result = op1 + op2;
            ALU_SUB: result = op1 - op2;
            ALU_SLT: result = (op1 < op2) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            ALU_SLL: result = op1 << op2[5:0];
            ALU_SRL: result = op1 >> op2[5:0];
            ALU_SRA: result = op1 >>> op2[5:0];
            default: result = '0;
        endcase

        // Zero flag asserted when ALU result is zero
        zero = (result == '0);
    end

endmodule
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