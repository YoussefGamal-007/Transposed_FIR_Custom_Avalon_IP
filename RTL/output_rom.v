// signal rom takes from address 0x0000_3000 to 0x0000_4000 about 4096 locations
// in decimal from 12288 to 16384

module output_rom(clk ,reset , read , address ,writedata , readdata , enable);
    
    input clk, reset;
    input read ;
    input [17:0] address;
    input [15:0] writedata ;
    output reg [15:0] readdata;
	 
	 input enable;
    
    
    reg [15:0] ROM [0:2000];
    reg [15:0] count ;
    
    always @(posedge clk or negedge reset)
        begin
            if(!reset)
                count <= 0;
            else if(enable)
					 count <= count + 1;
        end 
    
    always@(posedge clk) begin
		if(!read)
        ROM[count] <= writedata;
    end

    always@(posedge clk) begin
        if(read && (address >= 12288 && address <= 16384))
            readdata <= ROM[address-12288];       
      //  else 
        //    ROM[address] <= ROM[address];
        end   
		  
		      // pragma to infer memory blocks
    // synthesis translate_off
   // (* ramstyle = "M9K" *) // Change this based on your FPGA architecture
    // synthesis translate_on
   // reg [31:0] dummy;
endmodule
