module apb3_address_decoder (
    input  wire [31:0] PADDR,      // Word address
    input  wire [7:0]  PSEL,       // 8-bit peripheral select
    output wire        PSEL_timer, // Timer: 0x400000-0x400003
    output wire        PSEL_uart,  // UART: 0x800000-0x800003
    output wire        PSEL_pwm,   // PWM: 0xC00000-0xC00003
    output wire        PSEL_periph3, // 0x1000000-0x1000003
    output wire        PSEL_periph4, // 0x1400000-0x1400003
    output wire        PSEL_periph5, // 0x1800000-0x1800003
    output wire        PSEL_periph6, // 0x1C00000-0x1C00003
    output wire        PSEL_mem     // Memory: 0x2000000-0x20003FF
);

    assign PSEL_timer   = PSEL[0];
    assign PSEL_uart    = PSEL[1]; 
    assign PSEL_pwm     = PSEL[2]; 
    assign PSEL_periph3 = PSEL[3]; 
    assign PSEL_periph4 = PSEL[4]; 
    assign PSEL_periph5 = PSEL[5]; 
    assign PSEL_periph6 = PSEL[6]; 
    assign PSEL_mem     = PSEL[7]; 

endmodule