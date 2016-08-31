`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:49 08/31/2016 
// Design Name: 
// Module Name:    uart_top 
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
module uart_top
(
clk,
rst_n,
rs232_rx,
rs232_tx
);

 input clk;
 input rst_n;
 input rs232_rx;
output rs232_tx;

wire bps_start1,bps_start2;
wire clk_bps1,clk_bps2;
wire [7:0] rx_data/*synthesis keep*/;
wire rx_int;

speed_slect   speed_rx(
                     .clk(clk),
                     .rst_n(rst_n),
                     .bps_start(bps_start1),
                     .clk_bps(clk_bps1)
                    );
                    
uart_rx       uart_rx(
                     .clk(clk),
                     .rst_n(rst_n),
                     .rs232_rx(rs232_rx),
                     .rx_data(rx_data),
                     .rx_int(rx_int),
                     .clk_bps(clk_bps1),
                     .bps_start(bps_start1)
                      );

speed_slect   speed_tx(
                     .clk(clk),
                     .rst_n(rst_n),
                     .bps_start(bps_start2),
                     .clk_bps(clk_bps2)
                        );

uart_tx       uart_tx(
                     .clk(clk),
                     .rst_n(rst_n),
                     .rx_data(rx_data),
                     .rx_int(rx_int),
                     .rs232_tx(rs232_tx),
                     .clk_bps(clk_bps2),
                     .bps_start(bps_start2)
                      );
                     
endmodule

