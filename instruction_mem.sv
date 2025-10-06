// instruction_memory.sv
// Simple synchronous instruction memory read (combinational read from block RAM model)
module instruction_memory (
    input  wire        clk,
    input  wire        resetn,
    input  wire [63:0] address,
    output wire [31:0] instruction
);

    // 1024 words of 32-bit instruction memory (4KB)
    reg [31:0] memory [0:1023];

    // Initialize memory on reset (synchronous) - can be changed to $readmemh if desired
    always @(posedge clk) begin
        if (!resetn) begin
            integer i;
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 32'h0;
            end
        end
    end

    // Simple word-addressing: treat address as word index (pc / 4) for now
    // If the rest of the design uses byte addressing, this should be address[11:2]
    assign instruction = memory[address[11:2]];

endmodule