module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    reg [3:0] ps, ns;
parameter S = 4'b0,
          S1 = 4'b0001,
          S11 = 4'b0010,
          S110 = 4'b0011,
          B0 = 4'b0100,
          B1 = 4'b0101,
          B2 = 4'b0110,
          B3 = 4'b0111,
          C = 4'b1000,
          W = 4'b1001;
always @(posedge clk)
    if (reset) 
        ps <= S;
    else 
        ps <= ns;
always @(*)
    case (ps)
        S: ns = data ? S1 : S;
        S1: ns = data ? S11 : S;
        S11: ns = data ? S11 : S110;
        S110: ns = data ? B0 : S;
        B0: ns = B1;
        B1: ns = B2;
        B2: ns = B3;
        B3: ns = C;
        C: ns = done_counting ? W : C;
        W: ns = ack ? S : W;
        default: ns = S;
    endcase
assign shift_ena = ps == B0 || ps == B1 || ps == B2 || ps == B3;
assign counting = ps == C;
assign done = ps == W;
endmodule
