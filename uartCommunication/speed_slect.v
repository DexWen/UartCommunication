`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:19 08/31/2016 
// Design Name: 
// Module Name:    speed_slect 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module speed_slect 
(
  clk,
  rst_n,
  bps_start,
  clk_bps
)/*synthesis noprune*/;      

input clk;     	//50MHZ
input rst_n;   	//the low level is valid
input bps_start;	//���յ����ݺ󣬲�����ʱ�������ź���λ,������ʱ�������ź�
output clk_bps;	//���ջ��߷�������λ���м������

parameter BPS_PARA   = 5207;  //10^6/9600*1000/20
parameter BPS_PARA_2 = 2603;


reg clk_bps_r;
reg [12:0] cnt;

always @(posedge clk or negedge rst_n)
    if(!rst_n) 
		cnt <= 13'd0;
    else if ((cnt== BPS_PARA) || !bps_start)  
		cnt <= 13'd0;
    else 
		cnt <= cnt+1'b1;
    
always @ (posedge clk or negedge rst_n)
    if(!rst_n) 
		clk_bps_r <= 1'b0;
    else if (cnt == BPS_PARA_2) 
		clk_bps_r <= 1'b1;
    else 
		clk_bps_r <= 1'b0;
    
assign clk_bps = clk_bps_r;

endmodule 
/*
parameter         bps9600     = 5207,    //������Ϊ9600bps
                 bps19200     = 2603,    //������Ϊ19200bps
                bps38400     = 1301,    //������Ϊ38400bps
                bps57600     = 867,    //������Ϊ57600bps
                bps115200    = 433;    //������Ϊ115200bps 

parameter         bps9600_2     = 2603,
                bps19200_2    = 1301,
                bps38400_2    = 650,
                bps57600_2    = 433,
                bps115200_2 = 216;  
*/