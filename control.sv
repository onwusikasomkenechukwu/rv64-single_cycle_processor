// control.sv
// Simple control unit deriving control signals from the opcode
module control (
    input  wire [6:0] opcode,
    output wire       branch,
    output wire       memWrite,
    output wire       memRead,
    output wire       regWrite,
    output wire [1:0] aluOp,
    output wire       memToReg,
    output wire       aluSrc
);

    // Decode helper signals (based on opcode bit patterns)
    // Note: this is a simplified control logic tailored to the example ISA used in this project
    wire is_branch = (opcode == 7'b1100011);
    wire is_load   = (opcode == 7'b0000011);
    wire is_store  = (opcode == 7'b0100011);
    wire is_alu_imm= (opcode == 7'b0010011);
    wire is_alu_reg= (opcode == 7'b0110011);

    assign branch   = is_branch;
    assign memRead  = is_load;
    assign memWrite = is_store;
    assign memToReg = is_load;
    assign aluSrc   = is_alu_imm | is_load | is_store;
    assign regWrite = is_alu_reg | is_alu_imm | is_load;

    // Simple ALUOp encoding: 2'b00 = load/store (add), 2'b01 = branch (sub/compare), 2'b10 = R-type
    assign aluOp = is_branch ? 2'b01 : (is_alu_reg ? 2'b10 : 2'b00);

endmodule