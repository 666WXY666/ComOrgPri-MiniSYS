`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/16 17:21:37
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 时间控制模块
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module counter(
	input clk,
  	input rst,
  	output clk_bps
  	);	
 	 	reg [13:0]cnt_first,cnt_second;//clk时钟信号是10^-8秒，clk_bps时钟信号是1秒
 	 	always @( posedge clk or posedge rst )
 	 	 	if( rst )
 	 			cnt_first <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )//每当cnt_first到达10000，cnt_first清零
 	 			cnt_first <= 14'd0;
 	 		else
 	 			cnt_first <= cnt_first + 1'b1;//每收到1个clk信号，cnt_first+1
 	 	always @( posedge clk or posedge rst )
 	 		if( rst )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_second == 14'd10000 )//每当cnt_second到达10000，cnt_second清零
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_second <= cnt_second + 1'b1;//每当cnt_first到达10000，cnt_second+1，cnt_first清零
 	 	assign clk_bps = cnt_second == 14'd10000 ? 1'b1 : 1'b0;//每当cnt_second到达10000，clk_bps=1
endmodule
