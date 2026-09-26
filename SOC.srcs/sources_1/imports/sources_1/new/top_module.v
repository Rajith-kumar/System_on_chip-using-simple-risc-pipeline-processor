//// SimpleRisc 5-Stage Pipeline Top Module
//// Integrates fetch, decode, execute, memory, and writeback stages
//// Implements data forwarding hazard resolution
 
//module processor(clk,proc_write,proc_wdata,proc_wdata,proc_req,proc_rdata,proc_ready, rst,pc_rst,interrupt_pin_high,interrupt_pin_low,isWbCsr,isRdCsr,data_csr,rd_write_csr,rd_read_csr,data_out_csr,Iret,watchdog_rst,);
//    input clk, rst,pc_rst,interrupt_pin_high , interrupt_pin_low;
//    input [31:0]data_out_csr;
//    output isWbCsr,isRdCsr;
//    output [3:0]rd_write_csr;
//    output [3:0]rd_read_csr;
//    output [31:0]data_csr;
//    output Iret;// added Iret signal 
//    output watchdog_rst;
    
    
//output          proc_write;
//output   [31:0] proc_wdata;
//output          proc_req;
//input  wire [31:0] proc_rdata;
//input  wire        proc_ready;
    
    
  
////=================================================================
//// Inter-stage Connection Wires
////=================================================================
//    // FETCH → DECODE wires
//    wire isbranchtaken_E_top;
//    wire [31:0] pc_branch_E_top, instruction_D_top, pc_D_top;

//    // DECODE → EXECUTE wires
//    wire [31:0] data_RW_top, pc_E_top, branch_target_E_top, b_E_top, a_E_top, rd2_E_top, instruction_E_top;
//    wire [3:0] reg_RW_top;
//    wire isRet_E_top, isSt_E_top, isWb_E_top, isImmediate_E_top, isBeq_E_top, isBgt_E_top, isUbranch_E_top, isLd_E_top, isCall_E_top,isIret_E_top,isWbCsr_E_top,isRdCsr_E_top,Iret;//changed Iret signal 
//    wire [13:0] alusignals_E_top;
//    wire [3:0]RS1_E_top,RS2_E_top,RD_E_top,ra_E_top;

//    // EXECUTE → MEMORY wires
//    wire [31:0] pc_M_top, alu_result_M_top, rd2_M_top, instruction_M_top;
//    wire isRet_M_top, isSt_M_top, isWb_M_top, isImmediate_M_top, isBeq_M_top, isBgt_M_top, isUbranch_M_top, isLd_M_top, isCall_M_top,isWbCsr_M_top;
//    wire [4:0] alusignals_M_top;
//    wire [3:0]RS1_M_top,RS2_M_top,RD_M_top,ra_M_top;

//    // MEMORY → WRITEBACK wires
//    wire [31:0] pc_RW_top, alu_result_RW_top, instruction_RW_top, ldresult_RW_top;
//    wire isRet_RW_top, isSt_RW_top, isWb_RW_top, isImmediate_RW_top, isBeq_RW_top, isBgt_RW_top, isUbranch_RW_top, isLd_RW_top, isCall_RW_top,isWbCsr_RW_top;
//    wire [4:0] alusignals_RW_top;
//    wire [3:0]RS1_RW_top,RS2_RW_top,RD_RW_top,ra_RW_top;

//    // WRITEBACK → DECODE feedback
//    wire iswb_RW_D_top;//iswbcsr_RW_D_top;
    
//    //datahazard --> execute 
//    wire [1:0]forwardA_E_top,forwardB_E_top,forwardA_top;
//    wire forward_RW_M_top;
//    wire [31:0]memory_data_out_top;
//    wire add_stall_top;
//    wire isWb_D_hazard_top;
    
//    //interrupt to processor
//    wire interrupt_out_top;
//    wire [31:0]pc_isr_top;
//    wire [1:0]flags_out_D_top;
//    wire [1:0]flag_out_EX_top;
    
//    wire  proc_write_top;
//    wire  [31:0] proc_wdata_top;
//    wire proc_req_top;
//    wire [31:0] proc_rdata_top;
//    wire        proc_ready_top;
// //==================================================================
//// Pipeline Stage Instances
////==================================================================
//        // FETCH CYCLE
//    fetch_cycle fc(
//        .clk(clk),
//        .rst(rst),
//        .pc_rst(pc_rst),
//        .interrupt(interrupt_out_top),
//        .pc_isr(pc_isr_top),
//        .add_stall(add_stall_top),
//        .isbranchtaken_E(isbranchtaken_E_top),
//        .pc_branch_E(pc_branch_E_top),
//        .instruction_D(instruction_D_top),
//        .pc_D(pc_D_top)
//    );

//    // DECODE CYCLE
//    decode_cycle dc(
//        .clk(clk),
//        .rst(rst),
//        .csr_data(data_out_csr),
//        .flag_out_EX(flag_out_EX_top),
//        .flags(flags_out_D_top),
//        .add_stall(add_stall_top),
//        .interrupt(interrupt_out_top),
//        .isbranch_taken_E(isbranchtaken_E_top),
//        .pc_D(pc_D_top),
//        .instruction_D(instruction_D_top),
//        .reg_RW(reg_RW_top),
//        .data_RW(data_RW_top),
//        .iswb_RW_D(iswb_RW_D_top),
//        //.iswbcsr_RW_D(iswbcsr_RW_D_top),
//        .pc_E(pc_E_top),
//        .branch_target_E(branch_target_E_top),
//        .b_E(b_E_top),
//        .a_E(a_E_top),
//        .rd2_E(rd2_E_top),
//        .instruction_E(instruction_E_top),
//        .isRet_E(isRet_E_top),
//        .isSt_E(isSt_E_top),
//        .isWb_E(isWb_E_top),
//        .isImmediate_E(isImmediate_E_top),
//        .isBeq_E(isBeq_E_top),
//        .isBgt_E(isBgt_E_top),
//        .isUbranch_E(isUbranch_E_top),
//        .isLd_E(isLd_E_top),
//        .isCall_E(isCall_E_top),
//        .isIret_E(isIret_E_top),
//        .isWbCsr_E(isWbCsr_E_top),
//        .isRdCsr_E(isRdCsr_E_top),
//        .alusignals_E(alusignals_E_top),
//        .RS1_E(RS1_E_top),
//        .RS2_E(RS2_E_top),
//        .RD_E(RD_E_top),
//        .ra_E(ra_E_top),
//        .iswb_D_hazard(isWb_D_hazard_top)
//        //.isRdCsr_CSR(isRdCsr)
//    );

//    // EXECUTE CYCLE
//    execute_cycle ec(
//        .clk(clk),
//        .rst(rst),
//        .flags_out_D(flags_out_D_top),
//        .flag_D_in(flag_out_EX_top),
//        .add_stall(add_stall_top),
//        .memory_unit_data(alu_result_RW_top),
//        .memory_data_out(memory_data_out_top),
//        .data_RW_E(data_RW_top),
//        .data_M_E(alu_result_M_top),
//        .forwardA_E(forwardA_E_top),
//        .forwardB_E(forwardB_E_top),
//        .forwardA(forwardA_top),
//         .RS1_E(RS1_E_top),
//         .RS2_E(RS2_E_top),
//         .RD_E(RD_E_top),
//         .ra_E(ra_E_top),
//        .pc_E(pc_E_top),
//        .branch_target_E(branch_target_E_top),
//        .b_E(b_E_top),
//        .a_E(a_E_top),
//        .rd2_E(rd2_E_top),
//        .instruction_E(instruction_E_top),
//        .isRet_E(isRet_E_top),
//        .isSt_E(isSt_E_top),
//        .isWb_E(isWb_E_top),
//        .isImmediate_E(isImmediate_E_top),
//        .isBeq_E(isBeq_E_top),
//        .isBgt_E(isBgt_E_top),
//        .isUbranch_E(isUbranch_E_top),
//        .isLd_E(isLd_E_top),
//        .isCall_E(isCall_E_top),
//        .isIret_E(isIret_E_top),
//        .isWbCsr_E(isWbCsr_E_top),
//        .isRdCsr_E(isRdCsr_E_top),
//        .alusignals_E(alusignals_E_top),
//        .isbranchtaken_E(isbranchtaken_E_top),
//        .pc_branch_E(pc_branch_E_top),
//        .pc_M(pc_M_top),
//        .alu_result_M(alu_result_M_top),
//        .rd2_M(rd2_M_top),
//        .instruction_M(instruction_M_top),
//        .isRet_M(isRet_M_top),
//        .isSt_M(isSt_M_top),
//        .isWb_M(isWb_M_top),
//        .isImmediate_M(isImmediate_M_top),
//        .isBeq_M(isBeq_M_top),
//        .isBgt_M(isBgt_M_top),
//        .isUbranch_M(isUbranch_M_top),
//        .isLd_M(isLd_M_top),
//        .isCall_M(isCall_M_top),
//        .isWbCsr_M(isWbCsr_M_top),
//        .alusignals_M(alusignals_M_top),
//        .RS1_M(RS1_M_top),
//        .RS2_M(RS2_M_top),
//        .RD_M(RD_M_top),
//        .ra_M(ra_M_top)
//    );

//    // MEMORY CYCLE
//    memory_cycle mc(
//        .clk(clk),
//        .rst(rst),
//        .forward_RW_M(forward_RW_M_top),
//        .RS1_M(RS1_M_top),
//        .RS2_M(RS2_M_top),
//        .RD_M(RD_M_top),
//        .ra_M(ra_M_top),
//        .pc_M(pc_M_top),
//        .alu_result_M(alu_result_M_top),
//        .rd2_M(rd2_M_top),
//        .instruction_M(instruction_M_top),
//        .isRet_M(isRet_M_top),
//        .isSt_M(isSt_M_top),
//        .isWb_M(isWb_M_top),
//        .isImmediate_M(isImmediate_M_top),
//        .isBeq_M(isBeq_M_top),
//        .isBgt_M(isBgt_M_top),
//        .isUbranch_M(isUbranch_M_top),
//        .isLd_M(isLd_M_top),
//        .isCall_M(isCall_M_top),
//        .isWbCsr_M(isWbCsr_M_top),
//        .alusignals_M(alusignals_M_top),
//        .pc_RW(pc_RW_top),
//        .alu_result_RW(alu_result_RW_top),
//        .instruction_RW(instruction_RW_top),
//        .ldresult_RW(ldresult_RW_top),
//        .isRet_RW(isRet_RW_top),
//        .isSt_RW(isSt_RW_top),
//        .isWb_RW(isWb_RW_top),
//        .isImmediate_RW(isImmediate_RW_top),
//        .isBeq_RW(isBeq_RW_top),
//        .isBgt_RW(isBgt_RW_top),
//        .isUbranch_RW(isUbranch_RW_top),
//        .isLd_RW(isLd_RW_top),
//        .isCall_RW(isCall_RW_top),
//        .isWbCsr_RW(isWbCsr_RW_top),
//        .alusignals_RW(alusignals_RW_top),
//        .RS1_RW(RS1_RW_top),
//        .RS2_RW(RS2_RW_top),
//        .RD_RW(RD_RW_top),
//        .ra_RW(ra_RW_top),
//        .memory_data_out(memory_data_out_top),
//        .proc_addr(proc_addr_top),
//        .proc_write(proc_write_top),
//        .proc_wdata(proc_wdata_top),
//        .proc_req(proc_req_top),
//        .proc_rdata(proc_rdata_top),
//        .proc_ready(proc_ready_top),
//        .stall(add_stall_top)
        
//    );

//    // WRITEBACK CYCLE
//    writeback_cycle wc(
//        .clk(clk),
//        .rst(rst),
//        .RS1_RW(RS1_RW_top),
//        .RS2_RW(RS2_RW_top),
//        .RD_RW(RD_RW_top),
//        .ra_RW(ra_RW_top),
//        .pc_RW(pc_RW_top),
//        .alu_result_RW(alu_result_RW_top),
//        .instruction_RW(instruction_RW_top),
//        .ldresult_RW(ldresult_RW_top),
//        .isRet_RW(isRet_RW_top),
//        .isSt_RW(isSt_RW_top),
//        .isWb_RW(isWb_RW_top),
//        .isImmediate_RW(isImmediate_RW_top),
//        .isBeq_RW(isBeq_RW_top),
//        .isBgt_RW(isBgt_RW_top),
//        .isUbranch_RW(isUbranch_RW_top),
//        .isLd_RW(isLd_RW_top),
//        .isCall_RW(isCall_RW_top),
//        .isWbCsr_RW(isWbCsr_RW_top),
//        .alusignals_RW(alusignals_RW_top),
//        .data_RW(data_RW_top),
//        .iswb_RW_D(iswb_RW_D_top),
//        .iswbcsr_RW_D(iswbcsr_RW_D_top),
//        .reg_RW(reg_RW_top)
//    );
//    // Data Hazard Resolution Unit
// data_hazard_unit dhu(
//         .rst(rst),
//         .isWb_M(isWb_M_top),
//         .isWbCsr_M(isWbCsr_M_top),
//         .isWbCsr_E(isWbCsr_E_top),
//         .isWbCsr_RW(isWbCsr_RW_top),
//         .isRdCsr_E(isRdCsr_E_top),
//         .instruction_m(instruction_M_top),
//         .instruction_rw(instruction_RW_top),
//         .instruction_e(instruction_E_top),
//         .isWb_RW(isWb_RW_top),
//         .RD_E(RD_E_top),
//         .RD_M(RD_M_top),
//         .RD_RW(RD_RW_top),
//         .RS1_E(RS1_E_top),
//         .RS2_E(RS2_E_top),
//         .forwardA_E(forwardA_E_top),
//         .forwardB_E(forwardB_E_top),
//         .forwardA_M_E(forwardA_top),
//         .forward_RW_M(forward_RW_M_top)
//         );
     
//  data_hazard_stall dhs(
//                .clk(clk),
//                .instruction_M(instruction_M_top),
//                .instruction_E(instruction_E_top),
//                .instruction_D(instruction_D_top),
//                .isWb_E(isWb_E_top),
//                .isWb_D(isWb_D_hazard_top),
//                .add_stall(add_stall_top)
//                );
// // interrupt_handler with two int pins for high and low 
// interrupt_handler interrupt_handler(
//     .clk(clk),
//     .interrupt_pin_high(interrupt_pin_high),
//     .interrupt_pin_low(interrupt_pin_low),
     
//     .interrupt_out(interrupt_out_top),
//      .pc_isr(pc_isr_top)
//);
////Adding the counter for the watchog counter

//watchdog_rst_counter dog_counter(
//    .clk(clk),
//    .present_pc(pc_D_top),
//    .previous_pc(pc_E_top),
//    .watchdog_rst(watchdog_rst)
//    );

//assign isWbCsr = iswbcsr_RW_D_top;
//assign rd_write_csr = reg_RW_top;
//assign data_csr = data_RW_top;
//assign rd_read_csr = instruction_D_top[25:22];
//assign isRdCsr = isRdCsr_E_top ;
//assign Iret = isIret_E_top;
//assign proc_addr = proc_addr_top;
//assign proc_write = proc_write_top;
//assign proc_wdata = proc_wdata_top;
//assign proc_req = proc_req_top;

//endmodule


module processor(
    input clk, rst, pc_rst, interrupt_pin_high, interrupt_pin_low,
    input [31:0] data_out_csr,
    output isWbCsr, isRdCsr,
    output [3:0] rd_write_csr,
    output [3:0] rd_read_csr,
    output [31:0] data_csr,
    output Iret,
    output watchdog_rst,
    output proc_write,
    output [31:0] proc_wdata,
    output proc_req,
    input [31:0] proc_rdata,
    input proc_ready,
    output [31:0]proc_addr
);

// Inter-stage Connection Wires
wire isbranchtaken_E_top;
wire [31:0] pc_branch_E_top, instruction_D_top, pc_D_top;
wire [31:0] data_RW_top, pc_E_top, branch_target_E_top, b_E_top, a_E_top, rd2_E_top, instruction_E_top;
wire [3:0] reg_RW_top;
wire isRet_E_top, isSt_E_top, isWb_E_top, isImmediate_E_top, isBeq_E_top, isBgt_E_top, isUbranch_E_top, isLd_E_top, isCall_E_top, isIret_E_top, isWbCsr_E_top, isRdCsr_E_top;
wire [13:0] alusignals_E_top;
wire [3:0] RS1_E_top, RS2_E_top, RD_E_top, ra_E_top;
wire [31:0] pc_M_top, alu_result_M_top, rd2_M_top, instruction_M_top;
wire isRet_M_top, isSt_M_top, isWb_M_top, isImmediate_M_top, isBeq_M_top, isBgt_M_top, isUbranch_M_top, isLd_M_top, isCall_M_top, isWbCsr_M_top;
wire [4:0] alusignals_M_top;
wire [3:0] RS1_M_top, RS2_M_top, RD_M_top, ra_M_top;
wire [31:0] pc_RW_top, alu_result_RW_top, instruction_RW_top, ldresult_RW_top;
wire isRet_RW_top, isSt_RW_top, isWb_RW_top, isImmediate_RW_top, isBeq_RW_top, isBgt_RW_top, isUbranch_RW_top, isLd_RW_top, isCall_RW_top, isWbCsr_RW_top;
wire [4:0] alusignals_RW_top;
wire [3:0] RS1_RW_top, RS2_RW_top, RD_RW_top, ra_RW_top;
wire iswb_RW_D_top, iswbcsr_RW_D_top;
wire [1:0] forwardA_E_top, forwardB_E_top, forwardA_top;
wire forward_RW_M_top;
wire [31:0] memory_data_out_top;
wire add_stall_top, mem_stall, hazard_stall;
wire isWb_D_hazard_top;
wire interrupt_out_top;
wire [31:0] pc_isr_top;
wire [1:0] flags_out_D_top, flag_out_EX_top;
wire [31:0] proc_addr_top;
wire proc_write_top;
wire [31:0] proc_wdata_top;
wire proc_req_top;
wire [31:0] proc_rdata_top;
wire proc_ready_top;

// APB3 connections
assign proc_rdata_top = proc_rdata;
assign proc_ready_top = proc_ready;
assign proc_addr = proc_addr_top;
assign proc_write = proc_write_top;
assign proc_wdata = proc_wdata_top;
assign proc_req = proc_req_top;

// Combine stall signals
assign add_stall_top = hazard_stall;

// FETCH CYCLE
fetch_cycle fc(
    .clk(clk),
    .rst(rst),
    .pc_rst(pc_rst),
    .interrupt(interrupt_out_top),
    .pc_isr(pc_isr_top),
    .add_stall(add_stall_top),
    .isbranchtaken_E(isbranchtaken_E_top),
    .pc_branch_E(pc_branch_E_top),
    .instruction_D(instruction_D_top),
    .pc_D(pc_D_top),
    .memstall(mem_stall)
);

// DECODE CYCLE
decode_cycle dc(
    .clk(clk),
    .rst(rst),
    .csr_data(data_out_csr),
    .flag_out_EX(flag_out_EX_top),
    .flags(flags_out_D_top),
    .add_stall(add_stall_top),
    .interrupt(interrupt_out_top),
    .isbranch_taken_E(isbranchtaken_E_top),
    .pc_D(pc_D_top),
    .instruction_D(instruction_D_top),
    .reg_RW(reg_RW_top),
    .data_RW(data_RW_top),
    .iswb_RW_D(iswb_RW_D_top),
    .pc_E(pc_E_top),
    .branch_target_E(branch_target_E_top),
    .b_E(b_E_top),
    .a_E(a_E_top),
    .rd2_E(rd2_E_top),
    .instruction_E(instruction_E_top),
    .isRet_E(isRet_E_top),
    .isSt_E(isSt_E_top),
    .isWb_E(isWb_E_top),
    .isImmediate_E(isImmediate_E_top),
    .isBeq_E(isBeq_E_top),
    .isBgt_E(isBgt_E_top),
    .isUbranch_E(isUbranch_E_top),
    .isLd_E(isLd_E_top),
    .isCall_E(isCall_E_top),
    .isIret_E(isIret_E_top),
    .isWbCsr_E(isWbCsr_E_top),
    .isRdCsr_E(isRdCsr_E_top),
    .alusignals_E(alusignals_E_top),
    .RS1_E(RS1_E_top),
    .RS2_E(RS2_E_top),
    .RD_E(RD_E_top),
    .ra_E(ra_E_top),
    .iswb_D_hazard(isWb_D_hazard_top),
    .memstall(mem_stall)
);

// EXECUTE CYCLE
execute_cycle ec(
    .clk(clk),
    .rst(rst),
    .flags_out_D(flags_out_D_top),
    .flag_D_in(flag_out_EX_top),
    .add_stall(add_stall_top),
    .memory_unit_data(alu_result_RW_top),
    .memory_data_out(memory_data_out_top),
    .data_RW_E(data_RW_top),
    .data_M_E(alu_result_M_top),
    .forwardA_E(forwardA_E_top),
    .forwardB_E(forwardB_E_top),
    .forwardA(forwardA_top),
    .RS1_E(RS1_E_top),
    .RS2_E(RS2_E_top),
    .RD_E(RD_E_top),
    .ra_E(ra_E_top),
    .pc_E(pc_E_top),
    .branch_target_E(branch_target_E_top),
    .b_E(b_E_top),
    .a_E(a_E_top),
    .rd2_E(rd2_E_top),
    .instruction_E(instruction_E_top),
    .isRet_E(isRet_E_top),
    .isSt_E(isSt_E_top),
    .isWb_E(isWb_E_top),
    .isImmediate_E(isImmediate_E_top),
    .isBeq_E(isBeq_E_top),
    .isBgt_E(isBgt_E_top),
    .isUbranch_E(isUbranch_E_top),
    .isLd_E(isLd_E_top),
    .isCall_E(isCall_E_top),
    .isIret_E(isIret_E_top),
    .isWbCsr_E(isWbCsr_E_top),
    .isRdCsr_E(isRdCsr_E_top),
    .alusignals_E(alusignals_E_top),
    .isbranchtaken_E(isbranchtaken_E_top),
    .pc_branch_E(pc_branch_E_top),
    .pc_M(pc_M_top),
    .alu_result_M(alu_result_M_top),
    .rd2_M(rd2_M_top),
    .instruction_M(instruction_M_top),
    .isRet_M(isRet_M_top),
    .isSt_M(isSt_M_top),
    .isWb_M(isWb_M_top),
    .isImmediate_M(isImmediate_M_top),
    .isBeq_M(isBeq_M_top),
    .isBgt_M(isBgt_M_top),
    .isUbranch_M(isUbranch_M_top),
    .isLd_M(isLd_M_top),
    .isCall_M(isCall_M_top),
    .isWbCsr_M(isWbCsr_M_top),
    .alusignals_M(alusignals_M_top),
    .RS1_M(RS1_M_top),
    .RS2_M(RS2_M_top),
    .RD_M(RD_M_top),
    .ra_M(ra_M_top),
    .memstall(mem_stall)
);

// MEMORY CYCLE
memory_cycle mc(
    .clk(clk),
    .rst(rst),
    .forward_RW_M(forward_RW_M_top),
    .RS1_M(RS1_M_top),
    .RS2_M(RS2_M_top),
    .RD_M(RD_M_top),
    .ra_M(ra_M_top),
    .pc_M(pc_M_top),
    .alu_result_M(alu_result_M_top),
    .rd2_M(rd2_M_top),
    .instruction_M(instruction_M_top),
    .isRet_M(isRet_M_top),
    .isSt_M(isSt_M_top),
    .isWb_M(isWb_M_top),
    .isImmediate_M(isImmediate_M_top),
    .isBeq_M(isBeq_M_top),
    .isBgt_M(isBgt_M_top),
    .isUbranch_M(isUbranch_M_top),
    .isLd_M(isLd_M_top),
    .isCall_M(isCall_M_top),
    .isWbCsr_M(isWbCsr_M_top),
    .alusignals_M(alusignals_M_top),
    .pc_RW(pc_RW_top),
    .alu_result_RW(alu_result_RW_top),
    .instruction_RW(instruction_RW_top),
    .ldresult_RW(ldresult_RW_top),
    .isRet_RW(isRet_RW_top),
    .isSt_RW(isSt_RW_top),
    .isWb_RW(isWb_RW_top),
    .isImmediate_RW(isImmediate_RW_top),
    .isBeq_RW(isBeq_RW_top),
    .isBgt_RW(isBgt_RW_top),
    .isUbranch_RW(isUbranch_RW_top),
    .isLd_RW(isLd_RW_top),
    .isCall_RW(isCall_RW_top),
    .isWbCsr_RW(isWbCsr_RW_top),
    .alusignals_RW(alusignals_RW_top),
    .RS1_RW(RS1_RW_top),
    .RS2_RW(RS2_RW_top),
    .RD_RW(RD_RW_top),
    .ra_RW(ra_RW_top),
    .memory_data_out(memory_data_out_top),
    .proc_addr(proc_addr_top),
    .proc_write(proc_write_top),
    .proc_wdata(proc_wdata_top),
    .proc_req(proc_req_top),
    .proc_rdata(proc_rdata_top),
    .proc_ready(proc_ready_top),
    .stall(mem_stall)
);

// WRITEBACK CYCLE
writeback_cycle wc(
    .clk(clk),
    .rst(rst),
    .RS1_RW(RS1_RW_top),
    .RS2_RW(RS2_RW_top),
    .RD_RW(RD_RW_top),
    .ra_RW(ra_RW_top),
    .pc_RW(pc_RW_top),
    .alu_result_RW(alu_result_RW_top),
    .instruction_RW(instruction_RW_top),
    .ldresult_RW(ldresult_RW_top),
    .isRet_RW(isRet_RW_top),
    .isSt_RW(isSt_RW_top),
    .isWb_RW(isWb_RW_top),
    .isImmediate_RW(isImmediate_RW_top),
    .isBeq_RW(isBeq_RW_top),
    .isBgt_RW(isBgt_RW_top),
    .isUbranch_RW(isUbranch_RW_top),
    .isLd_RW(isLd_RW_top),
    .isCall_RW(isCall_RW_top),
    .isWbCsr_RW(isWbCsr_RW_top),
    .alusignals_RW(alusignals_RW_top),
    .data_RW(data_RW_top),
    .iswb_RW_D(iswb_RW_D_top),
    .iswbcsr_RW_D(iswbcsr_RW_D_top),
    .reg_RW(reg_RW_top),
    .memstall(mem_stall)
);

// Data Hazard Resolution Unit
data_hazard_unit dhu(
    .rst(rst),
    .isWb_M(isWb_M_top),
    .isWbCsr_M(isWbCsr_M_top),
    .isWbCsr_E(isWbCsr_E_top),
    .isWbCsr_RW(isWbCsr_RW_top),
    .isRdCsr_E(isRdCsr_E_top),
    .instruction_m(instruction_M_top),
    .instruction_rw(instruction_RW_top),
    .instruction_e(instruction_E_top),
    .isWb_RW(isWb_RW_top),
    .RD_E(RD_E_top),
    .RD_M(RD_M_top),
    .RD_RW(RD_RW_top),
    .RS1_E(RS1_E_top),
    .RS2_E(RS2_E_top),
    .forwardA_E(forwardA_E_top),
    .forwardB_E(forwardB_E_top),
    .forwardA_M_E(forwardA_top),
    .forward_RW_M(forward_RW_M_top)
);

data_hazard_stall dhs(
    .clk(clk),
    .instruction_M(instruction_M_top),
    .instruction_E(instruction_E_top),
    .instruction_D(instruction_D_top),
    .isWb_E(isWb_E_top),
    .isWb_D(isWb_D_hazard_top),
    .add_stall(hazard_stall)
);

// Interrupt Handler
interrupt_handler ih(
    .clk(clk),
    .interrupt_pin_high(interrupt_pin_high),
    .interrupt_pin_low(interrupt_pin_low),
    .interrupt_out(interrupt_out_top),
    .pc_isr(pc_isr_top)
);

// Watchdog Reset Counter
watchdog_rst_counter dog_counter(
    .clk(clk),
    .present_pc(pc_D_top),
    .previous_pc(pc_E_top),
//    .stall(add_stall_top), // Add stall input
    .watchdog_rst(watchdog_rst)
);

// CSR Assignments
assign isWbCsr = iswbcsr_RW_D_top;
assign rd_write_csr = reg_RW_top;
assign data_csr = data_RW_top;
assign rd_read_csr = instruction_D_top[11:8]; // Corrected rd field
assign isRdCsr = isRdCsr_E_top;
assign Iret = isIret_E_top;

endmodule