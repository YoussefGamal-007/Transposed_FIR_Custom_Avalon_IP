// signal rom takes from address 0x0000_1000 to 0x0000_2000 about 4096 locations
// in decimal from 4096 to 8192

module signal_rom(clk ,reset , write , address ,writedata, readdata , enable);
    input clk ;
    input reset;
    input write;
    input [17:0] address;
    input [15:0] writedata;
    output reg [15:0] readdata;
	 input enable;
    
    reg [15:0] ROM [0:2000];
    reg [15:0] count ;
    
    always@(posedge clk or negedge reset) begin 
        if(!reset)
            count <= 0;
				
        else if(enable)
            count <= count + 1;
    end 
    
   // always@(*) begin 
          // assign readdata = ROM[count];
    //end
	 always@(posedge clk)
	 begin 
		if(!write)
			readdata = ROM[count];
	end
    
    always@(posedge clk) begin 
        if(write && (address >= 4096 && address <= 8192))
            ROM[address-4096] <= writedata; 
//        else 
  //          ROM[address] <= ROM[address]; 
    end 
  //  initial begin 
   //     $readmemb("sine_wave.txt" , ROM);
   // end
endmodule