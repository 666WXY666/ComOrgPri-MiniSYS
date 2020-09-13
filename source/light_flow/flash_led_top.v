`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/16 17:25:19
// Design Name: 
// Module Name: flash_led_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 顶层设计，分两个模块，一个控制时钟<counter.v>，一个控制方向和灯<flash_led_ctl.v>
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//管脚分配就是分配如下的变量
module flash_led_top(
        input clk,
 	 	input rst_n,
 	 	input sw0,
 	 	output [15:0]led
 	 	);
 	 	
 	 	wire clk_bps;
 	 	wire rst;
 	 	assign rst = ~rst_n;
//时间控制模块 	 	
 	 	counter counter(
 	 		.clk( clk ),
 	 		.rst( rst ),
 	 		.clk_bps( clk_bps )
 	 	);
//方向及LED模块
 	 	flash_led_ctl flash_led_ctl(
 	 		.clk( clk ),
 	 		.rst( rst ),
 	 		.dir( sw0 ),
 	 		.clk_bps( clk_bps ),
 	 		.led( led )
 	 	);
endmodule
