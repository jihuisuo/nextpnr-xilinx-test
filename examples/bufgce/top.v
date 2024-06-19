module top(
    input wire clk,  
	input wire rst_n,
    input wire key_en,
    output led  
);
    wire bufgce_wire;
    BUFGCE bufgce_inst(
        .I(clk),
        .O(bufgce_wire),
        .CE(1'b1)
    );
    
    reg [24:0] counter = 25'd0; 

    assign led = counter[24];
    // 每当时钟上升沿到达时，计时器增加
    always @(posedge bufgce_wire) begin
		if(!rst_n)
			counter <= 25'b0;
		else
			counter <= counter + 1'b1;
    end

endmodule
