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
/* para agregar CLR
c1 y c2 en la FSM
agregar clear

*/

// template top(.clk(),.rst(),.btnc(),.val(),.canal_pantalla(),.op(),.op1(),.op2())

module top(
    input logic clk, rst, btnc,
    input logic [4:0]val,
    
    output logic [15:0]canal_pantalla,          //mux
    output logic [2:0]op,
    output logic [15:0]op1,
    output logic [15:0]op2,
    output logic [15:0]LED
    );

    logic [1:0]estado;
    logic [15:0]dato_a;
    logic [15:0]dato_b;
    logic [2:0]operation;
    logic t1,t2,top;
    logic [15:0]result;
    logic [15:0]op_out;
    logic clear;

    logic [15:0]a_to_screen;
    logic [15:0]b_to_screen;
    logic c1, c2;
    
    
    maquina maxin(.LED(LED),.clk(clk),.rst(rst),.button(btnc),.trigger_1(t1),.trigger_2(t2),
                    .trigger_op(top),.estado(estado),.clear(clear), .val(val), .c1(c1), .c2(c2));
    
    shift_registers op_a(.clk(clk),.rst(rst),.bttn(t1),.bit_in(val),.dato(dato_a),.clear(clear));
    shift_registers op_b(.clk(clk),.rst(rst),.bttn(t2),.bit_in(val),.dato(dato_b),.clear(clear));
    fliflo nombre_(.clk(clk),.rst(rst),.en(top),.D(val),.Q(operation),.clear(clear));
    
    ALU lalu(.A(dato_a),.B(dato_b),.OP(operation[2:0]),.result(result));

    register_synch_reset_load_nbit banco_op_a (.D(dato_a), .clk(clk), .rst(rst), .load(c1), .Q(a_to_screen), .clear(clear));
    register_synch_reset_load_nbit banco_op_b (.D(dato_b), .clk(clk), .rst(rst), .load(c2), .Q(b_to_screen), .clear(clear));
    
    assign op_out[15:5]='b0;
    assign op_out[4:0]=operation;
    
    always_comb begin        
        case(estado)
            'd0:    canal_pantalla=dato_a;
            'd1:    canal_pantalla=dato_b;
            'd2:    canal_pantalla=result;
            'd3:    canal_pantalla=16'b0;
            default: canal_pantalla=16'b0;
        endcase
    end
    
    assign op1=a_to_screen;
    assign op2=b_to_screen;
    assign op=op_out;

endmodule
