module control (
    input [6:0] opcode,
    output branch,
    output memWrite,
    output memRead,
    output regWrite,
    output [1:0] aluOp,
    output memToReg,
    output aluSrc
);

    wire temp1;
    wire temp2;

    assign temp1 = ~opcode[4] & opcode[6];
    assign temp2 = ~opcode[4] & opcode[5] & ~opcode[6];


    assign aluSrc = ~opcode[5] | (temp2);
    assign memToReg = ~opcode[4];
    assign regWrite = ~opcode[5] | opcode[4];
    assign memRead = ~opcode[5];
    assign memWrite = ~opcode[4] & opcode[5] & ~opcode[6];
    assign branch = temp1;
    assign aluOp = {opcode[4], temp1};
endmodule