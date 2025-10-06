// data_memory.sv
// Simple byte-addressable memory with 1024 bytes. Supports 64-bit aligned R/W.
module data_memory (
    input  wire        clk,
    input  wire        resetn,
    input  wire [63:0] addr,
    input  wire [63:0] writeData,
    input  wire        writeEnable,
    input  wire        readEnable,
    output logic [63:0] readData
);

    reg [7:0] mem [0:1023];

    integer i;
    always @(posedge clk) begin
        if (!resetn) begin
            for (i = 0; i < 1024; i = i + 1) begin
                mem[i] <= 8'h00;
            end
            // Example initial data (optional)
            mem[0] <= 8'h05;
        end else begin
            if (writeEnable) begin
                // Perform 64-bit little-endian write to 8 consecutive bytes (aligned assumed)
                mem[addr + 0] <= writeData[7:0];
                mem[addr + 1] <= writeData[15:8];
                mem[addr + 2] <= writeData[23:16];
                mem[addr + 3] <= writeData[31:24];
                mem[addr + 4] <= writeData[39:32];
                mem[addr + 5] <= writeData[47:40];
                mem[addr + 6] <= writeData[55:48];
                mem[addr + 7] <= writeData[63:56];
            end
        end
    end

    // Combinational read
    always_comb begin
        if (readEnable) begin
            readData = {mem[addr+7], mem[addr+6], mem[addr+5], mem[addr+4], mem[addr+3], mem[addr+2], mem[addr+1], mem[addr+0]};
        end else begin
            readData = 64'h0;
        end
    end

endmodule