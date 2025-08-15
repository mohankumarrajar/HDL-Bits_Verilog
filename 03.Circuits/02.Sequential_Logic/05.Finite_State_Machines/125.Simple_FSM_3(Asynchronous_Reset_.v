module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
parameter A=0,B=1,C=2,D=3;
    reg [1:0]present_state,next_state;
    always@(posedge clk or posedge areset)begin
        if(areset)
            present_state <= A;
        else
            present_state <= next_state;
    end
    // State flip-flops with asynchronous reset
    always@(*)begin
        case(present_state)
            A : next_state = in ? B : A;
            B : next_state = in ? B : C;
            C : next_state = in ? D : A;
            D : next_state = in ? B : C;
        endcase
    end
    // Output logic
assign out = present_state == D;
endmodule
