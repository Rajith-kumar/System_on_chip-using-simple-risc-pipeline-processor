`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 13:13:59
// Design Name: 
// Module Name: uart_register
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


module uart_registers (
    input  wire        clk,
    input  wire        uart_write,
    input  wire        uart_read,
    input  wire [1:0]  reg_addr,
    input  wire [31:0] uart_data_in,
    output reg  [31:0] uart_data_out
);

    reg [31:0] uart_regs [0:3];

    // Initialize registers
    initial begin
        uart_regs[0] = 32'h0; // Data
        uart_regs[1] = 32'h0; // Control
        uart_regs[2] = 32'h0; // Status
        uart_regs[3] = 32'h0; // Baud
    end

    // Write logic
    always @(posedge clk) begin
        if (uart_write) begin
            uart_regs[reg_addr] <= uart_data_in;
        end
    end

    // Read logic
    always @(*) begin
        if (uart_read) begin
            uart_data_out = uart_regs[reg_addr];
        end
        else begin
            uart_data_out = 32'h0;
        end
    end

endmodule
