/**
	设置闹钟模块
*/
module set_alarm(
	input rst_n,//复位信号
	input clk,
	input sw0, //拨动开关sw0,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时
	input sw1, //拨动开关sw1，用于标记是手动调时间还是手动调闹钟
	input add_time,//按键1(key1)用来决定手动调整的时分秒的大小，每按下一次按键，加1
	input wire [1:0] option,//option等于0表示调秒、等于1表示调分、等于2表示等于调小时
	
	output reg [3:0] alarm_secL,	//调闹钟的秒的个位
	output reg [3:0] alarm_secH,	//调闹钟的秒的十位
	output reg [3:0] alarm_minL,	//调闹钟的分的个位
	output reg [3:0] alarm_minH,	//调闹钟的分的十位
	output reg [3:0] alarm_hourL,	//调闹钟的时的个位
	output reg [3:0] alarm_hourH	//调闹钟的时的十位
);
wire key_value;//按键防抖的后键值
wire key_flag;//按键防抖后的标志

key_debounce u_key_debounce(
    .clk(clk),
    .rst_n(rst_n),
    .key(add_time),
    .key_value(key_value),
    .key_flag(key_flag)
);
always @ (posedge add_time or negedge rst_n) begin
	if(!rst_n) begin //初始��?
		alarm_secL <= 4'b0000;
		alarm_secH <= 4'b0000;
		alarm_minL <= 4'b0000;
		alarm_minH <= 4'b0000;
		alarm_hourL <= 4'b0000;
		alarm_hourH <= 4'b0000;	
	end
	else begin
	if(key_flag && (~key_value)) begin
		if(sw0==0 && sw1==0) begin//sw=0表示开启手动模式，sw1=0表示开始设置闹��?
				if(option == 2'd0) begin
					if(alarm_secL==9) begin
						alarm_secL <= 4'b0000;
						if(alarm_secH==5)
							alarm_secH <= 4'b0000;
						else 
							alarm_secH <= alarm_secH + 1'b1;
					end
					else 
						alarm_secL <= alarm_secL + 1'b1;
				end
				if(option == 2'd1) begin
					if(alarm_minL==9) begin
						alarm_minL <= 4'b0000;
						if(alarm_minH==5)
							alarm_minH <= 4'b0000;
						else 
							alarm_minH <= alarm_minH + 1'b1;
					end
					else
						alarm_minL <= alarm_minL + 1'b1;
				end
				if(option == 2'd2) begin
					if(alarm_hourH<2) begin //如果小时的十位小��?
						if(alarm_hourL==9) begin
							alarm_hourL <= 4'b0000;
							alarm_hourH <= alarm_hourH + 1'b1;
						end
						else
							alarm_hourL <= alarm_hourL + 1'b1;	
					end
					else begin
						if(alarm_hourL==3) begin
							alarm_hourL <= 4'b0000;
							alarm_hourH <= 4'b0000;
						end
						else
							alarm_hourL <= alarm_hourL + 1'b1;
					end	
				end
			end
		end
	end
end

endmodule
