module apb3_slave_pwm (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire [31:0] PADDR,
    input  wire        PSEL_pwm,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output reg         PREADY,
    output reg         PSLVERR
);

    // Internal register signals
    wire        pwm_write;
    wire        pwm_read;
    wire [1:0]  reg_addr;
    wire [31:0] pwm_data_in;
    wire [31:0] pwm_data_out;

    // APB3 transfer detection
    wire apb_transfer = PSEL_pwm & PENABLE;
    wire valid_addr = (PADDR[1:0] <= 2'd3); // 4 registers: 0xC00000-0xC00003

    // Map APB3 signals to register module
    assign pwm_write = apb_transfer & PWRITE & valid_addr;
    assign pwm_read = apb_transfer & ~PWRITE & valid_addr;
    assign reg_addr = PADDR[1:0];
    assign pwm_data_in = PWDATA;

    // Instantiate pwm_registers
    pwm_registers pwm_regs (
        .clk(PCLK),
        .pwm_write(pwm_write),
        .pwm_read(pwm_read),
        .reg_addr(reg_addr),
        .pwm_data_in(pwm_data_in),
        .pwm_data_out(pwm_data_out)
    );

    // APB3 slave logic
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
                    if (!PWRITE) begin
                        PRDATA <= pwm_data_out;
                    end
                end
                else begin
                    PSLVERR <= 1'b1;
                    PRDATA <= 32'h0;
                end
            end
        end
    end

endmodule