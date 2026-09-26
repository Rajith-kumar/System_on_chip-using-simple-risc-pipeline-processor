`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 12:59:39
// Design Name: 
// Module Name: apb3_slave_perip4
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


module apb3_slave_periph4 (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire [31:0] PADDR,
    input  wire        PSEL_periph4,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output reg         PREADY,
    output reg         PSLVERR
);

    wire valid_addr = (PADDR[1:0] <= 2'd3);
    wire apb_transfer = PSEL_periph4 & PENABLE;

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PRDATA <= 32'h0;
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
        end
        else begin
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
            PRDATA <= 32'h0;

            if (apb_transfer) begin
                PREADY <= 1'b1;
                if (valid_addr) begin
                    PSLVERR <= 1'b0;
                    PRDATA <= 32'h0; // Placeholder
                end
                else begin
                    PSLVERR <= 1'b1;
                    PRDATA <= 32'h0;
                end
            end
        end
    end

endmodule
