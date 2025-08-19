`include "../../common.svh"

module PRE_EX_Stage #(
    parameter width = 32
)(
    input clk,
    input clkEn,
    input rst,

    input flush_req_t flush,
    input stall_t stall,

    input id_stage_output_t stageInput,
    output adr_stage_output_t stageOutput,

    input wire [width-1:0] forwardData1,
    input wire [width-1:0] forwardData2,
    input wire [1:0] forwardData1Reg,
    input wire [1:0] forwardData2Reg
);
    
endmodule
