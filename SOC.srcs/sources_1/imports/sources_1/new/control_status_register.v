//-------------------------
// Register File
//-------------------------
// 16-register file, 32-bit each.
// Supports two reads and one write per cycle
module control_status_register(clk,rd_write,isWbCsr,isRdCsr,data_in,data_out,rd_read,int_reg,Iret,interrupt_pin_high,interrupt_pin_low,watchdog_control);
input clk,isWbCsr,isRdCsr,interrupt_pin_high,interrupt_pin_low;
input [3:0]rd_write,rd_read;
input Iret;
input [31:0]data_in;
output  [31:0]data_out;
output [31:0] int_reg;
output [3:0] watchdog_control;

reg [31:0]Control_status_register[15:0];  
        
initial
begin
// Initialize registers
    Control_status_register[0]=0;
    Control_status_register[1]=2;
    Control_status_register[2]=5;
    Control_status_register[3]=7;
    Control_status_register[4]=3;//For watchdog  bit 0 --> EN, bit 1 -->prescale0 , bit 2 --> prescale1, bit 3 --> prescale2
    Control_status_register[5]=0;// for interrupt control registers 
    Control_status_register[6]=8;
    Control_status_register[7]=10;
    Control_status_register[8]=10;
    Control_status_register[9]=3;
    Control_status_register[10]=1;
    Control_status_register[11]=1;
    Control_status_register[12]=35; 
    Control_status_register[13]=42;  
    Control_status_register[14]=32'd25;  
    Control_status_register[15]=12;  
end
assign data_out = Control_status_register[rd_read];
assign int_reg = Control_status_register[5];
assign watchdog_control = Control_status_register[4][3:0];
always @(negedge clk)
begin
    
     if(isWbCsr )
        begin
            Control_status_register[rd_write] <= data_in; //writing to csr file if enabled 
        end
 
      else if(Control_status_register[5][18] == 1'b1 & interrupt_pin_high)
            begin         
                     Control_status_register[5][21] = 1'b1;               
           end 
        
         else
           if(Iret) 
            begin 
             if(Control_status_register[5][19] == 1'b1)
            begin
                if( Control_status_register[5][21] == 1'b1)begin //nested interrupt 
                  Control_status_register[5][17:16] = 2'b10;
                   Control_status_register[5][19] = 1'b0;
                end 
                else begin
                    Control_status_register[5][17:16] = 2'b11;
                    Control_status_register[5][19] = 1'b0;
                  Control_status_register[5][18] = 1'b0; // non nested when both  high and low interrupts got executed an then went tp iret then we should reset both high_active and low_active 
                   end 
                  
            end 
            else if(Control_status_register[5][18] == 1'b1)
            begin 
                 Control_status_register[5][17:16] = 2'b11;
                  Control_status_register[5][18] = 1'b0;
            end 
            end 
             Control_status_register [5][20]  =               (int_reg[9]& int_reg[8]) || 
                                                            (int_reg[11]& int_reg[10]) ||
                                                            (int_reg[13]& int_reg[12]) || 
                                                            (int_reg[15]& int_reg[14]) ;
     /*else if(isRdCsr)
        begin
            data_out <= Control_status_register[rd_read]; //reading from csr file if enabled 
        end*/
      end 
        
endmodule
