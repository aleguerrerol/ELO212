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


// template top(.clk(),.rst(),.btnc(),.val(),.canal_pantalla(),.op(),.op1(),.op2())

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
    logic [2:0]estado;
    logic [15:0]dato_a;
    logic [15:0]dato_b;
    logic [2:0]operation;
    logic t1,t2,top;
    logic [15:0]result;
    logic [15:0]op_out;
    logic reset;

    
    always_comb begin
    if ((val == 5'h1_0011) && btnc) //si val es exe, exe = 1
        exe=1;
    else
        exe=0;
    end
    
    maquina maxin(.clk(clk),.rst(rst),.exe(exe),.button(btnc),.trigger_1(t1),.trigger_2(t2),
                    .trigger_op(top),.estado(estado),.reset_a_reg(reset));
    
    shift_registers op_a(.clk(clk),.rst(rst),.bttn(t1),.bit_in(val),.dato(dato_a),.reset(reset));
    shift_registers op_b(.clk(clk),.rst(rst),.bttn(t2),.bit_in(val),.dato(dato_b),.reset(reset));
    fliflo nombre_(.clk(clk),.rst(rst),.en(top),.D(val),.Q(operation),.reset(reset));
    ALU lalu(.A(dato_a),.B(dato_b),.OP(operation[2:0]),.result(result));

    
    assign op_out[15:5]='b0;
    assign op_out[4:0]=operation;
    
    always_comb begin        
        case(estado)
            'd0:    canal_pantalla=dato_a;
            'd1:    canal_pantalla=dato_b;
            'd2:    canal_pantalla=op_out;
            'd3:    canal_pantalla=result;
            default: canal_pantalla=16'b0;
        endcase
    end
    
    assign op1=dato_a;
    assign op2=dato_b;
    assign op=op_out;

endmodule
