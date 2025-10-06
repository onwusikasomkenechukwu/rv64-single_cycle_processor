// adder.sv
// Small wrapper to perform addition using the ALU
module adder (
    input  wire [63:0] op1,
    input  wire [63:0] op2,
    output wire [63:0] result
);

    alu alu1 (
        .op1(op1),
        .op2(op2),
        .alu_op(4'b0010),
        .result(result),
        .zero() // unused here
    );

endmodule