module apb3_slave_periph3 (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire [31:0] PADDR,
    input  wire        PSEL_periph3,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output reg         PREADY,
    output reg         PSLVERR
);

    wire valid_addr = (PADDR[1:0] <= 2'd3);
    wire apb_transfer = PSEL_periph3 & PENABLE;

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