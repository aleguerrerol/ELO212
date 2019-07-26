`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2019 19:12:40
// Design Name: 
// Module Name: Mux_32_4
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


module Mux_32_4 #(parameter D7=0,D6=0,D5=0,D4=0,D3=0,D2=0,D1=1,D0=1)    //PARÁMETRO REGULA DISPLAYS ON [7 to 0]
(
    input logic [3:0]data_7,data_6,data_5,data_4,data_3,data_2,data_1,data_0,       //números para cada disp
    input logic [2:0]counter, //recibe la cuenta producida por el clock para hacer el TDM (desde el display 0 al 7)
    
    output logic [7:0]anodos,                             //LAS HABIA SETEADO COMO ENTRADAS AAAAAAAAHHHHHHHHHGGGGGG
    output logic [3:0]DIG      //número a representar
    );
    always_comb begin
    
        case(counter)                   //edit: ahora controlariamos los anodos desde aquí, sin una lut.
            3'b000:begin
                    if (D0) begin
                        DIG = data_0;
                        anodos=8'b11111110;
                    end
                    else begin 
                        anodos=8'b11111111;
                    end
                   end
            3'b001:begin
                    if (D1) begin 
                        DIG = data_1;
                        anodos=8'b11111101;
                    end
                    else begin 
                        anodos=8'b11111111;
                    end
                   end
            3'b010:begin
                    if (D2) begin 
                        DIG = data_2;
                        anodos=8'b11111011;
                    end
                    else begin 
                        anodos=8'b11111111;
                    end
                   end
            3'b011:begin
                     if (D3) begin 
                        DIG = data_3;
                        anodos=8'b11110111;
                     end
                     else begin 
                        anodos=8'b11111111;
                     end
                   end
            3'b100:begin
                     if (D4) begin 
                        DIG = data_4;
                        anodos=8'b11101111;
                    end
                    else begin 
                        anodos=8'b11111111;
                    end
                   end
            3'b101:begin
                     if (D5) begin 
                        DIG = data_5;
                        anodos=8'b11011111;
                     end
                     else begin 
                        anodos=8'b11111111;
                     end
                   end
            3'b110:begin
                     if (D6) begin 
                        DIG = data_6;
                        anodos=8'b10111111;
                     end
                     else begin 
                        anodos=8'b11111111;
                     end
                   end
            3'b111: begin
                    if (D7) begin 
                        DIG = data_7;
                        anodos=8'b01111111;
                    end
                    else begin 
                        anodos=8'b11111111;
                    end
                   end
        endcase 
    end      
endmodule
