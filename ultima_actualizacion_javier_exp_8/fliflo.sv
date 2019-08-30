`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2019 12:39:34
// Design Name: 
// Module Name: fliflo
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

// fliflo nombre_(.clk(),.rst(),.en(),.D(),.Q(), .clear);

module fliflo(
    input logic clk, rst, clear,  en,
    input logic [4:0]D,
    
    output logic [2:0]Q
    );
    logic [2:0] OP;
    assign OP = D[2:0];
    always_ff @(posedge clk, posedge rst) begin
        if (rst || clear) begin
            Q<='b111;
        end
        else if (en) begin
            Q<=OP;
        end
    end
    
endmodule
