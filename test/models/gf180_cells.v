`timescale 1ns / 1ps
`default_nettype none

module gf180mcu_fd_sc_mcu7t5v0__nand2_1 (
    input  wire A1,
    input  wire A2,
    output wire ZN
);
    assign #1 ZN = ~(A1 & A2);
endmodule

module gf180mcu_fd_sc_mcu7t5v0__inv_1 (
    input  wire I,
    output wire ZN
);
    assign #1 ZN = ~I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__and2_1 (
    input  wire A1,
    input  wire A2,
    output wire Z
);
    assign #1 Z = A1 & A2;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__xor2_1 (
    input  wire A1,
    input  wire A2,
    output wire Z
);
    assign #1 Z = A1 ^ A2;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__or2_1 (
    input  wire A1,
    input  wire A2,
    output wire Z
);
    assign #1 Z = A1 | A2;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__mux2_1 (
    input  wire I0,
    input  wire I1,
    input  wire S,
    output wire Z
);
    assign #1 Z = S ? I1 : I0;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__buf_1 (
    input  wire I,
    output wire Z
);
    assign #1 Z = I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__dffq_1 (
    input  wire D,
    input  wire CLK,
    output wire Q
);
    reg q;
    always @(posedge CLK) q <= D;
    assign #1 Q = q;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__dffnq_1 (
    input  wire D,
    input  wire CLKN,
    output wire Q
);
    reg q;
    always @(negedge CLKN) q <= D;
    assign #1 Q = q;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 (
    input  wire D,
    input  wire RN,
    input  wire CLK,
    output wire Q
);
    reg q;
    always @(posedge CLK or negedge RN) begin
        if (!RN) q <= 1'b0;
        else q <= D;
    end
    assign #1 Q = q;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 (
    input  wire D,
    input  wire RN,
    input  wire CLKN,
    output wire Q
);
    reg q;
    always @(negedge CLKN or negedge RN) begin
        if (!RN) q <= 1'b0;
        else q <= D;
    end
    assign #1 Q = q;
endmodule

`default_nettype wire
