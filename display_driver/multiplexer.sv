`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 22:42:55
// Design Name: 
// Module Name: multiplexer
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


module multiplexer(
    input logic [3:0]d_7,d_6,d_5,d_4,d_3,d_2,d_1,d_0,
    input logic [2:0]contador,  //recibe la cuenta producida por el clock para hacer el TDM
    output logic [3:0]dato      //4 bits de salida (bin)
    );
    always_comb begin
        case(contador)
            3'b000: begin 
                    dato=d_0;
                    end
            3'b001: begin
                    dato=d_1;
                    end
            3'b010: begin
                    dato=d_2;
                    end
            3'b011: begin
                    dato=d_3;
                    end
            3'b100: begin
                    dato=d_4;
                    end
            3'b101: begin
                    dato=d_5;
                    end
            3'b110: begin
                    dato=d_6;
                    end
            3'b111: begin
                    dato=d_7;
                    end
        endcase
    end
endmodule