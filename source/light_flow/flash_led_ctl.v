`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/16 17:23:43
// Design Name: 
// Module Name: flash_led_ctl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 方向及LED模块 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flash_led_ctl(
 	 	input clk,
 	 	input rst,
 	 	input dir,
 	 	input clk_bps,
 	 	output reg[15:0]led
 	 	);
 	 	always @( posedge clk or posedge rst )
 	 		if( rst )
 	 			led <= 16'h8000;
 	 		else
 	 			case( dir )
 	 				1'b0:  //右移			 
 	 					if( clk_bps )//每当clk_bps为1，led右移一位
 	 				 		if( led != 16'd1 )
 	 							led <= led >> 1'b1;
 	 						else//当到达最右端则跳回最左端
 	 							led <= 16'h8000;
 	 				1'b1:  //左移 
 	 			 		if( clk_bps )//每当clk_bps为1，led左移一位
 	 						if( led != 16'h8000 )
 	 							led <= led << 1'b1;
 	 						else//当到达最左端则跳回最右端
 	 							led <= 16'd1;
 	 			endcase
endmodule

