// increment_by_4.sv
// Small wrapper to compute PC + 4 using the structural adder
module increment_by_4 (
    input  wire [63:0] pc,
    output wire [63:0] result
);

    // Use the existing adder module to perform addition
    adder adder_inst (
        .op1(pc),
        .op2(64'h4),
        .result(result)
    );

endmodule