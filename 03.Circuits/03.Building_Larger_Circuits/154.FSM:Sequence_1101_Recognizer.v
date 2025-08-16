module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    reg [2:0] ps, ns;
parameter D1 = 3'b000,
          D2 = 3'b001,
          D3 = 3'b010,
          D4 = 3'b011,
          D5 = 3'b100;
always @(posedge clk)
    if (reset)
        ps <= D1;
    else
        ps <= ns;
always @(*)
    case (ps)
        D1: ns = data ? D2 : D1;
        D2: ns = data ? D3 : D1;
        D3: ns = data ? D3 : D4;
        D4: ns = data ? D5 : D1;
        D5: ns = D5;
        default: ns = D1;
    endcase
assign start_shifting = ps == D5;
endmodule
