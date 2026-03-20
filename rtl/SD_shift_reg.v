module SD_shift_reg #(
parameter N=4, 
parameter [N-1:0] SEQ = 4'b1101
)(
input clk, rst,
input data_in,
output reg detected
);

reg [N-1:0] shift_reg;

always@(posedge clk)begin
if(rst)begin
shift_reg <= 0;
detected <= 0;
end
else begin 
shift_reg <= {shift_reg[N-2:0], data_in};
if({shift_reg[N-2:0],data_in} == SEQ)
detected <= 1;
else
detected <= 0;
end
end

endmodule
