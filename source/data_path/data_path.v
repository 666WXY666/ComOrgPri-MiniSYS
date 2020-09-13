`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/06 13:55:22
// Design Name: ������,������,��ҫ��,̷��
// Module Name: data_path
// Project Name: data_path
// Target Devices: xc7a100tfgg484-2
// Tool Versions: Vivado 2019.1
// Description: ��TEC-8����ͨ·
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_path
(
    input QD,                               //�ֶ�����
    input ABUS,SBUS,MBUS,                   //���߿���
    input S0,S1,                            //ALU����
    input RD1,RD0,                          //ѡ��д��Ĵ����Ͷ���A�˿ڵļĴ���
    input RS0,RS1,                          //ѡ�����B�˿ڵļĴ���
    input DRW,MEMW,                         //д��Ĵ������ڴ濪��
    input LAR,LPC,                          //д��AR��PC����
    input SD7,SD6,SD5,SD4,SD3,SD2,SD1,SD0,  //���ݿ���
    input i_clk,                            // ʱ���ź����룬100MHZ
    output wire [7:0]DBUS,                  //��������
    output wire [7:0]ARBUS,                 //��ַ����
    output wire [7:0]PCBUS,                 //PC����
    output reg [6:0] keyboard_val,          // �߶���ʾ��    
    output reg [7:0] keyboard               // ��λ�߶���ʾ��ʹ���ź� 
);
    reg LR3,LR2,LR1,LR0;                    //�Ĵ�������
    reg [7:0]R0;                            //�Ĵ���0
    reg [7:0]R1;                            //�Ĵ���1
    reg [7:0]R2;                            //�Ĵ���2
    reg [7:0]R3;                            //�Ĵ���3
    reg [7:0]A;                             //�˿�A
    reg [7:0]B;                             //�˿�B
    reg [7:0]R;                             //����Ĵ���
    reg [7:0]DR;                            //�������߼Ĵ���
    reg [7:0]AR;                            //��ַ���߼Ĵ���
    reg [7:0]PC;                            //PC�Ĵ���
    reg [7:0]MEM[7:0];                      //8*8�ڴ�ռ�
    reg [17:0] cnt;                        // 8λ7����ʾˢ�¼�����
    reg [3:0] flag;                        // �����жϴ�ʱ��λ�߶���ʾ��ˢ����ʾ��һ��
//�����߼Ĵ����������������� 
assign DBUS = DR;  
assign ARBUS = AR;
assign PCBUS = PC;
//ʱ�������ص�����������+1
always @ (posedge i_clk)                         
   begin 
      cnt <= cnt + 1'b1;                        
   end   
     
wire key_clk  = cnt[17];               //������Ҫ�Ĺ̶�Ƶ�������ź�

always @ (posedge key_clk)
  begin
    flag <= (flag + 1'b1) % 4'd8;       //�б�8λ7����ʾ��λˢ�� 
    case(flag)
       4'h0:begin
                keyboard <= 8'b0111_1111;   //ˢ�µ�1���߶���ʾ
                case(A[7:4])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end   
             
       4'h1:begin
                keyboard <= 8'b1011_1111;   //ˢ�µ�2���߶���ʾ
                case(A[3:0])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end
            
       4'h2:begin
                keyboard <= 8'b1101_1111;   //ˢ�µ�3���߶���ʾ
                case(B[7:4])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end
            
       4'h3:begin
                keyboard <= 8'b1110_1111;   //ˢ�µ�4���߶���ʾ
                case(B[3:0])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end
       4'h4:begin
                keyboard <= 8'b1111_1111;   //ˢ�µ�5���߶���ʾ
            end   
       4'h5:begin
                keyboard <= 8'b1111_1111;   //ˢ�µ�6���߶���ʾ
            end
       4'h6:begin
                keyboard <= 8'b1111_1101;   //ˢ�µ�7���߶���ʾ
                case(R[7:4])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end
       4'h7:begin
                keyboard <= 8'b1111_1110;   //ˢ�µ�8���߶���ʾ
                case(R[3:0])
                4'h0:keyboard_val <= 7'b0000001;     //��ʾ0
                4'h1:keyboard_val <= 7'b1001111;     //��ʾ1
                4'h2:keyboard_val <= 7'b0010010;     //��ʾ2
                4'h3:keyboard_val <= 7'b0000110;     //��ʾ3
                4'h4:keyboard_val <= 7'b1001100;     //��ʾ4
                4'h5:keyboard_val <= 7'b0100100;     //��ʾ5
                4'h6:keyboard_val <= 7'b0100000;     //��ʾ6
                4'h7:keyboard_val <= 7'b0001111;     //��ʾ7
                4'h8:keyboard_val <= 7'b0000000;     //��ʾ8
                4'h9:keyboard_val <= 7'b0001100;     //��ʾ9
                4'hA:keyboard_val <= 7'b0001000;     //��ʾA
                4'hB:keyboard_val <= 7'b1100000;     //��ʾB
                4'hC:keyboard_val <= 7'b0001101;     //��ʾC
                4'hD:keyboard_val <= 7'b1000010;     //��ʾD
                4'hE:keyboard_val <= 7'b0110000;     //��ʾE
                4'hF:keyboard_val <= 7'b0111000;     //��ʾF
                endcase
            end   
    endcase
  end

//�������߿����ж��ĸ����ݿ��Խ�����������
always @(posedge QD) 
begin
    case({SBUS,ABUS,MBUS})
        3'b100:DR = {SD7,SD6,SD5,SD4,SD3,SD2,SD1,SD0};
        3'b010:DR = R;
        3'b001:DR = MEM[AR];
        default:DR=DR;
    endcase
end           
//2-4������ѡ�мĴ���
always @(*) 
begin
    case({RD1,RD0})
        2'b00:{LR3,LR2,LR1,LR0} = 4'b0001;
        2'b01:{LR3,LR2,LR1,LR0} = 4'b0010;
        2'b10:{LR3,LR2,LR1,LR0} = 4'b0100;
        2'b11:{LR3,LR2,LR1,LR0} = 4'b1000;
    endcase
end 
always @(posedge QD) 
begin
    if(DRW)
    case({LR3,LR2,LR1,LR0})
        4'b0001:R0=DR;
        4'b0010:R1=DR;
        4'b0100:R2=DR;
        4'b1000:R3=DR;
    endcase
end           
//�ж��ĸ��Ĵ������ݽ���A��B�˿�   
always @(*) 
begin
    case({RD1,RD0})
        2'b00:A=R0;
        2'b01:A=R1;
        2'b10:A=R2;
        2'b11:A=R3;
    endcase
end     
always @(*) 
begin
    case({RS1,RS0})
        2'b00:B=R0;
        2'b01:B=R1;
        2'b10:B=R2;
        2'b11:B=R3;
    endcase
end  
//�ж�ALU�����ֲ���
always @(posedge QD) 
begin
    case({S1,S0})
        2'b00:R=A;
        2'b01:R=B;
        2'b10:R=A+B;
        2'b11:R=A-B;
    endcase
end    
//�ж��������������Ƿ����AR��PC
always @(posedge QD) 
begin
    case({LAR,LPC})
        2'b01:PC=DR;
        2'b10:AR=DR;
        2'b11:begin
                PC=DR;
                AR=DR;
              end
        default:;
    endcase
end
//�ж��������������Ƿ�����ڴ���Ӧ��Ԫ
always @(posedge QD) 
begin
if(MEMW)
    MEM[AR]=DR;
end

endmodule
