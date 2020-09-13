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
// Description: ������ƣ�������ģ�飬һ������ʱ��<counter.v>��һ�����Ʒ���͵�<flash_led_ctl.v>
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//�ܽŷ�����Ƿ������µı���
module flash_led_top(
        input clk,
 	 	input rst_n,
 	 	input sw0,
 	 	output [15:0]led
 	 	);
 	 	
 	 	wire clk_bps;
 	 	wire rst;
 	 	assign rst = ~rst_n;
//ʱ�����ģ�� 	 	
 	 	counter counter(
 	 		.clk( clk ),
 	 		.rst( rst ),
 	 		.clk_bps( clk_bps )
 	 	);
//����LEDģ��
 	 	flash_led_ctl flash_led_ctl(
 	 		.clk( clk ),
 	 		.rst( rst ),
 	 		.dir( sw0 ),
 	 		.clk_bps( clk_bps ),
 	 		.led( led )
 	 	);
endmodule
