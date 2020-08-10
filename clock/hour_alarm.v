module hour_alarm(
	input div_clk,//1s一次的分频好的时钟信号
	input rst_n,//复位信号
	
	input wire [3:0] secL,//最终的秒的个位
	input wire [3:0] secH,//最终的秒的十位
	input wire [3:0] minL,//最终的分的个位
	input wire [3:0] minH,//最终的分的十位
	input wire [3:0] hourL,//最终的时的个位
	input wire [3:0] hourH,//最终的时的十位
	
	output reg hour_led//设置led2为整点报时的标志，当快整点的时��?整点��?0��?开始报��?即常��?，led2闪烁10��?
);
always @ (posedge div_clk or negedge rst_n) begin
	if(!rst_n) 
		hour_led <= 1'b1;//设初始化为灭灯的状��?
	else begin
		if(minH==5 && minL==9 && secH==5 && secL==9)
			hour_led <= 1'b0;//设置为常��?
		else if(minH==0 && minL==0 && secH==0 && secL<10)
			hour_led <= 1'b0;//设置为常��?
		else 	
			hour_led <= 1'b1;//设置为长灭的状��?
	end
end

endmodule
