module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
    always@(*)
        case(c)
            4'b00 : q = b;
            4'b01 : q = e;
            4'b10 : q = a;
            4'b11 : q = d;
            default : q = 4'hf;
        endcase

endmodule
