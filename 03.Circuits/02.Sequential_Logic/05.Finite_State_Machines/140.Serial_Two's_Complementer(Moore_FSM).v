module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
reg cs, ns;
  
always @(posedge clk or posedge areset)
    if (areset) cs <= 1'b0;
    else cs <= ns;
always @(*)
    if (cs) ns = 1'b1;
    else ns = x;
always @(posedge clk or posedge areset)
    if (areset) z <= 1'b0;
    else z <= x ^ cs;
  
endmodule
