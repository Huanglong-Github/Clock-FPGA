/**
	按键消抖模块
	按键消抖模块实现思想：
	如果一个信号进入之后，
	保持了20ms不变，我们则认为它是消抖后稳定的信号
*/

module key_debounce(
    input clk,
    input rst_n,
    input key,
    output reg key_value,
    output reg key_flag
);

reg key_reg;//定义寄存器寄存信号
reg [19:0] delay_cnt;//设置延迟标志

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        key_reg <= 1'b1;//初始化为1
        delay_cnt <= 20'd0;
    end
    else begin
        key_reg <= key;//将按键的值寄存到寄存器中
        if(key != key_reg)
            delay_cnt <= 20'd1000_000;
        else begin
            if(delay_cnt >20'd0)
                delay_cnt <= delay_cnt - 1'b1;
            else
                delay_cnt <= 20'd0;    
        end    
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        key_value <= 1'b1;
        key_flag <= 1'b0;
    end
    else begin
         if(delay_cnt == 10'd1) begin
             key_flag <= 1'b1;
             key_value <= key;
         end
         else begin
             key_flag <= 1'b0;
             key_value <= key_value;
         end
    end
end
endmodule


