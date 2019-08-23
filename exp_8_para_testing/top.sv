`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2019 02:45:27
// Design Name: 
// Module Name: top
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


module top(
    input logic clk, rst, btnc,
    input logic [4:0]val,
    //input logic exe,                    //agregar logica para sacar 1 caundo val = exe.
    
    output logic [15:0]canal_pantalla,          //mux
    output logic [2:0]op,
    output logic [15:0]op1,
    output logic [15:0]op2
    );
    logic exe;
    logic [1:0]estado;
    logic [15:0]dato_a;
    logic [15:0]dato_b;
    logic [4:0]operation;
    logic t1,t2,top;
    logic [15:0]result;
    logic [15:0]op_out;
    
    assign op_out[15:5]='b0;
    assign op_out[2:0]=operation;
    
    always_comb begin
    if (val == 5'b1_0011) //si val es exe, exe = 1
        exe=1;
    else
        exe=0;
    end
    
    maquina maxin(.clk(clk),.rst(rst),.exe(exe),.button(btnc),.trigger_1(t1),.trigger_2(t2),
                    .trigger_op(top),.estado(estado));
    
    shift_registers op_a(.clk(clk),.rst(rst),.bttn(t1),.bit_in(val),.dato(dato_a));
    shift_registers op_b(.clk(clk),.rst(rst),.bttn(t2),.bit_in(val),.dato(dato_b));
    fliflo nombre_(.clk(clk),.rst(rst),.en(top),.D(val),.Q(operation));
    
    ALU lalu(.A(dato_a),.B(dato_b),.OP(operation[2:0]),.result(result));

    always_comb begin        
        case(estado)
            'd0:    canal_pantalla=dato_a;
            'd1:    canal_pantalla=dato_b;
            'd2:    canal_pantalla=op_out;
            'd3:    canal_pantalla=result;
        endcase
    end

endmodule
