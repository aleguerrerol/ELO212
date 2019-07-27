`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 23:34:53
// Design Name: 
// Module Name: bin_to_hex
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


module bin_to_hex(
    input logic [3:0] binary_input,
    
    output logic [6:0] sevenSeg //(CA,CB,CC,CD,CE,CF,CG) cátodos de los displays
    //output logic [7:0] AN        //ánodos de los displays      
    );
    always_comb begin
                            //convierte un binario de 4 bits en el hexa correspondiente (figura en el disp)
        case(binary_input)                            //Notar que los leds del display son active low.
            4'd0:   sevenSeg =  7'b0000001; //0
            4'd1:   sevenSeg =  7'b1001111; //1
            4'd2:   sevenSeg =  7'b0010010; //2
            4'd3:   sevenSeg =  7'b0000110; //3
            4'd4:   sevenSeg =  7'b1001100; //4
            4'd5:   sevenSeg =  7'b0100100; //5
            4'd6:   sevenSeg =  7'b1100000; //6
            4'd7:   sevenSeg =  7'b0001111; //7
            4'd8:   sevenSeg =  7'b0000000; //8
            4'd9:   sevenSeg =  7'b0001100; //9
            4'd10:   sevenSeg = 7'b0001000; //A
            4'd11:   sevenSeg = 7'b1100000; //b
            4'd12:   sevenSeg = 7'b0110001; //C
            4'd13:   sevenSeg = 7'b1000010; //d
            4'd14:   sevenSeg = 7'b0110000; //E
            4'd15:   sevenSeg = 7'b0111000; //F
            default: sevenSeg = 7'b1111111;
        endcase
    end
endmodule