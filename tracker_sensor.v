

module tracker_sensor(clk, reset, left_track, right_track, mid_track, state);
    input clk;
    input reset;
    input left_track, right_track, mid_track;
    output reg [1:0] state;

    // TODO: Receive three tracks and make your own policy.
    // Hint: You can use output state to change your action.

    parameter left = 2'b00;
    parameter direct = 2'b01;
    parameter right = 2'b10;
    // black: 1 
    // white: 0
    always @(posedge clk) begin
        if(left_track && !right_track && !mid_track)
            state <= left;
        else if(right_track && !left_track && !mid_track)
            state <= right;
        else
            state <= direct;
    end
endmodule