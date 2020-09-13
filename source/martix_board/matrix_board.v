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

  input      i_clk,                    // ʱ���ź����룬100MHZ
  output reg buzzer_out,               // ��������� 
  input      i_rst_n,                  // ��λ�ź�  
  input      [3:0] row,                // ������� ��
  output reg [3:0] col,                // ������� ��
  output reg [6:0] keyboard_val        // ����ֵ     

);

//++++++++++++++++++++++++++++++++++++++
// ��Ƶ���� ��ʼ
//++++++++++++++++++++++++++++++++++++++

reg [19:0] cnt;                         // ������20λ
reg [18:0] cnt_beep;                    // ������19λ

always @ (posedge i_clk, negedge i_rst_n)

  if (!i_rst_n)                        // ��λ�ź�Ϊ0������Ч����cnt=0
    cnt <= 0;

  else                                 // ��λ�ź�Ϊ1������Ч����ʱ���ź������ص���ʱ��cnt+1
    cnt <= cnt + 1'b1;

wire key_clk  = cnt[19];               // T = 2^20/100M = 10.48576ms    f = 95.367HZ 

always @ (posedge i_clk)               //����cnt_beep��buzzer_out�����Ƶ�ʽ��п���,��Ӧ�˸�����
  begin 
    cnt_beep <= cnt_beep + 1'b1;
    if({col_val, row_val} == 8'b1110_1110)//1����,do,Ƶ�ʣ�256
      begin
        if(cnt_beep <= 19'd190839) 
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd381679)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1101_1110)//2����,re,Ƶ�ʣ�288
      begin
        if(cnt_beep <= 19'd170068) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd340136)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1011_1110)//3����,mi,Ƶ�ʣ�320
      begin
        if(cnt_beep <= 19'd151515) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd303030)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1110_1101)//4����,fa,Ƶ�ʣ�341
      begin
        if(cnt_beep <= 19'd143266) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd286532)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1101_1101)//5����,sol,Ƶ�ʣ�384
      begin
        if(cnt_beep <= 19'd127551) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd255102)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end
      
    else if({col_val, row_val} == 8'b1011_1101)//6����,la,Ƶ�ʣ�426
      begin
        if(cnt_beep <= 19'd113636) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd227272)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end 
      
    else if({col_val, row_val} == 8'b1110_1011)//7����,si,Ƶ�ʣ�480
      begin
        if(cnt_beep <= 19'd101214) //
            buzzer_out <= 1'b1;
        else if(cnt_beep <= 19'd202429)
            buzzer_out <= 1'b0;  
        else
            cnt_beep <= 1'b0;
      end 
      
    else if({col_val, row_val} == 8'b1101_1011)//8����,do,Ƶ�ʣ�512
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
// ��Ƶ���� ����
//--------------------------------------

 
//++++++++++++++++++++++++++++++++++++++
// ״̬������ ��ʼ
//++++++++++++++++++++++++++++++++++++++

// ״̬�����٣����������

parameter NO_KEY_PRESSED = 6'b000_001;  // û�а�������  

parameter SCAN_COL0      = 6'b000_010;  // ɨ���0�� 

parameter SCAN_COL1      = 6'b000_100;  // ɨ���1�� 

parameter SCAN_COL2      = 6'b001_000;  // ɨ���2�� 

parameter SCAN_COL3      = 6'b010_000;  // ɨ���3�� 

parameter KEY_PRESSED    = 6'b100_000;  // �а�������

 

reg [5:0] current_state, next_state;    // ��̬����̬

 

always @ (posedge key_clk, negedge i_rst_n)

  if (!i_rst_n)                         //��λ�ź�Ϊ0������Ч������ǰ״̬����ΪNO_KEY_PRESSED
    current_state <= NO_KEY_PRESSED;

  else
    begin
    current_state <= next_state;
    end

// ��������ת��״̬

always @ *

  case (current_state)

    NO_KEY_PRESSED :                    // û�а�������

        if (row != 4'hF)
          next_state = SCAN_COL0;

        else
          next_state = NO_KEY_PRESSED;

    SCAN_COL0 :                         // ɨ���0�� 

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL1;

    SCAN_COL1 :                         // ɨ���1�� 

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL2;    

    SCAN_COL2 :                         // ɨ���2��

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = SCAN_COL3;

    SCAN_COL3 :                         // ɨ���3��

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = NO_KEY_PRESSED;

    KEY_PRESSED :                       // �а�������

        if (row != 4'hF)
          next_state = KEY_PRESSED;

        else
          next_state = NO_KEY_PRESSED;                      

  endcase

 

reg       key_pressed_flag;             // ���̰��±�־

reg [3:0] col_val, row_val;             // ��ֵ����ֵ

 

// ���ݴ�̬������Ӧ�Ĵ�����ֵ

always @ (posedge key_clk, negedge i_rst_n)

  if (!i_rst_n)
    begin
        col <= 4'h0;
        col_val <= 4'b1111;             // �����ֵ
        row_val <= 4'b1111;             // �����ֵ
        key_pressed_flag <= 0;
    end

  else
    case (next_state)

      NO_KEY_PRESSED :                  // û�а�������

        begin
            col <= 4'h0;
            col_val <= 4'b1111;             // �����ֵ
            row_val <= 4'b1111;             // �����ֵ
            key_pressed_flag <= 0;   // ����̰��±�־
        end

      SCAN_COL0 :                       // ɨ���0��

        col <= 4'b1110;

      SCAN_COL1 :                       // ɨ���1��

        col <= 4'b1101;

      SCAN_COL2 :                       // ɨ���2��

        col <= 4'b1011;

      SCAN_COL3 :                       // ɨ���3��

        col <= 4'b0111;

      KEY_PRESSED :                     // �а�������

        begin
            col_val <= col;             // ������ֵ
            row_val <= row;             // ������ֵ
            key_pressed_flag <= 1;      // �ü��̰��±�־  
        end

    endcase

//--------------------------------------
// ״̬������ ����
//--------------------------------------

 

//++++++++++++++++++++++++++++++++++++++
// ɨ������ֵ���� ��ʼ
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
//  ɨ������ֵ���� ����
//--------------------------------------

       

endmodule
