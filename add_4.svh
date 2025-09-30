module increment_by_4 (
    input [63:0] pc,
    output [63:0] result
);
    adder adder1(
        .op1(pc),
        .op2(64'h4),
        .result(result)
    );
endmodule