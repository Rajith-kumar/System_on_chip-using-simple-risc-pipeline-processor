`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2025 14:33:05
// Design Name: 
// Module Name: interrupt_controller
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


module interrupt_controller(
input [31:0] int_reg,
output  interrupt_pin_high,
        interrupt_pin_low
        
    );
    /* 
        int_reg[1:0] --  int0e,int0f
        int_reg[3:2] --  int1e,int1f
        int_reg[5:4]-- tim1e,tim1f
        int_reg[7:6] -- uart_rx_e, uart_rx_f
        int_reg[9:8] -- tim0e,timof
        int_reg[11:10] -- int2e,int2f
        int_reg[13:12] -- adc3,adcf
        int_reg[14:15] -- uart_tx_e,uart_tx_f
        int-reg[17:16] -- GIEH,GIEL        
        int_reg[19:18] -- high_int_active , low_int_active -- we'll set these two whiile starting of each of the priority 
        int_reg[20] -- low_pending 
        int_reg[21] -- is_nested interrupt 
    */
        wire interrupt_pin_hi ;
  assign interrupt_pin_hi = 
                                (int_reg[17]  &  
                                        (
                                            (int_reg[1]& int_reg[0]) || 
                                            (int_reg[3]& int_reg[2]) || 
                                            (int_reg[5]& int_reg[4]) || 
                                            (int_reg[7]& int_reg[6]) 
                                        )
                                );
                                
                                

  assign interrupt_pin_low =        ( (~interrupt_pin_hi) & (~int_reg[19]) &                                    
                                            
                                            (int_reg[16]  & 
                                                    (
                                                            (int_reg[9]& int_reg[8]) || 
                                                            (int_reg[11]& int_reg[10]) ||
                                                            (int_reg[13]& int_reg[12]) || 
                                                            (int_reg[15]& int_reg[14]) 
                                                    )
                                            )
                                         ); 
  assign interrupt_pin_high = interrupt_pin_hi;                          

                                
                            
        
endmodule
