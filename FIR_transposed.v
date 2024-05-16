//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 01:43:17 AM
// Design Name: 
// Module Name: FIR_transposed
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


module FIR_transposed(clk , reset , noisy_signal , filtered_real );

	parameter N = 16;								// bit resolution
	parameter T = 51;								// number of Taps

	input 					        clk ;
	input 					        reset;				  //async active low reset
	input 	signed [N-1:0] 		    noisy_signal;         //input signal that to be filtered
	output 	signed [N-1:0] 		filtered_real; 	  //output signal of the fir 
	//output 	signed [2*N-1:0] 		filtered_signal; 	  //output signal of the fir 
	
	reg signed [N-1:0] coeff [0:T-1];
	wire signed [2*N-1:0] summed_signal [0:T-1];
	//wire signed [2*N-1:0] delayed_signal [0:T-2];
	wire signed [2*N-1:0] to_register [0:T-2];
   // wire signed [2*N-1:0] mul [0:T-1];
    
    //assign coeff[0] = 16'd1;
    //assign coeff[1] = 16'd0;
	//assign mul[0] = noisy_signal * coeff[0];
	//assign delayed_signal[0] = noisy_signal;
	
	assign summed_signal[0] = $signed(noisy_signal * coeff[T-1]);
	//assign to_register[0] = summed_signal[0] ;
	
  genvar i;
  generate
    for (i = 0; i < T-1; i = i + 1) begin : gen_block // 0 , 1, 2, 3   //4 ,3,2,1 //3,2,1,0
     transposed_block O_FIR (
        .clk(clk),
        .reset(reset),
        .normal_signal(noisy_signal),
        .coeff(coeff[T-2-i]),
        .to_register(summed_signal[i]),   // to_register [ 1 , 2 ,3 ]
        .summed_signal(summed_signal[i+1])  // summed_signal [ 1 , 2 , 3 , 4]
      );
    end
  endgenerate
  
  wire [31:0] filtered_signal;
  assign filtered_signal = summed_signal[T-1];
  assign filtered_real = filtered_signal[31:16];
  
  initial begin 
    $readmemb("binary_coefficients2.txt" , coeff);
    end 
    
endmodule