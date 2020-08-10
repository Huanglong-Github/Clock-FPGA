module clockTest(
	input clk,//时钟信号50Mhz
	input rst_n,//复位信号
	
	input sw0, //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	input sw1, //拨动开��?，用于标记是手动调时间还是手动调闹钟
	input sw2,
	input sw3,
	input select_option,//按键0(key0)用来决定手动调时时候是调秒、分钟还是小时��?
	
	input add_time,//按键1(key1)用来决定手动调整的时分秒的大小，每按下一次按键，��?
	
	output alarm_led,//设置led3为触发闹钟的标志，当到达设置的闹钟点的时��?闹钟点后10��?开始报��?即闪��?，led3闪烁10��?
	output hour_led,//设置led2为整点报时的标志，当快整点的时��?整点��?0��?开始报��?即常��?，led2闪烁10��?
	
	output wire [7:0] digital_tube_1,//输出电子数码��?
	output wire [7:0] digital_tube_2,//输出电子数码��?
	output wire [7:0] digital_tube_3,//输出电子数码��?
	output wire [7:0] digital_tube_4,//输出电子数码��?
	
	output led0,//led0的输出端��?
	output led1//led1的输出端��?
);


	
wire clk_div; //分频后的输出信号，每1s输出一��?

wire [3:0] manual_secL;//手动调时的秒的个��?
wire [3:0] manual_secH;//手动调时的秒的十��?
wire [3:0] manual_minL;//手动调时的分的个��?
wire [3:0] manual_minH;//手动调时的分的十��?
wire [3:0] manual_hourL;//手动调时的时的个��?
wire [3:0] manual_hourH;//手动调时的时的十��?
	
wire [3:0] self_secL;//自动计时的秒的个��?
wire [3:0] self_secH;//自动计时的秒的十��?
wire [3:0] self_minL;//自动计时的分的个��?
wire [3:0] self_minH;//自动计时的分的十��?
wire [3:0] self_hourL;//自动计时的时的个��?
wire [3:0] self_hourH;//自动计时的时的十��?

wire [3:0] alarm_secL;//调闹钟的秒的个位
wire [3:0] alarm_secH;//调闹钟的秒的十位
wire [3:0] alarm_minL;//调闹钟的分的个位
wire [3:0] alarm_minH;//调闹钟的分的十位
wire [3:0] alarm_hourL;//调闹钟的时的个位
wire [3:0] alarm_hourH;//调闹钟的时的十位

wire [3:0] secL;//最终的秒的个位
wire [3:0] secH;//最终的秒的十位
wire [3:0] minL;//最终的分的个位
wire [3:0] minH;//最终的分的十位
wire [3:0] hourL;//最终的时的个位
wire [3:0] hourH;//最终的时的十位

wire [3:0] sec_1;//秒表的个位
wire [3:0] sec_2;//十位
wire [3:0] sec_3;//百位
wire [3:0] sec_4;//千位


wire [1:0] option;//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?

fenPIN u_fenPIN(
	.clk 		(clk),				//系统时钟,实验室里面的板子��?0Mhz，相当于��?0ns一次时钟信��?
	.rst_n 	(rst_n),		   //系统复位，低电平有效
	.clk_div (clk_div)  //分频后的输出信号，每1s输出一��?
);

self_clocking u_self_clocking(
	.div_clk (clk_div),//1s一次的分频好的时钟信号
	.rst_n(rst_n),//复位信号
	.sw0(sw0), //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	.sw1(sw1), //拨动开��?，用于标记是手动调时间还是手动调闹钟
	.manual_secL(manual_secL),//手动调时的秒的个��?
	.manual_secH(manual_secH),//手动调时的秒的十��?
	.manual_minL(manual_minL),//手动调时的分的个��?
	.manual_minH(manual_minH),//手动调时的分的十��?
	.manual_hourL(manual_hourL),//手动调时的时的个��?
	.manual_hourH(manual_hourH),//手动调时的时的十��?
	.self_secL(self_secL),//自动计时的秒的个��?
	.self_secH(self_secH),//自动计时的秒的十��?
	.self_minL(self_minL),//自动计时的分的个��?
	.self_minH(self_minH),//自动计时的分的十��?
	.self_hourL(self_hourL),//自动计时的时的个��?
	.self_hourH(self_hourH)//自动计时的时的十��?
);

manual_clocking u_manual_clocking(
	.rst_n(rst_n),//复位信号
	.clk(clk),//时钟信号
	.sw0(sw0), //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	.sw1(sw1), //拨动开��?，用于标记是手动调时间还是手动调闹钟
	.add_time(add_time),//按键1(key1)用来决定手动调整的时分秒的大小，每按下一次按键，��?
	.option(option),//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?
	.manual_secL(manual_secL),//手动调时的秒的个��?
	.manual_secH(manual_secH),//手动调时的秒的十��?
	.manual_minL(manual_minL),//手动调时的分的个��?
	.manual_minH(manual_minH),//手动调时的分的十��?
	.manual_hourL(manual_hourL),//手动调时的时的个��?
	.manual_hourH(manual_hourH)//手动调时的时的十��?
	
);

set_alarm u_set_alarm(
	.rst_n(rst_n),//复位信号
	.clk(clk),
	.sw0(sw0), //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	.sw1(sw1), //拨动开��?，用于标记是手动调时间还是手动调闹钟
	.add_time(add_time),//按键1(key1)用来决定手动调整的时分秒的大小，每按下一次按键，��?
	.option(option),//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?
	.alarm_secL(alarm_secL),//调闹钟的秒的个位
	.alarm_secH(alarm_secH),//调闹钟的秒的十位
	.alarm_minL(alarm_minL),//调闹钟的分的个位
	.alarm_minH(alarm_minH),//调闹钟的分的十位
	.alarm_hourL(alarm_hourL),//调闹钟的时的个位
	.alarm_hourH(alarm_hourH)//调闹钟的时的十位
);

alarm_clocking u_alarm_clocking(
	.div_clk (clk_div),//1s一次的分频好的时钟信号
	.rst_n(rst_n),//复位信号
	.secL(secL),//最终的秒的个位
	.secH(secH),//最终的秒的十位
	.minL(minL),//最终的分的个位
	.minH(minH),//最终的分的十位
	.hourL(hourL),//最终的时的个位
	.hourH(hourH),//最终的时的十位
	.alarm_secL(alarm_secL),//调闹钟的秒的个位
	.alarm_secH(alarm_secH),//调闹钟的秒的十位
	.alarm_minL(alarm_minL),//调闹钟的分的个位
	.alarm_minH(alarm_minH),//调闹钟的分的十位
	.alarm_hourL(alarm_hourL),//调闹钟的时的个位
	.alarm_hourH(alarm_hourH),//调闹钟的时的十位
	.alarm_led(alarm_led)//设置led3为触发闹钟的标志，当到达设置的闹钟点的时��?闹钟点后10��?开始报��?即闪��?，led3闪烁10��?
);

decide_option u_decide_option(
	.rst_n(rst_n),//复位信号
	.clk(clk),//时钟信号
	.select_option(select_option),//按键0(key0)用来决定手动调时时候是调秒、分钟还是小时��?
	.option(option)//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?
);

count u_count(
	.div_clk(clk_div),//1s一次的分频好的时钟信号
	.sw2(sw2), 
	.sw3(sw3),
	.sec_1(sec_1),
	.sec_2(sec_2),
	.sec_3(sec_3),
	.sec_4(sec_4)
);

set_final_time u_set_final_time(
	.sw0(sw0), //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	.sw1(sw1), //拨动开��?，用于标记是手动调时间还是手动调闹钟
	.sw2(sw2),
	.self_secL(self_secL),//自动计时的秒的个��?
	.self_secH(self_secH),//自动计时的秒的十��?
	.self_minL(self_minL),//自动计时的分的个��?
	.self_minH(self_minH),//自动计时的分的十��?
	.self_hourL(self_hourL),//自动计时的时的个��?
	.self_hourH(self_hourH),//自动计时的时的十��?
	.manual_secL(manual_secL),//手动调时的秒的个��?
	.manual_secH(manual_secH),//手动调时的秒的十��?
	.manual_minL(manual_minL),//手动调时的分的个��?
	.manual_minH(manual_minH),//手动调时的分的十��?
	.manual_hourL(manual_hourL),//手动调时的时的个��?
	.manual_hourH(manual_hourH),//手动调时的时的十��?
	.alarm_secL(alarm_secL),//调闹钟的秒的个位
	.alarm_secH(alarm_secH),//调闹钟的秒的十位
	.alarm_minL(alarm_minL),//调闹钟的分的个位
	.alarm_minH(alarm_minH),//调闹钟的分的十位
	.alarm_hourL(alarm_hourL),//调闹钟的时的个位
	.alarm_hourH(alarm_hourH),//调闹钟的时的十位
	.sec_1(sec_1),
	.sec_2(sec_2),
	.sec_3(sec_3),
	.sec_4(sec_4),
	.secL(secL),//最终的秒的个位
	.secH(secH),//最终的秒的十位
	.minL(minL),//最终的分的个位
	.minH(minH),//最终的分的十位
	.hourL(hourL),//最终的时的个位
	.hourH(hourH)//最终的时的十位
);

hour_alarm u_hour_alarm(
	.div_clk (clk_div),//1s一次的分频好的时钟信号
	.rst_n(rst_n),//复位信号
	.secL(secL),//最终的秒的个位
	.secH(secH),//最终的秒的十位
	.minL(minL),//最终的分的个位
	.minH(minH),//最终的分的十位
	.hourL(hourL),//最终的时的个位
	.hourH(hourH),//最终的时的十位
	.hour_led(hour_led)//设置led2为整点报时的标志，当快整点的·时��?整点��?0��?开始报��?即常��?，led2闪烁10��?
);

show u_show(
	.sw0(sw0), //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	.sw1(sw1), //拨动开��?，用于标记是手动调时间还是手动调闹钟
	.rst_n(rst_n),//复位信号
	.secL(secL),//最终的秒的个位
	.secH(secH),//最终的秒的十位
	.minL(minL),//最终的分的个位
	.minH(minH),//最终的分的十位
	.hourL(hourL),//最终的时的个位
	.hourH(hourH),//最终的时的十位
	.digital_tube_1(digital_tube_4),//输出电子数码��?
	.digital_tube_2(digital_tube_3),//输出电子数码��?
	.digital_tube_3(digital_tube_2),//输出电子数码��?
	.digital_tube_4(digital_tube_1),//输出电子数码��?
	.led0(led0),//led1的输出端��?
	.led1(led1)//led0的输出端��?
);

endmodule
