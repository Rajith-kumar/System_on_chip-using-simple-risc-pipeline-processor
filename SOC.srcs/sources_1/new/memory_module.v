`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 13:03:27
// Design Name: 
// Module Name: memory_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module memory_module (
    input  wire        clk,
    input  wire        we,
    input  wire [7:0]  addr,       // Word address (0-255)
    input  wire [31:0] wdata,
    output wire [31:0] rdata
);

    reg [31:0] mem [0:255];

    initial begin
        mem[0] = 0;
        mem[1] = 8;
        mem[2] = 4;
        mem[3] = 6;
        mem[4] = 2;
        mem[5] = 3;
        mem[6] = 9;
        mem[7] = 10;
        mem[8] = 22;
        mem[9] = 7;
        mem[10] = 8;
        mem[11] = 11;
        mem[12] = 13;
        mem[13] = 15;
        mem[14] = 20;
        mem[15] = 1;
        mem[16] = 10;
        mem[17] = 22;
        mem[18] = 7;
        mem[19] = 8;
        mem[20] = 11;
        mem[21] = 13;
        mem[22] = 15;
        mem[23] = 20;
        mem[24] = 1;
        mem[25] = 1;
        // for (integer i = 26; i < 256; i = i + 1) begin
        //     mem[i] = 0;
        // end
    end

    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= wdata;
        end
    end

    assign rdata = mem[addr];

endmodule
