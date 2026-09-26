
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 13:54:24
// Design Name: 
// Module Name: SOC_tb
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



module SOC_tb;
reg clk;
reg rst;

SOC dut(.clk(clk),.rst(rst));

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial
begin
    rst = 1;
    #6 rst = 0;
end
endmodule

