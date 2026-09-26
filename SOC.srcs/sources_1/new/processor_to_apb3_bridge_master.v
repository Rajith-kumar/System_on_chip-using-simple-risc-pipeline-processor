module processor_to_apb (
//    input  wire        clk,        // System clock for processor_core
//    input  wire        rst,        // System reset (active-high) for processor_core
    input wire [31:0]proc_addr,
    input wire proc_write,
    input wire proc_req,
    input wire [31:0]proc_wdata,
    
    
    input  wire        PCLK,       // APB3 clock
    input  wire        PRESETn,    // APB3 reset (active-low)
    output reg  [31:0] PADDR,      // Word address
    output reg  [7:0]  PSEL,       // 8-bit peripheral select
    output reg         PENABLE,
    output reg         PWRITE,
    output reg  [31:0] PWDATA,
    output reg proc_ready,
    output reg proc_rdata,
    input  wire [31:0] PRDATA,
    input  wire        PREADY,
    input  wire        PSLVERR
);

    // Internal processor signals
//    wire [31:0] proc_addr;   // Word address
//    wire        proc_write;
//    wire [31:0] proc_wdata;
//    wire        proc_req;
//    wire [31:0] proc_rdata;
//    wire        proc_ready;

    // State machine
    reg  [1:0] state, next_state;
    wire [7:0] psel_decode;
    localparam IDLE = 2'd0, SETUP = 2'd1, ACCESS = 2'd2;

    // Instantiate processor_core
//    processor_core pc (
//        .clk(clk),
//        .rst(rst),
//        .proc_addr(proc_addr),
//        .proc_write(proc_write),
//        .proc_wdata(proc_wdata),
//        .proc_req(proc_req),
//        .proc_rdata(proc_rdata),
//        .proc_ready(proc_ready)
//    );

    // Combinational PSEL decoding based on proc_addr
    assign psel_decode = (proc_addr[31:2] == 30'h100000 && proc_addr[1:0] <= 2'd3) ? 8'b00000001 : // Timer: 0x400000-0x400003
                         (proc_addr[31:2] == 30'h200000 && proc_addr[1:0] <= 2'd3) ? 8'b00000010 : // UART: 0x800000-0x800003
                         (proc_addr[31:2] == 30'h300000 && proc_addr[1:0] <= 2'd3) ? 8'b00000100 : // PWM: 0xC00000-0xC00003
                         (proc_addr[31:2] == 30'h400000 && proc_addr[1:0] <= 2'd3) ? 8'b00001000 : // Periph3: 0x1000000-0x1000003
                         (proc_addr[31:2] == 30'h500000 && proc_addr[1:0] <= 2'd3) ? 8'b00010000 : // Periph4: 0x1400000-0x1400003
                         (proc_addr[31:2] == 30'h600000 && proc_addr[1:0] <= 2'd3) ? 8'b00100000 : // Periph5: 0x1800000-0x1800003
                         (proc_addr[31:2] == 30'h700000 && proc_addr[1:0] <= 2'd3) ? 8'b01000000 : // Periph6: 0x1C00000-0x1C00003
                         (proc_addr[31:8] == 24'h200000 && proc_addr[7:0] <= 8'd255) ? 8'b10000000 : // Memory: 0x2000000-0x20003FF (256 words)
                         8'b00000000;                                         // Invalid address

    // Combinational next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (proc_req && |psel_decode) begin // Valid peripheral address
                    next_state = SETUP;
                end
                else if (proc_req) begin // Invalid address
                    next_state = ACCESS; // Skip to ACCESS for error handling
                end
                else begin
                    next_state = IDLE;
                end
            end
            SETUP: begin
                next_state = ACCESS;
            end
            ACCESS: begin
                if (PREADY || PSLVERR) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = ACCESS;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Sequential state and signal updates
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            state <= IDLE;
            PADDR <= 32'h0;
            PSEL <= 8'b0;
            PENABLE <= 1'b0;
            PWRITE <= 1'b0;
            PWDATA <= 32'h0;
            proc_ready <= 1'b0;
            proc_rdata <= 32'h0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    proc_ready <= 1'b0;
                    if (proc_req && |psel_decode) begin
                        PADDR <= proc_addr;   // Word address
                        PWRITE <= proc_write;
                        PWDATA <= proc_wdata;
                        PSEL <= psel_decode;  // Select peripheral
                    end
                    else if (proc_req) begin
                        PSEL <= 8'b0;         // No peripheral selected
                        proc_ready <= 1'b1;   // Immediate error response
                        proc_rdata <= 32'h0;  // Return 0 for invalid address
                    end
                end
                SETUP: begin
                    PENABLE <= 1'b1;
                end
                ACCESS: begin
                    if (PREADY) begin
                        proc_rdata <= PRDATA;
                        proc_ready <= 1'b1;
                        PSEL <= 8'b0;
                        PENABLE <= 1'b0;
                    end
                    else if (PSLVERR) begin
                        proc_rdata <= 32'h0;
                        proc_ready <= 1'b1;
                        PSEL <= 8'b0;
                        PENABLE <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule