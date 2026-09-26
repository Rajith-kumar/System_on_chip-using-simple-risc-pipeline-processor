`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 12:37:09
// Design Name: 
// Module Name: SOC
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


module SOC (
    input wire clk,    // System clock
    input wire rst     // System reset (active-high)
);

    // APB3 bridge signals
    wire [31:0] PADDR;
    wire [7:0]  PSEL;
    wire        PENABLE;
    wire        PWRITE;
    wire [31:0] PWDATA;
    wire [31:0] PRDATA;
    wire        PREADY;
    wire        PSLVERR;

    // APB3 slave select signals
    wire PSEL_timer, PSEL_uart, PSEL_pwm, PSEL_periph3, PSEL_periph4, PSEL_periph5, PSEL_periph6, PSEL_mem;

    // Timer slave signals
    wire [31:0] timer_PRDATA;
    wire        timer_PREADY;
    wire        timer_PSLVERR;

    // UART slave signals
    wire [31:0] uart_PRDATA;
    wire        uart_PREADY;
    wire        uart_PSLVERR;

    // PWM slave signals
    wire [31:0] pwm_PRDATA;
    wire        pwm_PREADY;
    wire        pwm_PSLVERR;

    // Periph3-6 slave signals (placeholders)
    wire [31:0] periph3_PRDATA, periph4_PRDATA, periph5_PRDATA, periph6_PRDATA;
    wire        periph3_PREADY, periph4_PREADY, periph5_PREADY, periph6_PREADY;
    wire        periph3_PSLVERR, periph4_PSLVERR, periph5_PSLVERR, periph6_PSLVERR;

    // Memory slave signals
    wire [31:0] mem_PRDATA;
    wire        mem_PREADY;
    wire        mem_PSLVERR;

    // Instantiate processor_to_apb (contains processor_core)
    
    wire [31:0] proc_addr1;
    wire proc_write1;
    wire [31:0]proc_wdata1;
    wire proc_req1;
    wire [31:0] proc_rdata1;
    wire proc_ready1;
    
processor_core pc(
.clk(clk),
.rst(rst),
.proc_addr(proc_addr1),  // Word address
.proc_write(proc_write1),
.proc_wdata(proc_wdata1),
.proc_req(proc_req1),
.proc_rdata(proc_rdata1),
.proc_ready(proc_ready1)
);
    
    processor_to_apb p_to_apb (
//        .clk(clk),
//        .rst(rst),
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR),
        .proc_ready(proc_ready1),
        .proc_rdata(proc_rdata1),
        .proc_req(proc_req1),
        .proc_write(proc_write1),
        .proc_addr(proc_addr1),
        .proc_wdata(proc_wdata1)
    );

    // Instantiate apb3_address_decoder
    apb3_address_decoder addr_dec (
        .PADDR(PADDR),
        .PSEL(PSEL),
        .PSEL_timer(PSEL_timer),
        .PSEL_uart(PSEL_uart),
        .PSEL_pwm(PSEL_pwm),
        .PSEL_periph3(PSEL_periph3),
        .PSEL_periph4(PSEL_periph4),
        .PSEL_periph5(PSEL_periph5),
        .PSEL_periph6(PSEL_periph6),
        .PSEL_mem(PSEL_mem)
    );

    // Instantiate apb3_slave_timer
    apb3_slave_timer timer (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_timer(PSEL_timer),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(timer_PRDATA),
        .PREADY(timer_PREADY),
        .PSLVERR(timer_PSLVERR)
    );

    // Instantiate apb3_slave_uart
    apb3_slave_uart uart (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_uart(PSEL_uart),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(uart_PRDATA),
        .PREADY(uart_PREADY),
        .PSLVERR(uart_PSLVERR)
    );

    // Instantiate apb3_slave_pwm
    apb3_slave_pwm pwm (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_pwm(PSEL_pwm),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(pwm_PRDATA),
        .PREADY(pwm_PREADY),
        .PSLVERR(pwm_PSLVERR)
    );

    // Instantiate apb3_slave_periph3
    apb3_slave_periph3 periph3 (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_periph3(PSEL_periph3),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(periph3_PRDATA),
        .PREADY(periph3_PREADY),
        .PSLVERR(periph3_PSLVERR)
    );

    // Instantiate apb3_slave_periph4
    apb3_slave_periph4 periph4 (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_periph4(PSEL_periph4),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(periph4_PRDATA),
        .PREADY(periph4_PREADY),
        .PSLVERR(periph4_PSLVERR)
    );

    // Instantiate apb3_slave_periph5
    apb3_slave_periph5 periph5 (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_periph5(PSEL_periph5),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(periph5_PRDATA),
        .PREADY(periph5_PREADY),
        .PSLVERR(periph5_PSLVERR)
    );

    // Instantiate apb3_slave_periph6
    apb3_slave_periph6 periph6 (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_periph6(PSEL_periph6),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(periph6_PRDATA),
        .PREADY(periph6_PREADY),
        .PSLVERR(periph6_PSLVERR)
    );

    // Instantiate apb3_slave_mem
    apb3_slave_mem mem (
        .PCLK(clk),
        .PRESETn(~rst),
        .PADDR(PADDR),
        .PSEL_mem(PSEL_mem),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PRDATA(mem_PRDATA),
        .PREADY(mem_PREADY),
        .PSLVERR(mem_PSLVERR)
    );

    // Aggregate APB3 signals
    assign PRDATA = PSEL_timer   ? timer_PRDATA   :
                    PSEL_uart    ? uart_PRDATA    :
                    PSEL_pwm     ? pwm_PRDATA     :
                    PSEL_periph3 ? periph3_PRDATA :
                    PSEL_periph4 ? periph4_PRDATA :
                    PSEL_periph5 ? periph5_PRDATA :
                    PSEL_periph6 ? periph6_PRDATA :
                    PSEL_mem     ? mem_PRDATA     :
                    32'h0;

    assign PREADY = (PSEL_timer   & timer_PREADY)   |
                    (PSEL_uart    & uart_PREADY)    |
                    (PSEL_pwm     & pwm_PREADY)     |
                    (PSEL_periph3 & periph3_PREADY) |
                    (PSEL_periph4 & periph4_PREADY) |
                    (PSEL_periph5 & periph5_PREADY) |
                    (PSEL_periph6 & periph6_PREADY) |
                    (PSEL_mem     & mem_PREADY);

    assign PSLVERR = (PSEL_timer   & timer_PSLVERR)   |
                     (PSEL_uart    & uart_PSLVERR)    |
                     (PSEL_pwm     & pwm_PSLVERR)     |
                     (PSEL_periph3 & periph3_PSLVERR) |
                     (PSEL_periph4 & periph4_PSLVERR) |
                     (PSEL_periph5 & periph5_PSLVERR) |
                     (PSEL_periph6 & periph6_PSLVERR) |
                     (PSEL_mem     & mem_PSLVERR);

endmodule