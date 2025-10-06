// fetch.sv
// Instruction fetch stage: provides current pc and fetched instruction
module fetch (
    input  wire        clk,
    input  wire        resetn,
    input  wire [63:0] pc_in,
    output wire [31:0] instruction
);

    // Use instruction_memory to read instruction at pc_in
    instruction_memory im_inst (
        .clk(clk),
        .resetn(resetn),
        .address(pc_in),
        .instruction(instruction)
    );

endmodule