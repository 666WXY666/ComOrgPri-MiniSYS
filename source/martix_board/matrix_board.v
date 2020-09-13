`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/03 13:41:06
// Design Name: 
// Module Name: Matrix_keyboard
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


module matrixKeyboard_drive(

  input      i_clk,                    // 时钟信号输入，100MHZ
  output reg buzzer_out,               // 蜂鸣器输出 
  input      i_rst_n,                  // 复位信号  
  input      [3:0] row,                // 矩阵键盘 行
  output reg [3:0] col,                // 矩阵键盘 列
  output reg [6:0] keyboard_val        // 键盘值     

);

//++++++++++++++++++++++++++++++++++++++
// 分频部分 开始
//++++++++++++++++++++++++++++++++++++++

reg [19:0] cnt;                         // 计数子20位
reg [18:0] cnt_beep;                    // 计数子19位

always @ (posedge i_clk, negedge i_rst_n)

  if (!i_rst_n)                        // 复位信号为0（低有效），cnt=0
    cnt <= 0;

  else                                 // 复位信号为1（低有效），时钟信号上升沿到来时，cnt+1
    cnt <= cnt + 1'b1;

wire key_clk  = cnt[19];               // T = 2^20/100M = 10.48576ms    f = 95.367HZ 

always @ (posedge i_clk)               //利用cnt_beep对buzzer_out的输出频率进行控制,对应八个音符
  begin 
    cnt_beep <= cnt_beep + 1'b1;
    if({col_val, row_val} == 8'b1110_1110)//1按下,do,频率：256
      begin
        if(cnt_beep <= 19'd190839) 
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd381679)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1101_1110)//2按下,re,频率：288
      begin
        if(cnt_beep <= 19'd170068) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd340136)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1011_1110)//3按下,mi,频率：320
      begin
        if(cnt_beep <= 19'd151515) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd303030)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1110_1101)//4按下,fa,频率：341
      begin
        if(cnt_beep <= 19'd143266) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd286532)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1101_1101)//5按下,sol,频率：384
      begin
        if(cnt_beep <= 19'd127551) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd255102)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1011_1101)//6按下,la,频率：426
      begin
        if(cnt_beep <= 19'd113636) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd227272)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end 
      
    else if({col_val, row_val} == 8'b1110_1011)//7按下,si,频率：480
      begin
        if(cnt_beep <= 19'd101214) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd202429)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end 
      
    else if({col_val, row_val} == 8'b1101_1011)//8按下,do,频率：512
      begin
        if(cnt_beep <= 19'd95602) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd191204)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end 
  end
           

//--------------------------------------
// 分频部分 结束
//--------------------------------------

 
//++++++++++++++++++++++++++++++++++++++
// 状态机部分 开始
//++++++++++++++++++++++++++++++++++++++

// 状态数较少，独热码编码

parameter NO_KEY_PRESSED = 6'b000_001;  // 没有按键按下  

parameter SCAN_COL0      = 6'b000_010;  // 扫描第0列 

parameter SCAN_COL1      = 6'b000_100;  // 扫描第1列 

parameter SCAN_COL2      = 6'b001_000;  // 扫描第2列 

parameter SCAN_COL3      = 6'b010_000;  // 扫描第3列 

parameter KEY_PRESSED    = 6'b100_000;  // 有按键按下

 

reg [5:0] current_state, next_state;    // 现态、次态

 

always @ (posedge key_clk, negedge i_rst_n)

  if (!i_rst_n)                         //复位信号为0（低有效），当前状态设置为NO_KEY_PRESSED
    current_state <= NO_KEY_PRESSED;

  else
    begin
    current_state <= next_state;
    end

// 根据条件转移状态

always @ *

  case (current_state)

    NO_KEY_PRESSED :                    // 没有按键按下

        if (row != 4'hF)
          next_state = SCAN_COL0;

        else
          next_state = NO_KEY_PRESSED;

    SCAN_COL0 :                         // 扫描第0列 

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL1;

    SCAN_COL1 :                         // 扫描第1列 

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL2;    

    SCAN_COL2 :                         // 扫描第2列

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL3;

    SCAN_COL3 :                         // 扫描第3列

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = NO_KEY_PRESSED;

    KEY_PRESSED :                       // 有按键按下

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = NO_KEY_PRESSED;                      

  endcase

 

reg       key_pressed_flag;             // 键盘按下标志

reg [3:0] col_val, row_val;             // 列值、行值

 

// 根据次态，给相应寄存器赋值

always @ (posedge key_clk, negedge i_rst_n)

  if (!i_rst_n)
    begin
        col <= 4'h0;
        col_val <= 4'b1111;             // 清空列值
        row_val <= 4'b1111;             // 清空行值
        key_pressed_flag <= 0;
    end

  else
    case (next_state)

      NO_KEY_PRESSED :                  // 没有按键按下

        begin
            col <= 4'h0;
            col_val <= 4'b1111;             // 清空列值
            row_val <= 4'b1111;             // 清空行值
            key_pressed_flag <= 0;   // 清键盘按下标志
        end

      SCAN_COL0 :                       // 扫描第0列

        col <= 4'b1110;

      SCAN_COL1 :                       // 扫描第1列

        col <= 4'b1101;

      SCAN_COL2 :                       // 扫描第2列

        col <= 4'b1011;

      SCAN_COL3 :                       // 扫描第3列

        col <= 4'b0111;

      KEY_PRESSED :                     // 有按键按下

        begin
            col_val <= col;             // 锁存列值
            row_val <= row;             // 锁存行值
            key_pressed_flag <= 1;      // 置键盘按下标志  
        end

    endcase

//--------------------------------------
// 状态机部分 结束
//--------------------------------------

 

//++++++++++++++++++++++++++++++++++++++
// 扫描行列值部分 开始
//++++++++++++++++++++++++++++++++++++++

always @ (posedge key_clk, negedge i_rst_n)

  if (!i_rst_n)
    keyboard_val <= 4'h0;

  else
  if (key_pressed_flag)

      case ({col_val, row_val})

        8'b1110_1110 : keyboard_val <= 7'b0000001;

        8'b1110_1101 : keyboard_val <= 7'b1001100;

        8'b1110_1011 : keyboard_val <= 7'b0000000;

        8'b1110_0111 : keyboard_val <= 7'b1110010;

         
         
        8'b1101_1110 : keyboard_val <= 7'b1001111;

        8'b1101_1101 : keyboard_val <= 7'b0100100;

        8'b1101_1011 : keyboard_val <= 7'b0001100;

        8'b1101_0111 : keyboard_val <= 7'b1000010;

         

        8'b1011_1110 : keyboard_val <= 7'b0010010;

        8'b1011_1101 : keyboard_val <= 7'b0100000;

        8'b1011_1011 : keyboard_val <= 7'b0001000;

        8'b1011_0111 : keyboard_val <= 7'b0110000;

         

        8'b0111_1110 : keyboard_val <= 7'b0000110; 

        8'b0111_1101 : keyboard_val <= 7'b0001111;

        8'b0111_1011 : keyboard_val <= 7'b1100000;

        8'b0111_0111 : keyboard_val <= 7'b0111000;  
        endcase      
      

//--------------------------------------
//  扫描行列值部分 结束
//--------------------------------------

       

endmodule
