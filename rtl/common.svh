`pragma once

typedef struct packed {
    logic [31:0] PC;
} if_stage_output_t;

typedef struct packed {
    logic [3:0] aluOpSel;
    logic memImm;
    logic readMem;
    logic writeMem;
    logic wb;
    logic [1:0] memAccessSize;
    logic branch;
    logic jump;
    logic [1:0] preMemEXMux1; // imm, rs1, rs3, 0
    logic [1:0] preMemEXMux2; // pc, rs2, imm, 0
    logic [1:0] postMemExMux1; // rs2, imm, 0
    logic adrMux1; // imm, rs2
    logic adrMux2; // pc, rs1
} control_signals_t;


typedef struct packed {
    logic [31:0] PC;
    logic [31:0] imm;
    control_signals_t controlSignals;
    logic [31:0] r1;
    logic [31:0] r2;
    logic [31:0] r3;
    logic [4:0] rd;
    logic branchPrediction;
} id_stage_output_t;

typedef struct packed {
    logic [31:0] PC;
    logic [31:0] imm;
    logic [31:0] memAdr;
    control_signals_t controlSignals;
    logic [31:0] r1;
    logic [31:0] r2;
    logic [31:0] r3;
    logic [4:0] rd;
    logic branchPrediction;
} adr_stage_output_t;

typedef struct packed {
    logic [31:0] address;
} l1i_request_t;

typedef struct packed {
    logic [31:0] flushAddress;
    logic flushEn;
} flush_req_t;

typedef struct packed {
    logic stallEn;
    logic start;
} stall_t;