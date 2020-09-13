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

  input      i_clk,                    // ʱ���ź����룬100MHZ
  
  input      i_rst_n,                  // ��λ�ź�
  input      pause,                    // ��ͣ�ź�

  output reg [6:0] keyboard_val,       // �߶���ʾ��    
  output reg [7:0] keyboard            // �߶���ʾ��ʹ���ź�
 );
    
reg [28:0] cnt2;                       // ��������������1HZ�������ź�
reg [3:0] flag;                        // �����жϴ�ʱˢ����ʾ��һ��
reg [23:0] flag_time;                  // ������¼����
reg key_clk_sec;                       //1HZ�������ź�
reg [17:0] cnt;                        // ������
always @ (posedge i_clk)                         
   begin 
     cnt <= cnt + 1'b1;
     cnt2 <= (cnt2 + 1'b1) % 28'd1000000;
     if(cnt2 < 28'd500000)
         key_clk_sec <= 1'b1;
     else
         key_clk_sec <= 1'b0;                           
   end     

wire key_clk  = cnt[17];               //����Ƶ��Ϊ��10��^8 / 2^18 =381.470 HZ�����ź�
  

always @ (posedge key_clk_sec)
  begin
    if(!pause && !i_rst_n)
        flag_time <= (flag_time + 1'b1) % 24'd8640000;
    else if(i_rst_n)                   //��λ�źŵ�����ʱ����0
        flag_time <= 24'b0;
  end

always @ (posedge key_clk)
  begin
    flag <= (flag + 1'b1) % 4'd8; 
    case(flag)
       4'h0:begin
                keyboard <= 8'b0111_1111;   //ˢ�µ�1���߶���ʾ
                case((flag_time / 19'd360000) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end   
             
       4'h1:begin
                keyboard <= 8'b1011_1111;   //ˢ�µ�2���߶���ʾ
                case((flag_time / 19'd360000) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end
            
       4'h2:begin
                keyboard <= 8'b1101_1111;   //ˢ�µ�3���߶���ʾ
                case(((flag_time / 13'd6000) % 6'd60) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end
            
       4'h3:begin
                keyboard <= 8'b1110_1111;   //ˢ�µ�4���߶���ʾ
                case(((flag_time / 13'd6000) % 6'd60) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end
       4'h4:begin
                keyboard <= 8'b1111_0111;   //ˢ�µ�5���߶���ʾ
                case(((flag_time / 7'd100) % 6'd60) / 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end   
       4'h5:begin
                keyboard <= 8'b1111_1011;   //ˢ�µ�6���߶���ʾ
                case(((flag_time / 7'd100) % 6'd60) % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end
       4'h6:begin
                keyboard <= 8'b1111_1101;   //ˢ�µ�7���߶���ʾ
                case((flag_time % 7'd100)/4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end
       4'h7:begin
                keyboard <= 8'b1111_1110;   //ˢ�µ�8���߶���ʾ
                case(flag_time % 4'd10)
                4'd0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'd1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'd2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'd3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'd4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'd5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'd6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'd7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'd8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'd9:keyboard_val <= 7'b0001100;     //��ʾ9
                endcase
            end   
    endcase
    
    
  end
    
endmodule
