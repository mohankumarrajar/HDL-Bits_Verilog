module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

   reg ps, ns;
parameter LEFT = 1'b0, RIGHT = 1'b1;
always @(posedge clk or posedge areset)
    if (areset)
        ps <= LEFT;
    else
        ps <= ns;
always @(*)
    case (ps)
        LEFT: ns = bump_left ? RIGHT : LEFT;
        RIGHT: ns = bump_right ? LEFT : RIGHT;
        default: ns = LEFT;
    endcase
    assign {walk_left, walk_right} = ps == LEFT ? 2'b10 : 2'b01;

endmodule
