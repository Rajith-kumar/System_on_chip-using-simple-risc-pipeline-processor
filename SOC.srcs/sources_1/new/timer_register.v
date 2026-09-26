`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 13:13:59
// Design Name: 
// Module Name: timer_register
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


module timer_registers (
    input  wire        clk,
    input  wire        timer_write,
    input  wire        timer_read,
    input  wire [1:0]  reg_addr,
    input  wire [31:0] timer_data_in,
    output reg  [31:0] timer_data_out
);

    reg [31:0] timer_regs [0:3];

    // Initialize registers
    initial begin
        timer_regs[0] = 32'h0; // Control
        timer_regs[1] = 32'h0; // Counter
        timer_regs[2] = 32'h0; // Prescale
        timer_regs[3] = 32'h0; // Status
    end

    // Write logic
    always @(posedge clk) begin
        if (timer_write) begin
            timer_regs[reg_addr] <= timer_data_in;
        end
    end

    // Read logic
    always @(*) begin
        if (timer_read) begin
            timer_data_out = timer_regs[reg_addr];
        end
        else begin
            timer_data_out = 32'h0;
        end
    end

endmodule
