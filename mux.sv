// mux.sv
// 2-to-1 multiplexer for 64-bit signals
module mux_2_to_1 (
    input  wire        sel,
    input  wire [63:0] op1,
    input  wire [63:0] op2,
    output wire [63:0] out
);

    assign out = sel ? op2 : op1;

endmodule