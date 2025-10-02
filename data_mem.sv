module data_memory (
    input clk,
    input resetn,
    input [63:0] addr,
    input [63:0] writeData,
    input writeEnable,
    input readEnable,
    output [63:0] readData
);
    
    reg [7:0] mem [0:1023];
    
    always @(posedge clk) begin
        if (!resetn) begin
            // Initialize memory
            for (integer i = 0; i < 1024; i = i + 1) begin
                mem[i] <= 8'h00;
            end
            // Load data 0x5 in address 0x0
            mem[0] <= 8'h05;
            mem[1] <= 8'h00;
            mem[2] <= 8'h00;
            mem[3] <= 8'h00;
        end else begin
            if (writeEnable) begin
                mem[addr] <= writeData[7:0];
                mem[addr+1] <= writeData[15:8];
                mem[addr+2] <= writeData[23:16];
                mem[addr+3] <= writeData[31:24];
            end
        end
    end
    
    assign readData = readEnable ? {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]} : 32'b0;
endmodule