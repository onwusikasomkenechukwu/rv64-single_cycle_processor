// program_counter.sv
// Simple program counter that captures pc_next and exposes the current PC
module program_counter (
    input  wire        clk,
    input  wire [63:0] pc_next,
    output reg  [63:0] pc_prev,
    input  wire        resetn
);

    always @(posedge clk) begin
        if (!resetn) begin
            pc_prev <= 64'h0;
        end else begin
            pc_prev <= pc_next;
        end
    end

endmodule