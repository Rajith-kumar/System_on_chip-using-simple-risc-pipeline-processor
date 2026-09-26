`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 13:13:59
// Design Name: 
// Module Name: pwm_register
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

module pwm_registers (
    input  wire        clk,
    input  wire        pwm_write,
    input  wire        pwm_read,
    input  wire [1:0]  reg_addr,
    input  wire [31:0] pwm_data_in,
    output reg  [31:0] pwm_data_out
);

    reg [31:0] pwm_regs [0:1];

    // Initialize registers
    initial begin
        pwm_regs[0] = 32'h0; // Duty
        pwm_regs[1] = 32'h0; // Period

    end

    // Write logic
    always @(posedge clk) begin
        if (pwm_write) begin
            pwm_regs[reg_addr] <= pwm_data_in;
        end
    end

    // Read logic
    always @(*) begin
        if (pwm_read) begin
            pwm_data_out = pwm_regs[reg_addr];
        end
        else begin
            pwm_data_out = 32'h0;
        end
    end

endmodule
