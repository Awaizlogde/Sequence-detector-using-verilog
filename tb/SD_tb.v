`timescale 1ns/1ps

module SD_fsm_tb;

reg clk, rst, data_in;

wire detected;


SD_shift_reg  dut (
.clk(clk),
.rst(rst),
.data_in(data_in),
.detected(detected)
);

  initial begin
    $dumpfile("SD_shift_reg.vcd");
    $dumpvars(0, SD_fsm_tb);
  end
//clock generatot
initial begin
clk = 0;
forever #5 clk = ~clk;
end

// Task ? send bits MSB first
/*task send_bits;
input [15:0] seq;
input integer len;
integer i;
begin
for(i = len-1; i >= 0; i = i-1) begin
@(posedge clk);
data_in = seq[i];
end
end
endtask
*/

// Stimulus
initial begin
// Reset
rst = 1; data_in = 0;
#20;
rst = 0;
#10;

// Test 1 ? basic detection (1101)
$display("Test 1 with 1101\n");
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;


// Test 2 ? overlapping (11011101)
$display("Test 2 ? Overlapping");
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 1;


// Test 3 ? wrong sequence (1100011)
$display("Test 3 ? Wrong sequence");
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;


// Test 4 ? reset in middle
$display("Test 4 ? Reset in middle");
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); rst = 1;
@(posedge clk); rst = 0;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;
@(posedge clk); data_in = 1;
@(posedge clk); data_in = 0;

#10
$display("\n---TEST COMPLETE--\n");
#20;
$finish;
$stop;
end

// Monitor
always @(posedge clk) begin
$display("T=%0t | in=%b |  | detected=%b ",
$time, data_in, detected);
end

endmodule
