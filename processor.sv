module rv64_processor (
    input clk,
    input resetn
);

    wire [63:0] pc_next;
    wire [63:0] pc;
    wire [63:0] pc_add_4;
    wire [31:0] instruction;
    wire [63:0] immediate;
    wire [63:0] alu_result;
    wire [63:0] alu_op1;
    wire [63:0] alu_op2;
    wire [63:0] memory_data;
    wire [63:0] reg2data;
    wire [63:0] pc_add_imm;
    wire [63:0] regWriteData;
    wire [3:0] alu_op;
    wire [1:0] alu_op_sel;
    wire branch;
    wire memRead;
    wire memWrite;
    wire memToReg;
    wire aluSrc;
    wire regWrite;
    wire zero;
    wire pcSrc;


    assign pcSrc = branch & zero;


    // Instantiate modules for next pc
    program_counter pc1 (
        .clk(clk),
        .pc_next(pc_next),
        .pc_prev(pc),
        .resetn(resetn)
    );

    increment_by_4 inc4 (
        .pc(pc),
        .result(pc_add_4)
    );

    adder adder1 (
        .op1(pc),
        .op2(immediate),
        .result(pc_add_imm)
    );

    mux_2_to_1 mux1 (
        .sel(pcSrc),
        .op1(pc_add_4),
        .op2(pc_add_imm),
        .out(pc_next)
    );

    // Instantiate modules for instruction fetch
    instruction_memory im1 (
        .clk(clk),
        .resetn(resetn),
        .address(pc),
        .instruction(instruction)
    );

    // Instantiate modules for instruction decode
    control ctrl1 (
        .opcode(instruction[6:0]),
        .branch(branch),
        .memWrite(memWrite),
        .memRead(memRead),
        .regWrite(regWrite),
        .aluOp(alu_op_sel),
        .memToReg(memToReg),
        .aluSrc(aluSrc)
    );

    immediate_gen imm1 (
        .instruction(instruction),
        .immediate(immediate)
    );

    // Instantiate modules for register file
    registers regFile1 (
        .clk(clk),
        .resetn(resetn),
        .readReg1(instruction[19:15]),
        .readReg2(instruction[24:20]),
        .writeReg(instruction[11:7]),
        .writeData(regWriteData),
        .readData1(alu_op1),
        .readData2(reg2data),
        .regWrite(regWrite)
    );

    // Instantiate modules for alu
    mux_2_to_1 mux2 (
        .sel(aluSrc),
        .op1(reg2data),
        .op2(immediate),
        .out(alu_op2)
    );

    alu alu1 (
        .op1(alu_op1),
        .op2(alu_op2),
        .alu_op(alu_op),
        .result(alu_result),
        .zero(zero)
    );
    
    alu_control alu_ctrl1 (
        .instruction(instruction),
        .alu_op_sel(alu_op_sel),
        .alu_op(alu_op)
    );

    // Instantiate modules for data memory
    data_memory dm1 (
        .clk(clk),
        .addr(alu_result),
        .writeData(reg2data),
        .writeEnable(memWrite),
        .readEnable(memRead),
        .readData(memory_data),
        .resetn(resetn)
    );

    mux_2_to_1 mux3 (
        .sel(memToReg),
        .op2(memory_data),
        .op1(alu_result),
        .out(regWriteData)
    );
    
endmodule