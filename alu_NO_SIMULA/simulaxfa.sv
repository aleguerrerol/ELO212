`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2019 00:05:33
// Design Name: 
// Module Name: simulaxfa
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simulaxfa(
    );
    logic [15:0]a_input;
    logic [15:0]b_input;
    logic [15:0]op_input;
    logic [16:0]RESULT;
    logic carry_out;
    
    alu alu(.A(a_input),.B(b_input),.OP(op_input),.result(RESULT),.error(carry_out));
    
    initial begin
        a_input=16'd1;
        b_input=16'd1;
        op_input=16'd0;
        
        #1000 $finish;
    end
    
endmodule
