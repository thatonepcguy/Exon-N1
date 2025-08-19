`include "../../common.svh"

module ID_Stage #(
    parameter width = 32
)(
    input clk,
    input clkEn,
    input rst,

    input flush_req_t flush,
    input stall_t stall,

    input if_stage_output_t stageInput,
    output id_stage_output_t stageOutput,

    input wire [width-1:0] instruction
);

    always_ff @(posedge clk) begin
        if (rst) begin
            stageOutput <= 0;

        end else if (clkEn) begin
            if (!stall.stallEn) begin
                stageOutput.PC <= stageInput.PC;

            end else if (flush.flushEn) begin
                stageOutput <= 0;

            end else if (stall.stallEn && stall.start) begin
                stageOutput <= 0;
            end
        end 
    end
    

    always_comb begin
        
    end
    
    
endmodule
