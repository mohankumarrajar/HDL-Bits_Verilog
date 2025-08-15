module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
   wire c1, c2, c3;

    full_adder fa0 (.x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum[0]), .cout(c1));
    full_adder fa1 (.x(x[1]), .y(y[1]), .cin(c1),   .sum(sum[1]), .cout(c2));
    full_adder fa2 (.x(x[2]), .y(y[2]), .cin(c2),   .sum(sum[2]), .cout(c3));
    full_adder fa3 (.x(x[3]), .y(y[3]), .cin(c3),   .sum(sum[3]), .cout(sum[4]));
  
    assign sum[4] = sum[4];
     
endmodule

       module full_adder(
           input x,y,
           input cin,
           output sum,cout
       );
         
           assign sum = x ^ y ^cin;
           assign cout = x & y | cin & (x | y);
         
       endmodule
