//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 05:09:55 PM
// Design Name: 
// Module Name: top
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


module top(clk , reset , read , write , address , writedata , readdata , enable);
    input clk , reset;
    input read , write ;
    input [17:0] address ;
    input [15:0] writedata ;
    output[15:0] readdata ;
	 input enable;
    
    wire [15:0] input_signal;
    wire [15:0] output_signal;
    
    FIR_transposed FIR (clk , reset, input_signal , output_signal);
    signal_rom input_ROM (clk ,reset , write , address ,writedata, input_signal , enable);
    output_rom output_ROM (clk ,reset , read , address ,output_signal , readdata, enable);
endmodule
