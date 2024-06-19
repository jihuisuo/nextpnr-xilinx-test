module top(
    input wire clk,  
	input wire rst_n,
    output led  
);
    
    reg [24:0] counter = 25'd0; 

    assign led = counter[24];
    // 每当时钟上升沿到达时，计时器增加
    always @(posedge clk) begin
		if(!rst_n)
			counter <= 25'b0;
		else
			counter <= counter + 1'b1;
    end

endmodule
