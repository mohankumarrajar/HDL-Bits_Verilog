module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
wire c_or_d_s,zero_s,d_prime_s,c_and_d_s;
    
    mux2to1 c_or_d(.a(d),.b(1'b1),.sel(c),.s(c_or_d_s));
    mux2to1 zero(.a(1'b0),.b(1'b0),.sel(c),.s(zero_s));
    mux2to1 d_prime(.a(1'b1),.b(1'b0),.sel(d),.s(d_prime_s));
    mux2to1 c_and_d(.a(1'b0),.b(d),.sel(c),.s(c_and_d_s));
  
    assign mux_in[0] = c_or_d_s;
    assign mux_in[1] = zero_s;
    assign mux_in[2] = d_prime_s;
    assign mux_in[3] = c_and_d_s;

endmodule

module mux2to1 (
    input a,
    input b,
    input sel,
    output s
);
  
    assign s = sel ? b : a;
  
endmodule
