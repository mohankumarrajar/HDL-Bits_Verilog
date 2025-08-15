module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    // State transition logic
parameter A=0,B=1,C=2,D=3;
    reg [1:0]ps,ns;
    
    always@(posedge clk)begin
        if(reset)
            ps <= A;
        else
            ps <= ns;
    end
    
    always@(*)begin
        case(ps)
            A : ns = in ? B : A;
            B : ns = in ? B : C;
            C : ns = in ? D : A;
            D : ns = in ? B : C;
        endcase
    end
    
    assign out = ps == D;
    // State flip-flops with synchronous reset

    // Output logic

endmodule
