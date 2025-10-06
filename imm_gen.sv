// immediate_gen.sv
// Decode immediate values from a 32-bit instruction and sign-extend to 64 bits
module immediate_gen (
    input  wire [31:0] instruction,
    output logic [63:0] immediate
);

    logic [31:0] imm32;
    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        imm32 = 32'h0;
        case (opcode)
            // I-type (load, ALU immediate, jalr)
            7'b0000011, // LOAD
            7'b0010011, // OP-IMM
            7'b1100111: // JALR
                imm32 = {{20{instruction[31]}}, instruction[31:20]};

            // S-type (store)
            7'b0100011:
                imm32 = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            // B-type (branch) - note: branch immediate is sign-extended and shifted left 1
            7'b1100011:
                imm32 = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};

            // U-type (LUI/AUIPC)
            7'b0110111, // LUI
            7'b0010111: // AUIPC
                imm32 = {instruction[31:12], 12'h0};

            // J-type (JAL)
            7'b1101111:
                imm32 = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};

            default:
                imm32 = 32'h0;
        endcase

        // sign-extend to 64 bits
        immediate = {{(64-32){imm32[31]}}, imm32};
    end

endmodule