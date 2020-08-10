module initialSW(
	input rst_n,//复位信号
	
	input sw_0, //拨动开�?,用于标记是手动调时间还是自动计时：为1自动计时，为0手动调时�?
	input sw_1, //拨动开�?，用于标记是手动调时间还是手动调闹钟
	
	output reg sw0,
	output reg sw1
);
always @ (rst_n or sw0 or sw1) begin
	if(!rst_n) begin
		sw0 <= 1;
		sw1 <= 1;
	end
	else begin
		sw0 <= sw_0;
		sw1 <= sw_1;
	end
end
endmodule 
