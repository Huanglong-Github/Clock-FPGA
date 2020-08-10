module set_final_time(
	input sw0, //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时
	input sw1, //拨动开��?，用于标记是手动调时间还是手动调闹钟��?为手动调时间��?为手动调闹钟
	input sw2,//开始
	
	input wire [3:0] self_secL,//自动计时的秒的个��?
	input wire [3:0] self_secH,//自动计时的秒的十��?
	input wire [3:0] self_minL,//自动计时的分的个��?
	input wire [3:0] self_minH,//自动计时的分的十��?
	input wire [3:0] self_hourL,//自动计时的时的个��?
	input wire [3:0] self_hourH,//自动计时的时的十��?

	input wire [3:0] manual_secL,//手动调时的秒的个��?
	input wire [3:0] manual_secH,//手动调时的秒的十��?
	input wire [3:0] manual_minL,//手动调时的分的个��?
	input wire [3:0] manual_minH,//手动调时的分的十��?
	input wire [3:0] manual_hourL,//手动调时的时的个��?
	input wire [3:0] manual_hourH,//手动调时的时的十��?
	
	input wire [3:0] alarm_secL,//调闹钟的秒的个位
	input wire [3:0] alarm_secH,//调闹钟的秒的十位
	input wire [3:0] alarm_minL,//调闹钟的分的个位
	input wire [3:0] alarm_minH,//调闹钟的分的十位
	input wire [3:0] alarm_hourL,//调闹钟的时的个位
	input wire [3:0] alarm_hourH,//调闹钟的时的十位
	
	input wire [3:0] sec_1,
	input wire [3:0] sec_2,
	input wire [3:0] sec_3,
	input wire [3:0] sec_4,
	
	output reg [3:0] secL,//最终的秒的个位
	output reg [3:0] secH,//最终的秒的十位
	output reg [3:0] minL,//最终的分的个位
	output reg [3:0] minH,//最终的分的十位
	output reg [3:0] hourL,//最终的时的个位
	output reg [3:0] hourH//最终的时的十位
);
always @ (sw0 or sw1 or sw2 or sec_1 or sec_2 or sec_3 or sec_4 or self_secL or self_secH or self_minL or self_minH or self_hourL or self_hourH or manual_secL or manual_secH or manual_minL or manual_minH or manual_hourL or manual_hourH or alarm_secL or alarm_secH or alarm_minL or alarm_minH or alarm_hourL or alarm_hourH) begin
	if(sw2==0) begin
		if(sw0==1) begin
			secL <= self_secL;
			secH <= self_secH;
			minL <= self_minL;
			minH <= self_minH;
			hourL <= self_hourL;
			hourH <= self_hourH;
		end
		if(sw0==0 && sw1==1) begin
			secL <= manual_secL;
			secH <= manual_secH;
			minL <= manual_minL;
			minH <= manual_minH;
			hourL <= manual_hourL;
			hourH <= manual_hourH;
		end
		if(sw0==0 && sw1==0) begin
			secL <= alarm_secL;
			secH <= alarm_secH;
			minL <= alarm_minL;
			minH <= alarm_minH;
			hourL <= alarm_hourL;
			hourH <= alarm_hourH;
		end
	end
	else begin
		secL <= 1'b1;//灭灯
		secH <= 1'b1;//灭灯
		minL <= sec_1;
		minH <= sec_2;
		hourL <= sec_3;
		hourH <= sec_4;
	end
end	

endmodule




