module data_hazard_stall(clk,instruction_D,isWb_D,instruction_M,instruction_E,isWb_E,add_stall);
input clk;
input isWb_E;
input isWb_D;
input [31:0]instruction_M,instruction_E,instruction_D;
output add_stall;
                                                                                                   
assign add_stall = ((instruction_E[31:27] == 5'b01110) & ((instruction_E[25:22] == instruction_D[21:18]) | (instruction_E[25:22] == instruction_D[17:14])) &/*(isWb_D)*/ (instruction_D[31:27]!= 5'b01111) ) || 
                   ((instruction_E[31:27] == 5'b01110) & ((instruction_E[25:22] == 4'd15) &(instruction_D[31:27] == 5'b10100)))  ||  // ld-use hazard while using ret after pop r15 instruction 
                    ((instruction_E[31:27] == 5'b01110) & ((instruction_E[25:22] == 4'd12) &(instruction_D[31:27] == 5'b10101))) ? 1'b1 : 1'b0 ; // ld-use hazard while using iret after pop r12 instruction 
// ld ke baad alu operation

endmodule
