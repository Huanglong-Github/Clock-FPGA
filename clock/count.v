module count(
	input div_clk,//1s一次的分频好的时钟信号
	input sw2, //控制开始
	input sw3,//控制清零
	output reg [3:0] sec_1,
	output reg [3:0] sec_2,
	output reg [3:0] sec_3,
	output reg [3:0] sec_4
);

always @ (div_clk or sw3 or sw2) begin
	if(sw3==1) begin   //当sw3置零的时候，初始化为0
		sec_1 <= 4'b0000;
		sec_2 <= 4'b0000;
		sec_3 <= 4'b0000;
		sec_4 <= 4'b0000;
	end
	else begin
	if(sw2==1) begin
		if(sec_1 == 9) begin
			sec_1 <= 4'b0000;
			if(sec_2 == 9) begin
				sec_2 <= 4'b0000;
				if(sec_3 == 9) begin
					sec_3 <= 4'b0000;
					if(sec_4 == 9) begin
						sec_4 <= 4'b0000;
					end	
					else
						sec_4 <= sec_4 + 1'b1;
				end
				else
					sec_3 <= sec_3 + 1'b1;
			end
			else
				sec_2 <= sec_2 + 1'b1;
		end
		else
			sec_1 <= sec_1 + 1'b1;
	end
	end
end
endmodule
