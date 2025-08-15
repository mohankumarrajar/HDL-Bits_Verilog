module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] ps, ns;
parameter A = 2'b00,
          B = 2'b01,
          C = 2'b10,
          D = 2'b11;
always @(posedge clk)
    if (reset) 
        ps <= A;
    else 
        ps <= ns;
always @(*)
    case (ps)
        A: ns = s[1] ? B : A;
        B: ns = s[2] ? C : (s[1] ? B : A);
        C: ns = s[3] ? D : (s[2] ? C : B);
        D: ns = s[3] ? D : C;
        default: ns = A;
    endcase
reg lower;
always @(posedge clk)
    if (reset) lower = 1'b0;
    else lower = ns < ps ? 1'b1 : (ns > ps ? 1'b0 : lower);
assign fr3 = ps == A;
assign fr2 = ps <= B;
assign fr1 = ps <= C;
assign dfr = ps == A || lower;
endmodule
