module clock_divider(clk,clk_digit);   
    parameter n = 26;     
    input clk;   
    output clk_digit; 
    reg [n-1:0] num;
    wire [n-1:0] next_num;
    
    always@(posedge clk)begin
    	num<=next_num;
    end
    
    assign next_num = num +1;
    assign clk_digit = num[13];
endmodule

module Lab9(
    input clk,
    input rst,
    input echo,
    input left_track,
    input right_track,
    input mid_track,
    input LEFT,
    input DIRECT,
    input RIGHT,
    input STOP,
    output trig,
    output IN1,
    output IN2,
    output IN3, 
    output IN4,
    output left_pwm,
    output right_pwm,
    output reg [6:0] DISPLAY,
    output reg [3:0] DIGIT 
    // You may modify or add more input/ouput yourself.
);
    // We have connected the motor, tracker_sensor and sonic_top modules in the template file for you.
    // TODO: control the motors with the information you get from ultrasonic sensor and 3-way track sensor.

    reg [1:0] mode;
    wire [19:0] distance;
    wire [1:0] tracker_state;
    
    parameter left = 2'b00;
    parameter direct = 2'b01;
    parameter right = 2'b10;
    parameter stop = 2'b11;


    always @(posedge clk) begin
        if(distance < 20)
            mode <= stop;
        else if(STOP)
            mode <= stop;
        else if(RIGHT)
            mode <= right;
        else if(DIRECT)
            mode <= direct;
        else if(LEFT)
            mode <= left;
        else
            mode <= tracker_state;
    end

    motor A(
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .pwm({left_pwm, right_pwm}),
        .l_IN({IN3, IN4}),
        .r_IN({IN1, IN2})
    );

    sonic_top B(
        .clk(clk), 
        .rst(rst), 
        .Echo(echo), 
        .Trig(trig),
        .distance(distance)
    );

    tracker_sensor C(
        .clk(clk), 
        .reset(rst), 
        .left_track(~left_track), 
        .right_track(~right_track),
        .mid_track(~mid_track), 
        .state(tracker_state)
    );

    parameter digit1 = 4'b0111;
    parameter digit2 = 4'b1011;
    parameter digit3 = 4'b1101;
    parameter digit4 = 4'b1110;

    parameter n0 = 7'b1000000;
    parameter n1 = 7'b1111001;
    parameter n2 = 7'b0100100;
    parameter n3 = 7'b0110000;
    parameter n4 = 7'b0011001;
    parameter n5 = 7'b0010010;
    parameter n6 = 7'b0000010;
    parameter n7 = 7'b1111000;
    parameter n8 = 7'b0000000;
    parameter n9 = 7'b0010000;

    reg [6:0] value;
    wire clkDiv13;

    clock_divider #(.n(22)) clock_22(.clk(clk), .clk_digit(clkDiv13));
    
    always @(posedge clkDiv13) begin
        case(DIGIT)
            digit1:begin
                DIGIT <= digit2;
                value <= (distance/10) % 10;
            end
            digit2:begin
                DIGIT <= digit3;
                value <= distance%10;
            end
            digit3:begin
                DIGIT <= digit4;
                value <= mode;
            end
            digit4:begin
                DIGIT <= digit1;
                value <= distance/100;
            end
            default:begin
                DIGIT <= digit1;
                value <= 7'b0111111;
            end
        endcase
    end

    always @(*) begin
        case(value)
            4'd0:DISPLAY = n0;
            4'd1:DISPLAY = n1;
            4'd2:DISPLAY = n2;
            4'd3:DISPLAY = n3;
            4'd4:DISPLAY = n4;
            4'd5:DISPLAY = n5;
            4'd6:DISPLAY = n6;
            4'd7:DISPLAY = n7;
            4'd8:DISPLAY = n8;
            4'd9:DISPLAY = n9;
            default:DISPLAY = 7'b0111111;
        endcase
    end

endmodule