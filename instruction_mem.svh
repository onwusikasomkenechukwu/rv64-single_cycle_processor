module instruction_mem(
    input wire clk,
    input wire reset,
    input wire [63:0] pc,
    output wire [31:0] instruction_mem
);
    reg [31:0] memory [0:1023]; // 4KB memory for instructions

    always @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 1024; i++) begin
                memory[i] <= 0;
            end
        end
    end

    assign instruction = memory[pc];
endmodule