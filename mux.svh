module mux_2_to_1 (
    input [64:0] op1,
    input [63:0] op2,
    input sel,
    output [63:0] out
);
    assign out = sel ? op2 : op1;
endmodule