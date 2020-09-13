`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/04 23:48:58
// Design Name: 
// Module Name: LED_flow
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LED_flow(

  input      i_clk,                    // 时钟信号输入，100MHZ
  
  input      i_rst_n,                  // 复位信号
  input      pause,                    // 暂停信号

  output reg [6:0] keyboard_val,       // 七段显示器    
  output reg [7:0] keyboard            // 七段显示器使能信号
 );
    
reg [28:0] cnt2;                       // 计数子用来构造1HZ的脉冲信号
reg [3:0] flag;                        // 用来判断此时刷新显示哪一个
reg [23:0] flag_time;                  // 用来记录跑秒
reg key_clk_sec;                       //1HZ的脉冲信号
reg [17:0] cnt;                        // 计数子
always @ (posedge i_clk)                         
   begin 
     cnt <= cnt + 1'b1;
     cnt2 <= (cnt2 + 1'b1) % 28'd1000000;
     if(cnt2 < 28'd500000)
         key_clk_sec <= 1'b1;
     else
         key_clk_sec <= 1'b0;                           
   end     

wire key_clk  = cnt[17];               //构造频率为〖10〗^8 / 2^18 =381.470 HZ脉冲信号
  

always @ (posedge key_clk_sec)
  begin
    if(!pause && !i_rst_n)
        flag_time <= (flag_time + 1'b1) % 24'd8640000;
    else if(i_rst_n)                   //复位信号到来，时间置0
        flag_time <= 24'b0;
  end

always @ (posedge key_clk)
  begin
    flag <= (flag + 1'b1) % 4'd8; 
    case(flag)
       4'h0:begin
                keyboard <= 8'b0111_1111;   //刷新第1个七段显示
                case((flag_time / 19'd360000) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end   
             
       4'h1:begin
                keyboard <= 8'b1011_1111;   //刷新第2个七段显示
                case((flag_time / 19'd360000) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end
            
       4'h2:begin
                keyboard <= 8'b1101_1111;   //刷新第3个七段显示
                case(((flag_time / 13'd6000) % 6'd60) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end
            
       4'h3:begin
                keyboard <= 8'b1110_1111;   //刷新第4个七段显示
                case(((flag_time / 13'd6000) % 6'd60) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end
       4'h4:begin
                keyboard <= 8'b1111_0111;   //刷新第5个七段显示
                case(((flag_time / 7'd100) % 6'd60) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end   
       4'h5:begin
                keyboard <= 8'b1111_1011;   //刷新第6个七段显示
                case(((flag_time / 7'd100) % 6'd60) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end
       4'h6:begin
                keyboard <= 8'b1111_1101;   //刷新第7个七段显示
                case((flag_time % 7'd100)/4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end
       4'h7:begin
                keyboard <= 8'b1111_1110;   //刷新第8个七段显示
                case(flag_time % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //显示0
                4'd1:keyboard_val <= 7'b1001111;     //显示1
                4'd2:keyboard_val <= 7'b0010010;     //显示2
                4'd3:keyboard_val <= 7'b0000110;     //显示3
                4'd4:keyboard_val <= 7'b1001100;     //显示4
                4'd5:keyboard_val <= 7'b0100100;     //显示5
                4'd6:keyboard_val <= 7'b0100000;     //显示6
                4'd7:keyboard_val <= 7'b0001111;     //显示7
                4'd8:keyboard_val <= 7'b0000000;     //显示8
                4'd9:keyboard_val <= 7'b0001100;     //显示9
                endcase
            end   
    endcase
    
    
  end
    
endmodule
