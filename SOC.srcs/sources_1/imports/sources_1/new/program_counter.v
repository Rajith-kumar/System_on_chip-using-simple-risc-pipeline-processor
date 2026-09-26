///////////////////////////////////////////////////////////////////////////////
// Program Counter Module
///////////////////////////////////////////////////////////////////////////////
// Holds the current program counter value.
// Updates to pcnext on clock edge, resets to 0 on rst
module program_counter(clk,pc_isr,interrupt,add_stall,rst,pcnext,pc,pc_rst);
input [31:0]pcnext;
input clk,rst,add_stall,pc_rst;//pc_rst comes from the watchdog
input interrupt; //interrupt high
input [31:0]pc_isr; //addresss of the isr
output reg [31:0]pc;

always@(posedge clk)
begin
    if(rst | pc_rst)
        begin
            pc <= 32'h00000000; 
        end
    /*else if(!add_stall)
        begin
            pc <= pcnext;   
        end*/
    else if(add_stall)
        begin
            pc <= pc ; 
        end
    else if(interrupt)
        begin
            pc <= pc_isr;
        end  
    else if(!add_stall)
        begin
            pc <= pcnext;   
        end
             
end

    
endmodule
