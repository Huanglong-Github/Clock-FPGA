module show(
	input sw0, //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	input sw1, //拨动开��?，用于标记是手动调时间还是手动调闹钟:��?手动调时，为0设置闹钟
	
	input rst_n,//复位信号
	
	input wire [3:0] secL,//最终的秒的个位
	input wire [3:0] secH,//最终的秒的十位
	input wire [3:0] minL,//最终的分的个位
	input wire [3:0] minH,//最终的分的十位
	input wire [3:0] hourL,//最终的时的个位
	input wire [3:0] hourH,//最终的时的十位
	
	output reg [7:0] digital_tube_1,//输出电子数码��?
	output reg [7:0] digital_tube_2,//输出电子数码��?
	output reg [7:0] digital_tube_3,//输出电子数码��?
	output reg [7:0] digital_tube_4,//输出电子数码��?
	
	output reg led0,//led1的输出端��?
	output reg led1//led0的输出端��?
);
reg led_ctrl_secL; //这个变量主要是为了控制秒的个位led灯的显示
reg led_ctrl_secH; //这个变量主要是为了控制秒的十位led灯的显示

always @ (secL or rst_n) begin
	if(!rst_n) begin
		led0 <= 1'b1;//led0初始化状态为灭灯
		led_ctrl_secL <= 1'b0;//初始化为0
	end
	else begin
		//led_ctrl_secL <= led_ctrl_secL + 1'b1;
		//case(led_ctrl_secL)
		//	1'b0:		led0 <= 1'b0;//亮灯
		//	1'b1: 	led0 <= 1'b1;//灭灯
		//default:		led0 <= 1'b0;		
		//endcase
		led0 <= ~led0;
	end	
end

always @ (secH or rst_n) begin
	if(!rst_n) begin
		led1 <= 1'b1;//led0初始化状态为灭灯
		led_ctrl_secH <= 1'b0;//初始化为0
	end	
	else	begin
		//led_ctrl_secH <= led_ctrl_secH + 1'b1;
		//case(led_ctrl_secH)
		//	1'b0:		led1 <= 1'b0;//亮灯
		//	1'b1: 	led1 <= 1'b1;//灭灯
		//default:		led1 <= 1'b0;		
		//endcase
		led1 <= ~led1;
	end	
end

always @ (minL or rst_n) begin
	case(minL)
		4'b0000:digital_tube_1<=8'b1100_0000;//0
		4'b0001:digital_tube_1<=8'b1111_1001;//1
		4'b0010:digital_tube_1<=8'b1010_0100;//2
		4'b0011:digital_tube_1<=8'b1011_0000;//3
		4'b0100:digital_tube_1<=8'b1001_1001;//4
		4'b0101:digital_tube_1<=8'b1001_0010;//5
		4'b0110:digital_tube_1<=8'b1000_0010;//6
		4'b0111:digital_tube_1<=8'b1111_1000;//7
		4'b1000:digital_tube_1<=8'b1000_0000;//8
		4'b1001:digital_tube_1<=8'b1001_0000;//9
	default:digital_tube_1<=8'b1100_0000;
	endcase
end
always @ (minH or rst_n) begin
	case(minH)
		4'b0000:digital_tube_2<=8'b1100_0000;//0
		4'b0001:digital_tube_2<=8'b1111_1001;//1
		4'b0010:digital_tube_2<=8'b1010_0100;//2
		4'b0011:digital_tube_2<=8'b1011_0000;//3
		4'b0100:digital_tube_2<=8'b1001_1001;//4
		4'b0101:digital_tube_2<=8'b1001_0010;//5
		4'b0110:digital_tube_2<=8'b1000_0010;//6
		4'b0111:digital_tube_2<=8'b1111_1000;//7
		4'b1000:digital_tube_2<=8'b1000_0000;//8
		4'b1001:digital_tube_2<=8'b1001_0000;//9
	default:digital_tube_2<=8'b1100_0000;
	endcase
end
always @ (hourL or rst_n) begin
	case(hourL)
		4'b0000:digital_tube_3<=8'b1100_0000;//0
		4'b0001:digital_tube_3<=8'b1111_1001;//1
		4'b0010:digital_tube_3<=8'b1010_0100;//2
		4'b0011:digital_tube_3<=8'b1011_0000;//3
		4'b0100:digital_tube_3<=8'b1001_1001;//4
		4'b0101:digital_tube_3<=8'b1001_0010;//5
		4'b0110:digital_tube_3<=8'b1000_0010;//6
		4'b0111:digital_tube_3<=8'b1111_1000;//7
		4'b1000:digital_tube_3<=8'b1000_0000;//8
		4'b1001:digital_tube_3<=8'b1001_0000;//9
	default:digital_tube_3<=8'b1100_0000;
	endcase
end
always @ (hourH or rst_n) begin
	case(hourH)
		4'b0000:digital_tube_4<=8'b1100_0000;//0
		4'b0001:digital_tube_4<=8'b1111_1001;//1
		4'b0010:digital_tube_4<=8'b1010_0100;//2
		4'b0011:digital_tube_4<=8'b1011_0000;//3
		4'b0100:digital_tube_4<=8'b1001_1001;//4
		4'b0101:digital_tube_4<=8'b1001_0010;//5
		4'b0110:digital_tube_4<=8'b1000_0010;//6
		4'b0111:digital_tube_4<=8'b1111_1000;//7
		4'b1000:digital_tube_4<=8'b1000_0000;//8
		4'b1001:digital_tube_4<=8'b1001_0000;//9
	default:digital_tube_4<=8'b1100_0000;
	endcase
end

endmodule
