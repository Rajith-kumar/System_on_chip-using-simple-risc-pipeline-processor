//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 03.06.2025 09:36:38
//// Design Name: 
//// Module Name: microcontroller
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////



//module processor_core(
//input clk,rst,
//output   [31:0] proc_addr,  // Word address
//output          proc_write,
//output   [31:0] proc_wdata,
//output          proc_req,
//input  wire [31:0] proc_rdata,
//input  wire        proc_ready
//);

//wire isWbcsr_top,isRdCsr_top;
//wire [31:0]data_in_csr_top,data_out_csr_top;
//wire [3:0]rd_write_csr_top,rd_read_csr_top;
//wire [31:0] int_reg;
//wire interrupt_pin_high,interrupt_pin_low,Iret;
//wire watchdog_rst; //This is the rst signal going from the processor to rst the dog
//wire pc_rst;//This rst signal comes from the dog to reset the pc
//wire [3:0] watchdog_control; // This will carry the watchdog control bits


//wire [31:0] proc_addr1;  
//wire proc_write1;
//wire   [31:0] proc_wdata1;
//wire  proc_req1;


//processor p(
//    .clk(clk),
//    .rst(rst),
//    .pc_rst(pc_rst),
//    .interrupt_pin_high(interrupt_pin_high),
//    .interrupt_pin_low(interrupt_pin_low),
//    .isWbCsr(isWbcsr_top),
//    .isRdCsr(isRdCsr_top),
//    .data_csr(data_in_csr_top),
//    .data_out_csr(data_out_csr_top),
//    .rd_write_csr(rd_write_csr_top),
//    .rd_read_csr(rd_read_csr_top),
//    .Iret(Iret),
//    .watchdog_rst(watchdog_rst));

//control_status_register csr(
//.clk(clk),
//.rd_write(rd_write_csr_top),
//.Iret(Iret),
//.rd_read(rd_read_csr_top),
//.isWbCsr(isWbcsr_top),
//.isRdCsr(isRdCsr_top),
//.data_in(data_in_csr_top),
//.data_out(data_out_csr_top),
//.int_reg(int_reg),
//.interrupt_pin_high(interrupt_pin_high),
//.interrupt_pin_low(interrupt_pin_low),
//.watchdog_control(watchdog_control)
// );
 
 
//interrupt_controller IC(
//     .int_reg(int_reg),
     
//     .interrupt_pin_high(interrupt_pin_high),
//     .interrupt_pin_low(interrupt_pin_low));
     
     
//watchdog watchdog(
//    .clk(clk),
//    .EN(watchdog_control[0]),
//    .prescale_0(watchdog_control[1]),
//    .prescale_1(watchdog_control[2]),
//    .prescale_2(watchdog_control[3]),
//    .watchdog_rst(watchdog_rst),
//    .pc_rst(pc_rst)
//    );


//endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2025 09:36:38
// Design Name: 
// Module Name: microcontroller
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

module processor_core(
input clk,rst,
output   [31:0] proc_addr,  // Word address
output          proc_write,
output   [31:0] proc_wdata,
output          proc_req,
input  wire [31:0] proc_rdata,
input  wire        proc_ready
);

wire isWbcsr_top,isRdCsr_top;
wire [31:0]data_in_csr_top,data_out_csr_top;
wire [3:0]rd_write_csr_top,rd_read_csr_top;
wire [31:0] int_reg;
wire interrupt_pin_high,interrupt_pin_low,Iret;
wire watchdog_rst; //This is the rst signal going from the processor to rst the dog
wire pc_rst;//This rst signal comes from the dog to reset the pc
wire [3:0] watchdog_control; // This will carry the watchdog control bits

processor p(
    .clk(clk),
    .rst(rst),
    .pc_rst(pc_rst),
    .interrupt_pin_high(interrupt_pin_high),
    .interrupt_pin_low(interrupt_pin_low),
    .isWbCsr(isWbcsr_top),
    .isRdCsr(isRdCsr_top),
    .data_csr(data_in_csr_top),
    .data_out_csr(data_out_csr_top),
    .rd_write_csr(rd_write_csr_top),
    .rd_read_csr(rd_read_csr_top),
    .Iret(Iret),
    .watchdog_rst(watchdog_rst),
    .proc_addr(proc_addr),
    .proc_write(proc_write),
    .proc_wdata(proc_wdata),
    .proc_req(proc_req),
    .proc_rdata(proc_rdata),
    .proc_ready(proc_ready)
);

control_status_register csr(
.clk(clk),
.rd_write(rd_write_csr_top),
.Iret(Iret),
.rd_read(rd_read_csr_top),
.isWbCsr(isWbcsr_top),
.isRdCsr(isRdCsr_top),
.data_in(data_in_csr_top),
.data_out(data_out_csr_top),
.int_reg(int_reg),
.interrupt_pin_high(interrupt_pin_high),
.interrupt_pin_low(interrupt_pin_low),
.watchdog_control(watchdog_control)
 );
 
 
interrupt_controller IC(
     .int_reg(int_reg),
     
     .interrupt_pin_high(interrupt_pin_high),
     .interrupt_pin_low(interrupt_pin_low));
     
     
watchdog watchdog(
    .clk(clk),
    .EN(watchdog_control[0]),
    .prescale_0(watchdog_control[1]),
    .prescale_1(watchdog_control[2]),
    .prescale_2(watchdog_control[3]),
    .watchdog_rst(watchdog_rst),
    .pc_rst(pc_rst)
    );

endmodule
