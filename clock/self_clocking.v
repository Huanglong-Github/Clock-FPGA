module self_clocking(
	input div_clk,//1s一次的分频好的时钟信号
	input rst_n,//复位信号
	
	input sw0, //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	input sw1, //拨动开��?，用于标记是手动调时间还是手动调闹钟

	input wire [3:0] manual_secL,//手动调时的秒的个��?
	input wire [3:0] manual_secH,//手动调时的秒的十��?
	input wire [3:0] manual_minL,//手动调时的分的个��?
	input wire [3:0] manual_minH,//手动调时的分的十��?
	input wire [3:0] manual_hourL,//手动调时的时的个��?
	input wire [3:0] manual_hourH,//手动调时的时的十��?
	
	output reg [3:0] self_secL,//自动计时的秒的个��?
	output reg [3:0] self_secH,//自动计时的秒的十��?
	output reg [3:0] self_minL,//自动计时的分的个��?
	output reg [3:0] self_minH,//自动计时的分的十��?
	output reg [3:0] self_hourL,//自动计时的时的个��?
	output reg [3:0] self_hourH//自动计时的时的十��?
);
always @ (posedge div_clk or negedge rst_n) begin
	if(!rst_n) begin
		self_secL <= 4'b0000;
		self_secH <= 4'b0000;
		self_minL <= 4'b0111;
		self_minH <= 4'b0101;
		self_hourL <= 4'b0011;
		self_hourH <= 4'b0010;
	end
	else begin
		if(sw0 == 1 || (sw0==0 && sw1==1)) begin //如果sw0等于1，进入自动计��?或者当设置闹钟的时候，自动计时还是继续运行
			//如果到了末状态即23:59:59��?
			if(self_hourH==4'b0010 && self_hourL==4'b0011 && self_minH==4'b0101 && self_minL==4'b1001 && self_secH==4'b0101 && self_secL==4'b1001) begin
				self_secL <= 4'b0000;
				self_secH <= 4'b0000;
				self_minL <= 4'b0000;
				self_minH <= 4'b0000;
				self_hourL <= 4'b0000;
				self_hourH <= 4'b0000;
			end
			//普通状态时计时
			else begin
				if(self_secL==9) begin
					self_secL<=4'b0000;
					if(self_secH==5) begin
						self_secH<=4'b0000;
						if(self_minL==9) begin
							self_minL<=4'b0000;
							if(self_minH==5) begin
								self_minH<=4'b0000;
								if(self_hourH<2) begin
									if(self_hourL==9) begin 
										self_hourL <= 4'b0000;
										self_hourH <= self_hourH + 1'b1;
									end
									else
										self_hourL <= self_hourL + 1'b1;
								end
								else 
									if(self_hourL==3) begin
										self_hourL <= 4'b0000;
										self_hourH <= 4'b0000;
									end
									else
										self_hourL <= self_hourL + 1'b1;
							end
							else
								self_minH<=self_minH+1'b1;
						end
						else
							self_minL<=self_minL+1'b1;
					end
					else
						self_secH<=self_secH+1'b1;
				end
				else
					self_secL<=self_secL+1'b1;
			end
		end
		if(sw0==0 && sw1==1) begin//sw0��?代表进入手动模式，sw1��?代表是手动调时模式，sw1��?代表闹钟模式
			//继承手动模式的结��?
			self_secL <= manual_secL;
			self_secH <= manual_secH;
			self_minL <= manual_minL;
			self_minH <= manual_minH;
			self_hourL <= manual_hourL;
			self_hourH <= manual_hourH;
		end
	end
end

endmodule

