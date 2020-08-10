module decide_option(
	input rst_n,//复位信号
	input clk,//时钟信号
	input select_option,//按键0(key0)用来决定手动调时时候是调秒、分钟还是小时��?
	output reg [1:0] option//option等于0表示调秒、等��?表示调分、等��?表示等于调小��?
);
wire key_value;//按键防抖的后键值
wire key_flag;//按键防抖后的标志

key_debounce u_key_debounce(
    .clk(clk),
    .rst_n(rst_n),
    .key(select_option),
    .key_value(key_value),
    .key_flag(key_flag)
);

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		option <= 2'd0;
	end
	else begin
		if(key_flag && (~key_value)) begin
			if(option == 2'd2)
				option <= 1'b0;
			else 
				option <= option + 1'b1;
		end
	end
end

endmodule
