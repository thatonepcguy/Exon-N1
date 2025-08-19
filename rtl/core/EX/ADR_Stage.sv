`include "../../common.svh"

module ADR_Stage #(
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
    wire [width-1:0] memAddr;

    always_ff @(posedge clk) begin
        if (rst) begin
            stageOutput <= 0;

        end else if (clkEn) begin
            if (!stall.stallEn) begin
                stageOutput.branchPrediction = stageInput.branchPrediction;
                stageOutput.controlSignals = stageInput.controlSignals;
                stageOutput.imm = stageInput.imm;
                stageOutput.memAdr = memAddr;
                stageOutput.r1 = stageInput.r1;
                stageOutput.r2 = stageInput.r2;
                stageOutput.r3 = stageInput.r3;
                stageOutput.rd = stageInput.rd;
            
            end else if (flush.flushEn) begin
                stageOutput <= 0;

            end else if (stall.stallEn && stall.start) begin
                stageOutput <= 0;
            end
        end 
    end

    always_comb begin
        memAddr = 0;
        if (stageInput.controlSignals.adrMux1) begin
            if (forwardData1Reg == 1) begin
                memAddr += forwardData1;
            end else if (forwardData2Reg == 1) begin
                memAddr += forwardData2;
            end else begin
                memAddr += stageInput.r1;
            end
        end else begin
            memAddr += stageInput.imm;
        end

        if (stageInput.controlSignals.adrMux1) begin
            if (forwardData1Reg == 2) begin
                memAddr += forwardData1;
            end else if (forwardData2Reg == 2) begin
                memAddr += forwardData2;
            end else begin
                memAddr += stageInput.r2;
            end
        end else begin
            memAddr += stageInput.PC;
        end
    end

endmodule
