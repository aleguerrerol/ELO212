`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2019 04:32:28
// Design Name: 
// Module Name: shift_registers
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

// shift_registers nombre_(.clk(),.rst(),.bttn(),.bit_in(),.dato());

module shift_registers(
    input logic clk, rst, bttn,
    input logic [4:0]bit_in,
    
    output logic [15:0]datoo
    //output logic [3:0]q1,[3:0]q2,[3:0]q3,[3:0]q4
    );
    logic [3:0]AUX;
    assign AUX[3:0] = bit_in[3:0];
    
    logic [3:0]d1;  logic [3:0]d2;  logic [3:0]d3;  logic [3:0]d4;
    logic [3:0]q1;  logic [3:0]q2;  logic [3:0]q3;  logic [3:0]q4;
    
    logic [3:0]d1_next; logic d2_next; logic [3:0]d3_next; logic [3:0]d4_next;
    
    always_comb begin
        d1_next=AUX;
        d2_next=q1;
        d3_next=q2;
        d4_next=q3;
    end
    
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            q1<='b0;
            q2<='b0;
            q3<='b0;
            q4<='b0;
        end
        else if (bttn) begin
            q1<=d1_next;
            q2<=d2_next;
            q3<=d3_next;
            q4<=d4_next;
        end
    end
    
    /*assign dato[15:12]=q4;
    assign dato[11:8]=q3;
    assign dato[7:4]=q2;
    assign dato[3:0]=q1;
    */
    
endmodule

