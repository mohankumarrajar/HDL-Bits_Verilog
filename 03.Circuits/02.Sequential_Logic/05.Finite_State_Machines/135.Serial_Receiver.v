module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
reg [1:0] cs, ns;
reg [3:0] cnt;
parameter IDLE = 2'b00,
          RECV = 2'b01,
          DONE = 2'b10,
          WAIT = 2'b11;
// State flip-flops
always @(posedge clk)
    if (reset) cs <= IDLE;
    else cs <= ns;
// State transition logic
always @(*)
    case (cs)
        IDLE: ns = in ? IDLE : RECV;
        RECV: ns = cnt > 0 ? RECV : (in ? DONE : WAIT);
        DONE: ns = in ? IDLE : RECV;
        WAIT: ns = in ? IDLE : WAIT;
        default: ns = IDLE;
    endcase
// Counter
always @(posedge clk)
    if (reset) cnt <= 9;
    else case (ns)
        IDLE, DONE: cnt <= 9;
        RECV: cnt <= cnt - 1;
        default: cnt <= cnt;
    endcase
// Output done
assign done = cs == DONE;
endmodule
