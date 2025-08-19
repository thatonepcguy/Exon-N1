`include "../../common.svh"

module IF_Stage #(
    parameter width = 32
    ) (
    input wire clk,
    input wire clkEn, 
    input wire rst,

    input flush_req_t flush,
    input stall_t stall,

    output if_stage_output_t stageOutput,
    output l1i_request_t L1iRequest
);

    reg [width-1:0] PC;

    always_ff @(posedge clk) begin
        if (rst) begin
            PC <= 0;
            stageOutput.PC <= 0;

        end else if (clkEn) begin
            if (!stall.stallEn) begin
                stageOutput.PC <= PC;
                PC <= PC+4;
            
            end else if (flush.flushEn) begin
                PC <= flush.flushAddress;
                stageOutput <= 0;

            end else if (stall.stallEn && stall.start) begin
                stageOutput <= 0;
            end
        end 
    end
    
    assign L1iRequest.address = (flush.flushEn) ? flush.flushAddress : PC;
endmodule
