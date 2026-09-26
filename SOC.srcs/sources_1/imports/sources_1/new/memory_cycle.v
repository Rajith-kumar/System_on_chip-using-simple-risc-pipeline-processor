// Pipeline Memory Stage Module
// Handles data memory operations and pipeline propagation

//module memory_cycle(clk,rst,forward_RW_M,RS1_M,RS2_M,RD_M,ra_M,pc_M,alu_result_M,rd2_M,instruction_M,isRet_M,isSt_M,isWb_M,isImmediate_M,isBeq_M,isBgt_M,isUbranch_M,isLd_M,isCall_M,isWbCsr_M,alusignals_M,pc_RW,alu_result_RW,instruction_RW,ldresult_RW,isRet_RW,isSt_RW,isWb_RW,isImmediate_RW,isBeq_RW,isBgt_RW,isUbranch_RW,isLd_RW,isCall_RW,isWbCsr_RW,alusignals_RW,RS1_RW,RS2_RW,RD_RW,ra_RW,memory_data_out);
//input clk,rst;
//input forward_RW_M;
//input [31:0]pc_M,alu_result_M,rd2_M,instruction_M;
//input  isRet_M,isSt_M,isWb_M,isImmediate_M,isBeq_M,isBgt_M,isUbranch_M,isLd_M,isCall_M,isWbCsr_M;
//input  [4:0]alusignals_M;
//input [3:0]RS1_M,RS2_M,RD_M,ra_M;
//output  [31:0]pc_RW,alu_result_RW,instruction_RW,ldresult_RW;
//output  isRet_RW,isSt_RW,isWb_RW,isImmediate_RW,isBeq_RW,isBgt_RW,isUbranch_RW,isLd_RW,isCall_RW,isWbCsr_RW;
//output  [4:0]alusignals_RW;
//output [3:0]RS1_RW,RS2_RW,RD_RW,ra_RW;
//output [31:0]memory_data_out;

//// Memory interface signals
//wire [31:0]data_out_top;
//wire [31:0]data_in_top;
//// MEM-WB pipeline registers
//reg  [31:0]pc_m,alu_result_m,instruction_m,ldresult_m;
//reg  isRet_m,isSt_m,isWb_m,isImmediate_m,isBeq_m,isBgt_m,isUbranch_m,isLd_m,isCall_m,isWbCsr_m;
//reg  [4:0]alusignals_m;
//reg  [3:0]RS1_m,RS2_m,RD_m,ra_m;
//// MEM-WB pipeline registers
//mux2x1 m60(.x(rd2_M),.z(ldresult_RW),.sel(forward_RW_M),.rst(rst),.y(data_in_top));
//memory_unit mu(.clk(clk),.isLd(isLd_M),.isSt(isSt_M),.address(alu_result_M),.data_in(data_in_top),.data_out(data_out_top));
//// Pipeline Register Update
//assign memory_data_out = data_out_top; 
//always @(posedge clk or posedge rst)
//begin
//    if(rst)
//    begin
//    pc_m <=32'b0;
//    alu_result_m <= 32'b0;
//    ldresult_m <= 32'b0; 
//    instruction_m <= 32'b0;
//    isRet_m <= 1'b0;
//    isSt_m <= 1'b0;
//    isWb_m <= 1'b0;
//    isImmediate_m <= 1'b0;
//    isBeq_m <= 1'b0;
//    isBgt_m <= 1'b0;
//    isUbranch_m <=1'b0;
//    isLd_m <= 1'b0;
//    isCall_m <= 1'b0;
//    alusignals_m <=5'b0;
//    RS1_m <= 4'bx;
//    RS2_m <= 4'bx;
//    RD_m <= 4'bx;
//    ra_m <= 4'bx;
//    isWbCsr_m <= 1'b0;
//    end
//    else
//    begin
//    pc_m <=pc_M;
//    alu_result_m <= alu_result_M ;
//    ldresult_m <= data_out_top;
//    instruction_m <= instruction_M;
//    isRet_m <= isRet_M;
//    isSt_m <= isSt_M;
//    isWb_m <= isWb_M;
//    isImmediate_m <= isImmediate_M;
//    isBeq_m <= isBeq_M;
//    isBgt_m <=isBgt_M;
//    isUbranch_m <= isUbranch_M;
//    isLd_m <= isLd_M;
//    isCall_m <= isCall_M;
//    alusignals_m <= alusignals_M;
//    RS1_m <= RS1_M ;
//    RS2_m <= RS2_M;
//    RD_m <= RD_M;
//    ra_m <= ra_M;
//    isWbCsr_m <= isWbCsr_M;
//    end
//end
//// Output assignments to Write-Back stage
//assign   pc_RW = pc_m;
//assign   alu_result_RW = alu_result_m;
//assign    ldresult_RW = ldresult_m;
//assign    instruction_RW = instruction_m;
//assign    isRet_RW = isRet_m;
//assign    isSt_RW=isSt_m;
//assign    isWb_RW = isWb_m;
//assign    isImmediate_RW = isImmediate_m;
//assign    isBeq_RW = isBeq_m;
//assign   isBgt_RW = isBgt_m;
//assign    isUbranch_RW =isUbranch_m;
//assign   isLd_RW = isLd_m;
//assign    isCall_RW = isCall_m;
//assign   alusignals_RW =alusignals_m;
//assign RS1_RW = RS1_m;
//assign RS2_RW = RS2_m;
//assign RD_RW = RD_m;
//assign ra_RW = ra_m;
//assign isWbCsr_RW = isWbCsr_m;
//endmodule

//module memory_cycle (
//    input  wire        clk,
//    input  wire        rst,
//    input  wire        forward_RW_M,
//    input  wire [3:0]  RS1_M, RS2_M, RD_M, ra_M,
//    input  wire [31:0] pc_M, alu_result_M, rd2_M, instruction_M,
//    input  wire        isRet_M, isSt_M, isWb_M, isImmediate_M, isBeq_M, isBgt_M, isUbranch_M, isLd_M, isCall_M, isWbCsr_M,
//    input  wire [4:0]  alusignals_M,
//    output reg  [31:0] pc_RW, alu_result_RW, instruction_RW, ldresult_RW,
//    output reg         isRet_RW, isSt_RW, isWb_RW, isImmediate_RW, isBeq_RW, isBgt_RW, isUbranch_RW, isLd_RW, isCall_RW, isWbCsr_RW,
//    output reg  [4:0]  alusignals_RW,
//    output reg  [3:0]  RS1_RW, RS2_RW, RD_RW, ra_RW,
//    output wire [31:0] memory_data_out,
//    // APB3 interface (word addresses)
//    output reg  [31:0] proc_addr,  // Word address
//    output reg         proc_write,
//    output reg  [31:0] proc_wdata,
//    output reg         proc_req,
//    input  wire [31:0] proc_rdata,
//    input  wire        proc_ready
//);

//// MEM-WB pipeline registers
//reg [31:0] pc_m, alu_result_m, instruction_m, ldresult_m;
//reg isRet_m, isSt_m, isWb_m, isImmediate_m, isBeq_m, isBgt_m, isUbranch_m, isLd_m, isCall_m, isWbCsr_m;
//reg [4:0] alusignals_m;
//reg [3:0] RS1_m, RS2_m, RD_m, ra_m;

//// Internal signals
//// Check for peripheral (CSR: 0x400000-0x40000F) or memory (0x800000-0x8000FF)
//wire is_peripheral = (alu_result_M[31:4] == 28'h40000) || (alu_result_M[31:8] == 24'h80 && alu_result_M[7:0] < 8'h100);
//wire [31:0] data_in = forward_RW_M ? ldresult_RW : rd2_M;

//// Memory data out
//assign memory_data_out = proc_rdata;

//// APB3 request logic
//always @(posedge clk or posedge rst) begin
//    if (rst) begin
//        proc_addr <= 32'h0;
//        proc_write <= 1'b0;
//        proc_wdata <= 32'h0;
//        proc_req <= 1'b0;
//    end
//    else begin
//        if (is_peripheral && (isLd_M || isSt_M)) begin
//            proc_addr <= alu_result_M; // Word address
//            proc_write <= isSt_M;
//            proc_wdata <= data_in;
//            proc_req <= 1'b1;
//        end
//        else begin
//            proc_req <= 1'b0;
//        end
//    end
//end

//// Pipeline register update
//always @(posedge clk or posedge rst) begin
//    if (rst) begin
//        pc_m <= 32'b0;
//        alu_result_m <= 32'b0;
//        ldresult_m <= 32'b0;
//        instruction_m <= 32'b0;
//        isRet_m <= 1'b0;
//        isSt_m <= 1'b0;
//        isWb_m <= 1'b0;
//        isImmediate_m <= 1'b0;
//        isBeq_m <= 1'b0;
//        isBgt_m <= 1'b0;
//        isUbranch_m <= 1'b0;
//        isLd_m <= 1'b0;
//        isCall_m <= 1'b0;
//        isWbCsr_m <= 1'b0;
//        alusignals_m <= 5'b0;
//        RS1_m <= 4'b0;
//        RS2_m <= 4'b0;
//        RD_m <= 4'b0;
//        ra_m <= 4'b0;
//    end
//    else if (proc_ready || !(isLd_M || isSt_M)) begin
//        pc_m <= pc_M;
//        alu_result_m <= alu_result_M;
//        ldresult_m <= proc_rdata;
//        instruction_m <= instruction_M;
//        isRet_m <= isRet_M;
//        isSt_m <= isSt_M;
//        isWb_m <= isWb_M;
//        isImmediate_m <= isImmediate_M;
//        isBeq_m <= isBeq_M;
//        isBgt_m <= isBgt_M;
//        isUbranch_m <= isUbranch_M;
//        isLd_m <= isLd_M;
//        isCall_m <= isCall_M;
//        isWbCsr_m <= isWbCsr_M;
//        alusignals_m <= alusignals_M;
//        RS1_m <= RS1_M;
//        RS2_m <= RS2_M;
//        RD_m <= RD_M;
//        ra_m <= ra_M;
//    end
//end

//// Output assignments to Write-Back stage
//assign pc_RW = pc_m;
//assign alu_result_RW = alu_result_m;
//assign ldresult_RW = ldresult_m;
//assign instruction_RW = instruction_m;
//assign isRet_RW = isRet_m;
//assign isSt_RW = isSt_m;
//assign isWb_RW = isWb_m;
//assign isImmediate_RW = isImmediate_m;
//assign isBeq_RW = isBeq_m;
//assign isBgt_RW = isBgt_m;
//assign isUbranch_RW = isUbranch_m;
//assign isLd_RW = isLd_m;
//assign isCall_RW = isCall_m;
//assign isWbCsr_RW = isWbCsr_m;
//assign alusignals_RW = alusignals_m;
//assign RS1_RW = RS1_m;
//assign RS2_RW = RS2_m;
//assign RD_RW = RD_m;
//assign ra_RW = ra_m;

//endmodule

module memory_cycle (
    input  wire        clk,
    input  wire        rst,
    input  wire        forward_RW_M,
    input  wire [31:0] pc_M, alu_result_M, rd2_M, instruction_M,
    input  wire        isRet_M, isSt_M, isWb_M, isImmediate_M, isBeq_M, isBgt_M, isUbranch_M, isLd_M, isCall_M, isWbCsr_M,
    input  wire [4:0]  alusignals_M,
    input  wire [3:0]  RS1_M, RS2_M, RD_M, ra_M,
    output wire [31:0] pc_RW, alu_result_RW, instruction_RW, ldresult_RW,
    output wire        isRet_RW, isSt_RW, isWb_RW, isImmediate_RW, isBeq_RW, isBgt_RW, isUbranch_RW, isLd_RW, isCall_RW, isWbCsr_RW,
    output wire [4:0]  alusignals_RW,
    output wire [3:0]  RS1_RW, RS2_RW, RD_RW, ra_RW,
    output wire [31:0] memory_data_out,
    // APB3 interface signals
    output reg  [31:0] proc_addr,  // Word address
    output reg         proc_write,
    output reg  [31:0] proc_wdata,
    output reg         proc_req,
    input  wire [31:0] proc_rdata,
    input  wire        proc_ready,
    // Stall signal for pipeline
    output wire        stall
);

// Memory interface signals
wire [31:0] data_out_top;
wire [31:0] data_in_top;
// MEM-WB pipeline registers
reg  [31:0] pc_m, alu_result_m, instruction_m, ldresult_m;
reg         isRet_m, isSt_m, isWb_m, isImmediate_m, isBeq_m, isBgt_m, isUbranch_m, isLd_m, isCall_m, isWbCsr_m;
reg  [4:0]  alusignals_m;
reg  [3:0]  RS1_m, RS2_m, RD_m, ra_m;

// Stall signal: active when load/store is pending and proc_ready is low
assign stall = (isLd_M || isSt_M) && !proc_ready;

// MUX for forwarding
mux2x1 m60(.x(rd2_M), .z(ldresult_RW), .sel(forward_RW_M), .rst(rst), .y(data_in_top));

// Assign data_out_top to proc_rdata
assign data_out_top = proc_rdata;

// APB3 request logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        proc_addr <= 32'h0;
        proc_write <= 1'b0;
        proc_wdata <= 32'h0;
        proc_req <= 1'b0;
    end
    else begin
        if (proc_ready && proc_req) begin
            proc_req <= (isLd_M || isSt_M); // Clear req unless new load/store
            if (isLd_M || isSt_M) begin
                proc_addr <= alu_result_M; // Update for new load/store
                proc_write <= isSt_M;
                proc_wdata <= data_in_top;
            end
        end
        else if (isLd_M || isSt_M) begin
            proc_addr <= alu_result_M; // Set for new load/store
            proc_write <= isSt_M;
            proc_wdata <= data_in_top;
            proc_req <= 1'b1;
        end
        else begin
            proc_req <= 1'b0;
        end
    end
end

// Pipeline Register Update
assign memory_data_out = data_out_top; 
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_m <= 32'b0;
        alu_result_m <= 32'b0;
        ldresult_m <= 32'b0; 
        instruction_m <= 32'b0;
        isRet_m <= 1'b0;
        isSt_m <= 1'b0;
        isWb_m <= 1'b0;
        isImmediate_m <= 1'b0;
        isBeq_m <= 1'b0;
        isBgt_m <= 1'b0;
        isUbranch_m <= 1'b0;
        isLd_m <= 1'b0;
        isCall_m <= 1'b0;
        alusignals_m <= 5'b0;
        RS1_m <= 4'bx;
        RS2_m <= 4'bx;
        RD_m <= 4'bx;
        ra_m <= 4'bx;
        isWbCsr_m <= 1'b0;
    end
    else if (proc_ready || !(isLd_M || isSt_M)) begin
        pc_m <= pc_M;
        alu_result_m <= alu_result_M;
        ldresult_m <= data_out_top; // Use proc_rdata via data_out_top
        instruction_m <= instruction_M;
        isRet_m <= isRet_M;
        isSt_m <= isSt_M;
        isWb_m <= isWb_M;
        isImmediate_m <= isImmediate_M;
        isBeq_m <= isBeq_M;
        isBgt_m <= isBgt_M;
        isUbranch_m <= isUbranch_M;
        isLd_m <= isLd_M;
        isCall_m <= isCall_M;
        alusignals_m <= alusignals_M;
        RS1_m <= RS1_M;
        RS2_m <= RS2_M;
        RD_m <= RD_M;
        ra_m <= ra_M;
        isWbCsr_m <= isWbCsr_M;
    end
end

// Output assignments to Write-Back stage
assign pc_RW = pc_m;
assign alu_result_RW = alu_result_m;
assign ldresult_RW = ldresult_m;
assign instruction_RW = instruction_m;
assign isRet_RW = isRet_m;
assign isSt_RW = isSt_m;
assign isWb_RW = isWb_m;
assign isImmediate_RW = isImmediate_m;
assign isBeq_RW = isBeq_m;
assign isBgt_RW = isBgt_m;
assign isUbranch_RW = isUbranch_m;
assign isLd_RW = isLd_m;
assign isCall_RW = isCall_m;
assign alusignals_RW = alusignals_m;
assign RS1_RW = RS1_m;
assign RS2_RW = RS2_m;
assign RD_RW = RD_m;
assign ra_RW = ra_m;
assign isWbCsr_RW = isWbCsr_m;

endmodule