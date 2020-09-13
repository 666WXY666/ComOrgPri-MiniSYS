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
// Description: ʱ�����ģ��
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
 	 	reg [13:0]cnt_first,cnt_second;//clkʱ���ź���10^-8�룬clk_bpsʱ���ź���1��
 	 	always @( posedge clk or posedge rst )
 	 	 	if( rst )
 	 			cnt_first <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )//ÿ��cnt_first����10000��cnt_first����
 	 			cnt_first <= 14'd0;
 	 		else
 	 			cnt_first <= cnt_first + 1'b1;//ÿ�յ�1��clk�źţ�cnt_first+1
 	 	always @( posedge clk or posedge rst )
 	 		if( rst )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_second == 14'd10000 )//ÿ��cnt_second����10000��cnt_second����
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_second <= cnt_second + 1'b1;//ÿ��cnt_first����10000��cnt_second+1��cnt_first����
 	 	assign clk_bps = cnt_second == 14'd10000 ? 1'b1 : 1'b0;//ÿ��cnt_second����10000��clk_bps=1
endmodule
