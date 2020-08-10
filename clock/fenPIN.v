module fenPIN(
	input clk,				//系统时钟,实验室里面的板子��?0Mhz，相当于��?0ns一次时钟信��?
	input rst_n,		   //系统复位，低电平有效
	output reg clk_div   //分频后的输出信号，每1s输出一��?
);

reg [25:0] cnt;				//5000_0000的二位数��?6位，故设置为26位寄存器

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt <= 26'd0;
		clk_div <= 1'd0;
	end
	else begin
		if(cnt == 26'd5) begin
			clk_div <= 1'b1;//��?000_0000次clk上升沿clk_div置为1
			cnt <= 26'd0;//cnt重新置为0
		end
		else begin
			clk_div <= 1'b0;//除了��?000_0000次上升沿��?外，其他时间置为0
			cnt <= cnt + 1'b1;//每来一个clk，cnt��?
		end
	end
end

endmodule 


