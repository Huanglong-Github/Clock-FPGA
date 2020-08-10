module alarm_clocking(
	input div_clk,//1s一次的分频好的时钟信号
	input rst_n,//复位信号
	
	input wire [3:0] secL,//最终的秒的个位
	input wire [3:0] secH,//最终的秒的十位
	input wire [3:0] minL,//最终的分的个位
	input wire [3:0] minH,//最终的分的十位
	input wire [3:0] hourL,//最终的时的个位
	input wire [3:0] hourH,//最终的时的十位
	
	input wire [3:0] alarm_secL,//调闹钟的秒的个位
	input wire [3:0] alarm_secH,//调闹钟的秒的十位
	input wire [3:0] alarm_minL,//调闹钟的分的个位
	input wire [3:0] alarm_minH,//调闹钟的分的十位
	input wire [3:0] alarm_hourL,//调闹钟的时的个位
	input wire [3:0] alarm_hourH,//调闹钟的时的十位
	
	output reg alarm_led//设置led3为触发闹钟的标志，当到达设置的闹钟点的时��?闹钟点后10��?开始报��?即闪��?，led3闪烁10��?
);
reg [4:0] led_ctrl;
always @ (posedge div_clk or negedge rst_n) begin
	if(!rst_n) begin //初始��?
		alarm_led<=1'b1;//设初始化为灭灯的状��?
		led_ctrl <= 1'b0;
	end
	else begin
		//当当前时间的小时高低位、分钟高低位、秒的高位等于s设置的闹钟的时候，持续亮灯
		if(secL==alarm_secL && secH==alarm_secH && minL==alarm_minL && minH==alarm_minH && hourL==alarm_hourL && hourH==alarm_hourH) begin
			alarm_led<=1'b0;//设置为常��?
			led_ctrl <= 1'b0;
		end	
//		else if(secL==alarm_secL && secH==alarm_secH && minL==alarm_minL && minH==alarm_minH && hourL==alarm_hourL && hourH==alarm_hourH)
	//		alarm_led<=1'b0;//设置为长��?
		else begin
			if(alarm_led == 1'b0) begin
				led_ctrl <= led_ctrl + 1'b1;
				if(led_ctrl == 4'b1110) begin
					alarm_led<=1'b1;//设置为长��?
				end
			end
		end	
	end
end
 
endmodule
