module fetch (
    input wire clk,
    input wire reset,
    input wire [63:0] pc,
    output reg [31:0] instruction,
);

    wire [63:0] pc_next;

    PC pc_inst(
        .clk(clk),
        .reset(reset),
        .pc_in(pc),
        .pc_out(pc_next)
    );

    instruction__mem instruction_mem_inst (
        .clk(clk),
        .reset(reset),
        .pc(pc_next),
        .instruction(instruction)
    );

    assign pc = pc_next + 4;
endmodule