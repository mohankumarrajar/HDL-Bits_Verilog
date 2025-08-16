module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;  // Weakly Not-Taken
    else if (train_valid) begin
        case (train_taken)
            1'b1: begin
                // increment saturating counter
                if (state != 2'b11)
                    state <= state + 1;
            end
            1'b0: begin
                // decrement saturating counter
                if (state != 2'b00)
                    state <= state - 1;
            end
        endcase
    end
    // else: state remains unchanged
end
endmodule
