module apb3_slave_mem (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire [31:0] PADDR,
    input  wire        PSEL_mem,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output reg         PREADY,
    output reg         PSLVERR
);

    // Memory module signals
    wire [7:0]  mem_addr = PADDR[7:0]; // Word address (0-255)
    wire        mem_we;
    wire [31:0] mem_wdata;
    wire [31:0] mem_rdata;

    // APB3 transfer detection
    wire apb_transfer = PSEL_mem & PENABLE;
    wire valid_addr = (PADDR[7:0] <= 8'd255); // 0x2000000-0x20003FF

    // Instantiate memory_module
    memory_module mem (
        .clk(PCLK),
        .we(mem_we),
        .addr(mem_addr),
        .wdata(mem_wdata),
        .rdata(mem_rdata)
    );

    // Map APB3 signals to memory_module
    assign mem_we = apb_transfer & PWRITE & valid_addr;
    assign mem_wdata = PWDATA;

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
                        PRDATA <= mem_rdata;
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