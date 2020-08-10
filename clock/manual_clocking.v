module manual_clocking(
	input rst_n,//复位信号
	input clk,//时钟信号
	
	input sw0, //拨动开��?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时��?
	input sw1, //拨动开��?，用于标记是手动调时间还是手动调闹钟
	input add_time,//按键1(key1)用来决定手动调整的时分秒的大小，每按下一次按键，��?
	input wire [1:0] option,//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?
	
	output reg [3:0] manual_secL,//手动调时的秒的个��?
	output reg [3:0] manual_secH,//手动调时的秒的十��?
	output reg [3:0] manual_minL,//手动调时的分的个��?
	output reg [3:0] manual_minH,//手动调时的分的十��?
	output reg [3:0] manual_hourL,//手动调时的时的个��?
	output reg [3:0] manual_hourH//手动调时的时的十��?
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

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin //初始��?
		manual_secL <= 4'b0000;
		manual_secH <= 4'b0000;
		manual_minL <= 4'b0000;
		manual_minH <= 4'b0000;
		manual_hourL <= 4'b0000;
		manual_hourH <= 4'b0000;		
	end
	else begin
		if(key_flag && (~key_value)) begin
			if(sw0==0 && sw1==1) begin //sw=0表示开启手动模式，sw1=1表示开始手动调��?
				if(option == 2'd0) begin
					if(manual_secL==9) begin
						manual_secL <= 4'b0000;
						if(manual_secH==5)
							manual_secH <= 4'b0000;
						else 
							manual_secH <= manual_secH + 1'b1;
					end
					else 
						manual_secL <= manual_secL + 1'b1;                        
						
				end
				if(option == 2'd1) begin
					if(manual_minL==9) begin
						manual_minL <= 4'b0000;
						if(manual_minH==5)
							manual_minH <= 4'b0000;
						else 
							manual_minH <= manual_minH + 1'b1;
					end
					else
						manual_minL <= manual_minL + 1'b1;
				end
				if(option == 2'd2) begin
					if(manual_hourH<2) begin //如果小时的十位小��?
						if(manual_hourL==9) begin
							manual_hourL <= 4'b0000;
							manual_hourH <= manual_hourH + 1'b1;
						end
						else
							manual_hourL <= manual_hourL + 1'b1;	
					end
					else begin
						if(manual_hourL==3) begin
							manual_hourL <= 4'b0000;
							manual_hourH <= 4'b0000;
						end
						else
							manual_hourL <= manual_hourL + 1'b1;
					end	
				end
			end
		end
	end	
end

endmodule

