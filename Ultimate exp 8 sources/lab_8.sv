module lab_8(
	input CLK100MHZ,
	//input [1:0]SW,
	input BTNC,	BTNU, BTNL, BTNR, BTND, CPU_RESETN,
	//output [15:0] LED,
	//output CA, CB, CC, CD, CE, CF, CG,
	//output DP,
	//output [7:0] AN,

	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	logic [1:0]SW;
	logic [15:0] LED;
	logic CA, CB, CC, CD, CE, CF, CG;
	logic DP;
	logic [7:0] AN;
	
	logic CLK82MHZ;
	logic rst = 0; //por qué estamos forzando estos rst a 0?
	logic hw_rst = ~CPU_RESETN;  // OJO: revisar que modulos nuestros tienen reset de active low.
	
	clk_wiz_0 inst(
		// Clock out ports  
		.clk_out1(CLK82MHZ),
		// Status and control signals               
		.reset(1'b0), 
		//.locked(locked),
		// Clock in ports
		.clk_in1(CLK100MHZ)
		);
	//Fill here
	
	//debouncer para los botones begin
	logic d_up, d_down, d_left, d_right, d_center; //señales ya debounceadas
	PB_Debouncer_counter Debouncer_BTNU(.clk(CLK82MHZ), .rst(hw_rst), .PB(BTNU), .PB_pressed_status(), .PB_pressed_pulse(), .PB_released_pulse(d_up));
    PB_Debouncer_counter Debouncer_BTND(.clk(CLK82MHZ), .rst(hw_rst), .PB(BTND), .PB_pressed_status(), .PB_pressed_pulse(), .PB_released_pulse(d_down));
    PB_Debouncer_counter Debouncer_BTNL(.clk(CLK82MHZ), .rst(hw_rst), .PB(BTNL), .PB_pressed_status(), .PB_pressed_pulse(), .PB_released_pulse(d_left));
    PB_Debouncer_counter Debouncer_BTNR(.clk(CLK82MHZ), .rst(hw_rst), .PB(BTNR), .PB_pressed_status(), .PB_pressed_pulse(), .PB_released_pulse(d_right));
    PB_Debouncer_counter Debouncer_BTNC(.clk(CLK82MHZ), .rst(hw_rst), .PB(BTNC), .PB_pressed_status(), .PB_pressed_pulse(), .PB_released_pulse(d_center));
    //notar que todos tienen reset active high
	
	//debouncer para los botones end
	
	//grid_cursor tiene reset active high ojo

	/************************* VGA ********************/
	logic [2:0] op;
	logic [2:0] pos_x;
	logic [1:0] pos_y;
	logic [15:0] op1, op2;
	logic [4:0] val;
	logic [15:0] canal_pantalla;
	grid_cursor grid_cursor_1 (.clk(CLK82MHZ), .rst(hw_rst), .restriction(),
                            .dir_up(d_up), .dir_down(d_down), .dir_left(d_left), .dir_right(d_right),
                            .pos_x(pos_x), .pos_y(pos_y), .val(val) );

    top calculadora_fsm (.rst(CPU_RESETN),.clk(CLK82MHZ), .val(val), .btnc(d_center) ,.op1(op1), .op2(op2), .op(op), .canal_pantalla(canal_pantalla));
    
	calculator_screen(
		.clk_vga(CLK82MHZ),
		.rst(hw_rst),
		.mode(SW[0]),
		.op(op),
		.pos_x(pos_x),
		.pos_y(pos_y),
		.op1(op1),
		.op2(op2),
		.input_screen(canal_pantalla),
		
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B));

endmodule

/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii de 8 bits
 *
 * @param hex_num		Corresponde al numero que se ingresa
 * @param ascii_conv	Corresponde a la representacion ascii
 *
 */
/*
hex_to_ascii hta1 (.hex_num(), .ascii_conv());
*/
module hex_to_ascii(
    input [3:0] hex_num,
	output logic[7:0] ascii_conv
    );
    always_comb begin
        case (hex_num)
            4'h0:   ascii_conv="0";
            4'h1:   ascii_conv="1";
            4'h2:   ascii_conv="2";
            4'h3:   ascii_conv="3";
            4'h4:   ascii_conv="4";
            4'h5:   ascii_conv="5";
            4'h6:   ascii_conv="6";
            4'h7:   ascii_conv="7";
            4'h8:   ascii_conv="8";
            4'h9:   ascii_conv="9";
            4'hA:   ascii_conv="A";
            4'hB:   ascii_conv="B";
            4'hC:   ascii_conv="C";
            4'hD:   ascii_conv="D";
            4'hE:   ascii_conv="E";
            4'hF:   ascii_conv="F";
        endcase
    end 
endmodule

module op_to_ascii(
    input [3:0] hex_num,
	output logic[7:0] ascii_conv
    );
    always_comb begin
        case (hex_num)
            4'h0:   ascii_conv="+";
            4'h1:   ascii_conv="*";
            4'h2:   ascii_conv="&";
            4'h5:   ascii_conv="|";

            default:   ascii_conv=" ";
        endcase
    end 
endmodule


/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii, pero binario, es decir,
 * si el numero ingresado es 4'hA, la salida debera sera la concatenacion
 * del string "1010" (cada caracter del string genera 8 bits).
 *
 * @param num		Corresponde al numero que se ingresa
 * @param bit_ascii	Corresponde a la representacion ascii pero del binario.
 *
 */
module hex_to_bit_ascii(
    input logic [3:0]num,
	output logic [4*8-1:0]bit_ascii
    );
    always_comb begin
        case (num)
            4'h0:   bit_ascii="0000";
            4'h1:   bit_ascii="0001";
            4'h2:   bit_ascii="0010";
            4'h3:   bit_ascii="0011";
            4'h4:   bit_ascii="0100";
            4'h5:   bit_ascii="0101";
            4'h6:   bit_ascii="0110";
            4'h7:   bit_ascii="0111";
            4'h8:   bit_ascii="1000";
            4'h9:   bit_ascii="1001";
            4'hA:   bit_ascii="1010";
            4'hB:   bit_ascii="1011";
            4'hC:   bit_ascii="1100";
            4'hD:   bit_ascii="1101";
            4'hE:   bit_ascii="1110";
            4'hF:   bit_ascii="1111";
        endcase
    end
endmodule

/**
 * @brief Este modulo es el encargado de dibujar en pantalla
 * la calculadora y todos sus componentes graficos
 *
 * @param clk_vga		:Corresponde al reloj con que funciona el VGA.
 * @param rst			:Corresponde al reset de todos los registros
 * @param mode			:'0' si se esta operando en decimal, '1' si esta operando hexadecimal
 * @param op			:La operacion matematica a realizar
 * @param pos_x			:Corresponde a la posicion X del cursor dentro de la grilla.
 * @param pos_y			:Corresponde a la posicion Y del cursor dentro de la grilla.
 * @param op1			:El operando 1 en formato hexadecimal.
 * @param op2			;El operando 2 en formato hexadecimal.
 * @param input_screen	:Lo que se debe mostrar en la pantalla de ingreso de la calculadora (en hexa)
 * @param VGA_HS		:Sincronismo Horizontal para el monitor VGA
 * @param VGA_VS		:Sincronismo Vertical para el monitor VGA
 * @param VGA_R			:Color Rojo para la pantalla VGA
 * @param VGA_G			:Color Verde para la pantalla VGA
 * @param VGA_B			:Color Azul para la pantalla VGA
 */
module calculator_screen(
	input logic clk_vga,
	input logic rst,
	input logic mode, //bcd or dec.
	input logic [2:0]op,
	input logic [2:0]pos_x,
	input logic [1:0]pos_y,
	input logic [15:0] op1,
	input logic [15:0] op2,
	input logic [15:0] input_screen,
	
	output logic VGA_HS,
	output logic VGA_VS,
	output logic [3:0] VGA_R,
	output logic [3:0] VGA_G,
	output logic [3:0] VGA_B
	);
	
	
	localparam CUADRILLA_XI = 		200; //normally 212
	localparam CUADRILLA_XF = 		CUADRILLA_XI + 600;
	
	localparam CUADRILLA_YI = 		250; //250
	localparam CUADRILLA_YF = 		CUADRILLA_YI + 400;
	
	
	logic [10:0]vc_visible,hc_visible;
	
	// MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	driver_vga_1024x768 driver_vga_1024x768(.clk_vga(clk_vga), .hs(VGA_HS), .vs(VGA_VS), .hc_visible(hc_visible), .vc_visible(vc_visible));
	/*************************** VGA DISPLAY ************************/
		
	logic [10:0]hc_template, vc_template;
	logic [2:0]matrix_x;
	logic [1:0]matrix_y;
	logic lines;
	
	template_6x4_600x400 #( .GRID_XI(CUADRILLA_XI), 
							.GRID_XF(CUADRILLA_XF), 
							.GRID_YI(CUADRILLA_YI), 
							.GRID_YF(CUADRILLA_YF)) 
    // MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!! //listo
	template_1(.clk(clk_vga), .hc(hc_visible), .vc(vc_visible), .matrix_x(matrix_x), .matrix_y(matrix_y), .lines(lines));
	
	logic [11:0]VGA_COLOR;
	
	logic text_sqrt_fg;
	logic text_sqrt_bg;

	logic [40:0]generic_fg;
	logic [40:0]generic_bg; //poner tantos como modulos haya	

	localparam GRID_X_OFFSET	= 20;
	localparam GRID_Y_OFFSET	= 10;
	
	localparam FIRST_SQRT_X = 212; //normally 400
	localparam FIRST_SQRT_Y = 250; //normally 200
	
	/*0*/
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), //FIRST_SQRT_X + 100*0 + GRID_X_OFFSET
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
                    ch_00(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("0"), 
                          .in_square(generic_bg[0]), 
                          .in_character(generic_fg[0]));
    /*1*/		      
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
                    ch_01(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("1"), 
                          .in_square(generic_bg[1]), 
                          .in_character(generic_fg[1]));
	/*2*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
                    ch_02(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("2"), 
                          .in_square(generic_bg[2]), 
                          .in_character(generic_fg[2]));                          
                          
    /*3*/                     
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
                    ch_03(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("3"), 
                          .in_square(generic_bg[3]), 
                          .in_character(generic_fg[3]));
	/*4*/	  
	
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
                    ch_04(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("4"), 
                          .in_square(generic_bg[4]), 
                          .in_character(generic_fg[4]));
    /*5*/                      
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y +100*2 + GRID_Y_OFFSET)) 
                    ch_05(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("5"), 
                          .in_square(generic_bg[5]), 
                          .in_character(generic_fg[5]));
	/*6*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
                    ch_06(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("6"), 
                          .in_square(generic_bg[6]), 
                          .in_character(generic_fg[6]));
	/*7*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
                    ch_07(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("7"), 
                          .in_square(generic_bg[7]), 
                          .in_character(generic_fg[7]));
	/*8*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_08(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("8"), 
                          .in_square(generic_bg[8]), 
                          .in_character(generic_fg[8]));
	/*9*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_09(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("9"), 
                          .in_square(generic_bg[9]), 
                          .in_character(generic_fg[9]));
	/*A*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_A(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("A"), 
                          .in_square(generic_bg[10]), 
                          .in_character(generic_fg[10]));
	/*B*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_B(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("B"), 
                          .in_square(generic_bg[11]), 
                          .in_character(generic_fg[11]));
    /*C*/                      
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
                    ch_C(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("C"), 
                          .in_square(generic_bg[12]), 
                          .in_character(generic_fg[12]));
	/*D*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
                    ch_D(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("D"), 
                          .in_square(generic_bg[13]), 
                          .in_character(generic_fg[13]));
	/*E*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
                    ch_E(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("E"), 
                          .in_square(generic_bg[14]), 
                          .in_character(generic_fg[14]));
    /*F*/                      
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
                    ch_F(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("F"), 
                          .in_square(generic_bg[15]), 
                          .in_character(generic_fg[15]));
	/*mult*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
                    ch_mult(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("*"), 
                          .in_square(generic_bg[16]), 
                          .in_character(generic_fg[16]));
	/*sum*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_sum(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("+"), 
                          .in_square(generic_bg[17]), 
                          .in_character(generic_fg[17]));
    /*and*/                      
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
                    ch_and(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("&"), 
                          .in_square(generic_bg[18]), 
                          .in_character(generic_fg[18]));
	/*resta*/
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
                    ch_rest(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("-"), 
                          .in_square(generic_bg[19]), 
                          .in_character(generic_fg[19]));
	/*or*/	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
                    ch_or(.clk(clk_vga), 
                          .rst(rst), 
                          .hc_visible(hc_visible), 
                          .vc_visible(vc_visible), 
                          .the_char("|"), 
                          .in_square(generic_bg[20]), 
                          .in_character(generic_fg[20]));

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
    logic flechaSwitch;
    logic [15:0]CharLinea1, CharLinea2;
    always_comb begin
    if(mode==1)begin CharLinea1="->";
                CharLinea2="  ";
                end
    else begin  CharLinea1="  ";
                           CharLinea2="->";
    end
    end
    /*->*/
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET -150 ), 
            .LINE_Y_LOCATION(FIRST_SQRT_Y + GRID_Y_OFFSET  -175 ), //-40 
            .MAX_CHARACTER_LINE(2), 
            .ancho_pixel(5), 
            .n(3)) 
            flechita(
            .clk(clk_vga), 
            .rst(rst), 
            .hc_visible(hc_visible), 
            .vc_visible(vc_visible), 
            .the_line(CharLinea1), 
            .in_square(generic_bg[21]), 
            .in_character(generic_fg[21]));
            
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET -150 ), 
                    .LINE_Y_LOCATION(FIRST_SQRT_Y + GRID_Y_OFFSET   -225), //-40 
                    .MAX_CHARACTER_LINE(2), 
                    .ancho_pixel(5), 
                    .n(3)) 
                    flechitaHex(
                    .clk(clk_vga), 
                    .rst(rst), 
                    .hc_visible(hc_visible), 
                    .vc_visible(vc_visible), 
                    .the_line(CharLinea2), 
                    .in_square(generic_bg[39]), 
                    .in_character(generic_fg[39]));		  
	/*EXE*/
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET - 30), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_exe(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("EXE"), 
                            .in_square(generic_bg[22]), 
                            .in_character(generic_fg[22]));
	/*CLR*/	
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET - 30), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_CLR(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("CLR"), 
                            .in_square(generic_bg[23]), 
                            .in_character(generic_fg[23]));
    /*CE*/                       
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(2), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_CE(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("CE"), 
                            .in_square(generic_bg[24]), 
                            .in_character(generic_fg[24]));
    /*OP1*/                       
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -250), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_OP1(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("OP1"), 
                            .in_square(generic_bg[25]), 
                            .in_character(generic_fg[25]));
    
    logic [7:0]ascii_conv_0, ascii_conv_1, ascii_conv_2, ascii_conv_3;
    
    hex_to_ascii h_t_a_op1_1 (.hex_num(op1[3:0]), .ascii_conv(ascii_conv_0));
    hex_to_ascii h_t_a_op1_2 (.hex_num(op1[7:4]), .ascii_conv(ascii_conv_1)); 
    hex_to_ascii h_t_a_op1_3 (.hex_num(op1[11:8]), .ascii_conv(ascii_conv_2)); 
    hex_to_ascii h_t_a_op1_4 (.hex_num(op1[15:12]), .ascii_conv(ascii_conv_3));         
     /*espacio OP1*/                       
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -250), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_espacio_OP1(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line({ascii_conv_0, ascii_conv_1, ascii_conv_2, ascii_conv_3}), 
                            .in_square(generic_bg[26]), 
                            .in_character(generic_fg[26]));
    /*OP2*/                        
    
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -200), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_OP2(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("OP2"), 
                            .in_square(generic_bg[27]), 
                            .in_character(generic_fg[27]));
    
    /*espacio OP2*/ 
    logic [7:0]ascii_conv_0_B, ascii_conv_1_B, ascii_conv_2_B, ascii_conv_3_B;
    
    hex_to_ascii h_t_a_op2_1 (.hex_num(op2[3:0]), .ascii_conv(ascii_conv_0_B));
    hex_to_ascii h_t_a_op2_2 (.hex_num(op2[7:4]), .ascii_conv(ascii_conv_1_B)); 
    hex_to_ascii h_t_a_op2_3 (.hex_num(op2[11:8]), .ascii_conv(ascii_conv_2_B)); 
    hex_to_ascii h_t_a_op2_4 (.hex_num(op2[15:12]), .ascii_conv(ascii_conv_3_B)); 
                           
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -200), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_espacio_OP2(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line({ascii_conv_0_B,ascii_conv_1_B,ascii_conv_2_B,ascii_conv_3_B}), 
                            .in_square(generic_bg[28]), 
                            .in_character(generic_fg[28]));
    /*OP*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -150 ), 
					.MAX_CHARACTER_LINE(2), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_OP(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("OP"), 
                            .in_square(generic_bg[29]), 
                            .in_character(generic_fg[29]));
    /*espacio OP*/                       
    
    logic [7:0]ascii_conv_0_OP;
    
    op_to_ascii op_to_ascii_1(.hex_num(op[2:0]), .ascii_conv(ascii_conv_0_OP));
    
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -150), 
					.MAX_CHARACTER_LINE(1), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_espacio_OP(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line(ascii_conv_0_OP), 
                            .in_square(generic_bg[30]), 
                            .in_character(generic_fg[30]));
    /*result 1*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET ), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -75), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_result_1(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("0000"), 
                            .in_square(generic_bg[31]), 
                            .in_character(generic_fg[31]));
    /*result 2*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET +500), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -75), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_result_2(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("0000"), 
                            .in_square(generic_bg[32]), 
                            .in_character(generic_fg[32]));
    /*result 3*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET ), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -75), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_result_3(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("0000"), 
                            .in_square(generic_bg[33]), 
                            .in_character(generic_fg[33]));
    /*result 4*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET +50), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -75), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_result_4(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("0000"), 
                            .in_square(generic_bg[34]), 
                            .in_character(generic_fg[34]));
     /*Hex*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET -75), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -225), 
					.MAX_CHARACTER_LINE(6), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_hex(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("Hex"), 
                            .in_square(generic_bg[35]), 
                            .in_character(generic_fg[35]));
     /*Dec*/                        
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET -75), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -175), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_dec(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("Dec"), 
                            .in_square(generic_bg[36]), 
                            .in_character(generic_fg[36]));     
    
    /*Pantalla*/                
    logic [7:0]ascii_conv_0_P, ascii_conv_1_P, ascii_conv_2_P, ascii_conv_3_P;
    logic [15:0] canal_pantalla;
    assign canal_pantalla = input_screen;
    hex_to_ascii hex_to_p_0 (.hex_num(canal_pantalla[3:0]), .ascii_conv(ascii_conv_0_P));
    hex_to_ascii hex_to_p_1 (.hex_num(canal_pantalla[7:4]), .ascii_conv(ascii_conv_1_P)); 
    hex_to_ascii hex_to_p_2(.hex_num(canal_pantalla[11:8]), .ascii_conv(ascii_conv_2_P)); 
    hex_to_ascii hex_to_p_3(.hex_num(canal_pantalla[15:12]), .ascii_conv(ascii_conv_3_P));  
           
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET -200), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_pantalla(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line({ascii_conv_3_P,ascii_conv_2_P,ascii_conv_1_P, ascii_conv_0_P}), 
                            .in_square(generic_bg[37]), 
                            .in_character(generic_fg[37]));
                            
    /*ELO212*/                   //canal pantalla -> hex to ascii -> show one line      
    show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*4 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(6), 
					.ancho_pixel(5), 
					.n(3)) 
                    line_ELO212(	.clk(clk_vga), 
                            .rst(rst), 
                            .hc_visible(hc_visible), 
                            .vc_visible(vc_visible), 
                            .the_line("ELO212"), 
                            .in_square(generic_bg[38]), 
                            .in_character(generic_fg[38])); 
	/*
	Estos son de ejemplo
	//----------------------------------------
	hello_world_text_square  #(.MAX_CHARACTER_LINE(10),
	                           .MAX_NUMBER_LINES(2))
	                         m_hw(.clk(clk_vga), 
									.rst(1'b0), 
									.hc_visible(hc_visible), 
									.vc_visible(vc_visible), 
									.in_square(text_sqrt_bg), 
									.in_character(text_sqrt_fg));

	
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_00(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("0"), 
		  .in_square(generic_bg[0]), 
		  .in_character(generic_fg[0]));
	
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
	exe(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("Exe"), 
			.in_square(generic_bg[1]), 
			.in_character(generic_fg[1]));
       //ESTOS SON LOS DE EJEMPLO
     //  -------------------------------------------------------------------
	*/
	logic draw_cursor = (pos_x == matrix_x) && (pos_y == matrix_y);
	
	
	localparam COLOR_BLUE 		= 12'h00F;
	localparam COLOR_YELLOW 	= 12'hFF0;
	localparam COLOR_RED		= 12'hF00;
	localparam COLOR_BLACK		= 12'h000;
	localparam COLOR_WHITE		= 12'hFFF;
	localparam COLOR_CYAN		= 12'h0FF;
	localparam COLOR_GREY       = 12'hDDD;
	
	always@(*)
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			
			if(text_sqrt_fg)
				VGA_COLOR = COLOR_RED; //normally red
			else if (text_sqrt_bg)
				VGA_COLOR = COLOR_YELLOW;
			else if(|generic_fg)
				VGA_COLOR = COLOR_BLACK;
			else if(generic_bg)begin //color de fondo de los cuadros de texto
			     if(draw_cursor && (hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
			         VGA_COLOR = COLOR_CYAN;
			     else
                      VGA_COLOR = COLOR_WHITE;                                           //{3'h7, {2'b0, matrix_x} + {3'b00, matrix_y}, 4'h3} Degrade
			    end
			//si esta dentro de la grilla.
			else if((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
				if(lines)//lineas negras de la grilla
					VGA_COLOR = COLOR_BLACK;
				else if (draw_cursor) //el cursor
					VGA_COLOR = COLOR_CYAN;
				
				else
					VGA_COLOR = COLOR_WHITE;//{3'h7, {2'b0, matrix_x} + {3'b00, matrix_y}, 4'h3};// el fondo de la grilla.
			else
				VGA_COLOR = COLOR_GREY;//el fondo de la pantalla
		end
		else
			VGA_COLOR = COLOR_BLACK;//esto es necesario para no poner en riesgo la pantalla.

	assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;
endmodule



/**
 * @brief Este modulo cambia los ceros a la izquierda de un numero, por espacios
 * @param value			:Corresponde al valor (en hexa o decimal) al que se le desea hacer el padding.
 * @param no_pading		:Corresponde al equivalente ascii del value includos los ceros a la izquierda
 * @param padding		:Corresponde al equivalente ascii del value, pero sin los ceros a la izquierda.
 */

module space_padding(
	input [19:0] value,
	input [8*6 -1:0]no_pading,
	
	output logic [8*6 -1:0]padding);
	
	
endmodule
