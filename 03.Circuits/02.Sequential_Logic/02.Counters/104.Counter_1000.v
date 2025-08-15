module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
 wire [3:0] Q0, Q1, Q2; // Outputs from each BCD counter

    // Generate enable signals for chained BCD counters
    assign c_enable[0] = 1'b1;                     // Always enabled
    assign c_enable[1] = (Q0 == 4'd9);             // Enable when Q0 reaches 9
    assign c_enable[2] = c_enable[1] && (Q1 == 4'd9); // Enable when Q0 == 9 and Q1 == 9

    // Pulse high for one clock cycle every 1000 cycles (Q0, Q1, Q2 all 9)
    assign OneHertz = c_enable[2] && (Q2 == 4'd9);

    // Instantiate the three BCD counters
    bcdcount counter0 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(Q0)
    );

    bcdcount counter1 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(Q1)
    );

    bcdcount counter2 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(Q2)
    );
    //bcdcount counter0 (clk, reset, c_enable[0]/*, ... */);
   // bcdcount counter1 (clk, reset, c_enable[1]/*, ... */);

endmodule
