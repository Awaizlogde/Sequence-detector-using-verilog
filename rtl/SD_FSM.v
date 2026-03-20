//sequence 1101
module SD_fsm #(parameter OVERLAP = 1) (
input clk, rst,
input data_in,
output detect_moore, 
output detect_mealy
);

localparam 
s0 = 3'd0,
s1 = 3'd1,
s2 = 3'd2,
s3 = 3'd3,
s4 = 3'd4;

reg [2:0] state, next_state;

always@(posedge clk)begin
if(rst)begin
state <= s0;
end else begin
state <= next_state; 
end
end

//seq 1101
always@(*) begin
next_state = s0;
case(state)
s0 : if(data_in)
next_state = s1;
else
next_state = s0;

s1 : if(data_in)
next_state = s2;
else
next_state = s0;

s2 : if(!data_in)
next_state = s3;
else
next_state = s2;

s3 : if(data_in)
next_state = s4;
else
next_state = s0;

s4: if(OVERLAP) begin
if(data_in) next_state = s1;  // reuse last "1" ? S1
else        next_state = s0;
end else        next_state = s0;

default: next_state = s0;
endcase
end

assign detect_moore = (state == s4);
assign detect_mealy = (state == s3) && (data_in==1);

endmodule