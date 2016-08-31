`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:35 08/31/2016 
// Design Name: 
// Module Name:    uart_rx 
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
module uart_rx 
(
    clk,
    rst_n,
    rs232_rx,
    rx_data,
    rx_int,
    clk_bps,
    bps_start
) /*synthesis noprune*/;

	input clk;
	input rst_n;
	input rs232_rx;			//RS232���������ź�
	input clk_bps;				//���ջ��߷�������λ���м������
	output bps_start;			//���յ����ݺ󣬲�����ʱ�������ź���λ
	output [7:0] rx_data;	//�������ݼĴ���������ֱ����һ�����ݵ���
	output rx_int;				//���������ж��źţ����յ������ڼ�ʼ��Ϊ�ߵ�ƽ

	reg rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3;
	wire neg_rs232_rx;//��ʾ�����߽��յ��½���

	always @ (posedge clk or negedge rst_n)
	begin
		 if(!rst_n)
		 begin
			  rs232_rx0 <= 1'b0;
			  rs232_rx1 <= 1'b0;
			  rs232_rx2 <= 1'b0;
			  rs232_rx3 <= 1'b0;
		 end
		 
		 else 
		 begin
			  rs232_rx0 <= rs232_rx;
			  rs232_rx1 <= rs232_rx0;
			  rs232_rx2 <= rs232_rx1;
			  rs232_rx3 <= rs232_rx2;
		 end
	end

	assign neg_rs232_rx = rs232_rx3 &rs232_rx2 & ~rs232_rx1 & ~rs232_rx0;	//�½��ص��ˣ������������

	reg bps_start_r;
	reg [3:0] num;
	reg rx_int;

	always @ (posedge clk or negedge rst_n)
	if(!rst_n)
	begin
		 bps_start_r <= 1'bz;
		 rx_int <= 1'b0;
	end
	else if(neg_rs232_rx)
	begin
		 bps_start_r <= 1'b1;
		 rx_int <= 1'b1;
	end
	else if(num==4'd12)
	begin
		 bps_start_r <= 1'b0;
		 rx_int <= 1'b0;
	end

	assign bps_start =bps_start_r;

	reg [7:0] rx_data_r;
	reg [7:0] rx_tmp_data;

	always @ (posedge clk or negedge rst_n)
	if(!rst_n)
	begin
		 rx_tmp_data <= 8'd0;
		 num <= 4'd0;
		 rx_data_r <= 8'd0;
	end
	else if(rx_int)
	begin
		 if(clk_bps)
		 begin
			  num <= num+1'b1;
			  case(num)
					4'd1:  rx_tmp_data[0] <= rs232_rx;
					4'd2:  rx_tmp_data[1] <= rs232_rx;
					4'd3:  rx_tmp_data[2] <= rs232_rx;
					4'd4:  rx_tmp_data[3] <= rs232_rx;
					4'd5:  rx_tmp_data[4] <= rs232_rx;
					4'd6:  rx_tmp_data[5] <= rs232_rx;
					4'd7:  rx_tmp_data[6] <= rs232_rx;
					4'd8:  rx_tmp_data[7] <= rs232_rx;
					default: ;
			  endcase
		 end
		 
		 else if(num == 4'd12)
		 begin
			  num <= 4'd0;
			  rx_data_r <= rx_tmp_data;
		 end
	end    
	assign rx_data = rx_data_r;

	endmodule 