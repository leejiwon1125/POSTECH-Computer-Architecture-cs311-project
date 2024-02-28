// FuncCodes
`define FUNC_ADD    4'b0000
`define FUNC_SUB    4'b0001
`define FUNC_ID     4'b0010
`define FUNC_NOT    4'b0011
`define FUNC_AND    4'b0100
`define FUNC_OR     4'b0101
`define FUNC_NAND   4'b0110
`define FUNC_NOR    4'b0111
`define FUNC_XOR    4'b1000
`define FUNC_XNOR   4'b1001
`define FUNC_LLS    4'b1010
`define FUNC_LRS    4'b1011
`define FUNC_ALS    4'b1100
`define FUNC_ARS    4'b1101
`define FUNC_TCP    4'b1110
`define FUNC_ZERO   4'b1111


module mux_16to1(
    input wire [15:0] data_input,
    input wire [3:0] select_input,
    output wire out
);
    //다시다시닷
    reg mux_output;//case문 쓰려고...
    
    always @*
        case (select_input)
            4'b0000: mux_output = data_input[0];
            4'b0001: mux_output = data_input[1];
            4'b0010: mux_output = data_input[2];
            4'b0011: mux_output = data_input[3];
            4'b0100: mux_output = data_input[4];
            4'b0101: mux_output = data_input[5];
            4'b0110: mux_output = data_input[6];
            4'b0111: mux_output = data_input[7];
            4'b1000: mux_output = data_input[8];
            4'b1001: mux_output = data_input[9];
            4'b1010: mux_output = data_input[10];
            4'b1011: mux_output = data_input[11];
            4'b1100: mux_output = data_input[12];
            4'b1101: mux_output = data_input[13];
            4'b1110: mux_output = data_input[14];
            4'b1111: mux_output = data_input[15];
            default: mux_output = 16'hXXXX;
        endcase
    
    assign out = mux_output;
    
endmodule



module func_add(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C,
    output wire OVERFLOW
    );
    
    assign C = A+B;
   
    assign OVERFLOW = ((A[15] == B[15]) && (C[15] != A[15]));;
    // && (temp[15] != A[15]));
    //((~A[15]) && (~B[15]) &&(C[15]))||((A[15]) && (B[15]) &&(~C[15]));
    //((a+b)<0)&&(a>0)&&(b>0) || ((a+b)>0)&&(a<0)&&(b<0); 
    
    
endmodule

module func_sub(
   
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C,
    output wire OVERFLOW
    );
    func_add a (A,~B+1,C,OVERFLOW);

endmodule

module func_id(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
assign C = A;

endmodule

module func_not(
   
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );

    not(C[0],A[0]);
    not(C[1], A[1]);
    not(C[2], A[2]);
    not(C[3], A[3]);
    not(C[4], A[4]);
    not(C[5], A[5]);
    not(C[6], A[6]);
    not(C[7], A[7]);
    not(C[8], A[8]);
    not(C[9], A[9]);
    not(C[10], A[10]);
    not(C[11], A[11]);
    not(C[12], A[12]);
    not(C[13], A[13]);
    not(C[14], A[14]);
    not(C[15], A[15]);

endmodule

module func_and(

    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    and(C[0],A[0],B[0]);
    and(C[1], A[1], B[1]);
    and(C[2], A[2], B[2]);
    and(C[3], A[3], B[3]);
    and(C[4], A[4], B[4]);
    and(C[5], A[5], B[5]);
    and(C[6], A[6], B[6]);
    and(C[7], A[7], B[7]);
    and(C[8], A[8], B[8]);
    and(C[9], A[9], B[9]);
    and(C[10], A[10], B[10]);
    and(C[11], A[11], B[11]);
    and(C[12], A[12], B[12]);
    and(C[13], A[13], B[13]);
    and(C[14], A[14], B[14]);
    and(C[15], A[15], B[15]);

endmodule

module func_or(
  
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    or(C[0],A[0],B[0]);
    or(C[1], A[1], B[1]);
    or(C[2], A[2], B[2]);
    or(C[3], A[3], B[3]);
    or(C[4], A[4], B[4]);
    or(C[5], A[5], B[5]);
    or(C[6], A[6], B[6]);
    or(C[7], A[7], B[7]);
    or(C[8], A[8], B[8]);
    or(C[9], A[9], B[9]);
    or(C[10], A[10], B[10]);
    or(C[11], A[11], B[11]);
    or(C[12], A[12], B[12]);
    or(C[13], A[13], B[13]);
    or(C[14], A[14], B[14]);
    or(C[15], A[15], B[15]);

endmodule

module func_nand(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    nand(C[0],A[0],B[0]);
    nand(C[1], A[1], B[1]);
    nand(C[2], A[2], B[2]);
    nand(C[3], A[3], B[3]);
    nand(C[4], A[4], B[4]);
    nand(C[5], A[5], B[5]);
    nand(C[6], A[6], B[6]);
    nand(C[7], A[7], B[7]);
    nand(C[8], A[8], B[8]);
    nand(C[9], A[9], B[9]);
    nand(C[10], A[10], B[10]);
    nand(C[11], A[11], B[11]);
    nand(C[12], A[12], B[12]);
    nand(C[13], A[13], B[13]);
    nand(C[14], A[14], B[14]);
    nand(C[15], A[15], B[15]);

endmodule

module func_nor(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    nor(C[0],A[0],B[0]);
    nor(C[1], A[1], B[1]);
    nor(C[2], A[2], B[2]);
    nor(C[3], A[3], B[3]);
    nor(C[4], A[4], B[4]);
    nor(C[5], A[5], B[5]);
    nor(C[6], A[6], B[6]);
    nor(C[7], A[7], B[7]);
    nor(C[8], A[8], B[8]);
    nor(C[9], A[9], B[9]);
    nor(C[10], A[10], B[10]);
    nor(C[11], A[11], B[11]);
    nor(C[12], A[12], B[12]);
    nor(C[13], A[13], B[13]);
    nor(C[14], A[14], B[14]);
    nor(C[15], A[15], B[15]);

endmodule

module func_xor(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    xor(C[0],A[0],B[0]);
    xor(C[1], A[1], B[1]);
    xor(C[2], A[2], B[2]);
    xor(C[3], A[3], B[3]);
    xor(C[4], A[4], B[4]);
    xor(C[5], A[5], B[5]);
    xor(C[6], A[6], B[6]);
    xor(C[7], A[7], B[7]);
    xor(C[8], A[8], B[8]);
    xor(C[9], A[9], B[9]);
    xor(C[10], A[10], B[10]);
    xor(C[11], A[11], B[11]);
    xor(C[12], A[12], B[12]);
    xor(C[13], A[13], B[13]);
    xor(C[14], A[14], B[14]);
    xor(C[15], A[15], B[15]);

endmodule

module func_xnor(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    xnor(C[0],A[0],B[0]);
    xnor(C[1], A[1], B[1]);
    xnor(C[2], A[2], B[2]);
    xnor(C[3], A[3], B[3]);
    xnor(C[4], A[4], B[4]);
    xnor(C[5], A[5], B[5]);
    xnor(C[6], A[6], B[6]);
    xnor(C[7], A[7], B[7]);
    xnor(C[8], A[8], B[8]);
    xnor(C[9], A[9], B[9]);
    xnor(C[10], A[10], B[10]);
    xnor(C[11], A[11], B[11]);
    xnor(C[12], A[12], B[12]);
    xnor(C[13], A[13], B[13]);
    xnor(C[14], A[14], B[14]);
    xnor(C[15], A[15], B[15]);

endmodule

module func_lls(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C[15]=A[14];
    assign C[14:1]=A[13:0];
    assign C[0]=0;

endmodule

module func_lrs(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C[15] = 0;
    assign C[14:0] = A[15:1];

endmodule

module func_als(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C[15]=A[14];
    assign C[14:1]=A[13:0];
    assign C[0]=0;

endmodule

module func_ars(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C[15] = A[15];
    assign C[14:0] = A[15:1];

endmodule

module func_tcp(
   
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C = ~A + 1;
      
endmodule

module func_zero(
    
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] C
    );
    
    assign C = 0;
    
endmodule

module alu(
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [3:0] FuncCode,
    output wire [15:0] C,
    output wire OverflowFlag
    );
   
    wire [1:0] temp_overflow;
    wire [15:0] temp_C [15:0];
    
    func_add    f0(A, B, temp_C[0], temp_overflow[0]);
    func_sub    f1(A, B, temp_C[1], temp_overflow[1]);
    func_id     f2(A, B, temp_C[2]);
    func_not    f3(A, B, temp_C[3]);
    func_and    f4(A, B, temp_C[4]);
    func_or     f5(A, B, temp_C[5]);
    func_nand   f6(A, B, temp_C[6]);
    func_nor    f7(A, B, temp_C[7]);
    func_xor    f8(A, B, temp_C[8]);
    func_xnor   f9(A, B, temp_C[9]);
    func_lls    f10(A, B, temp_C[10]);
    func_lrs    f11(A, B, temp_C[11]);
    func_als    f12(A, B, temp_C[12]);
    func_ars    f13(A, B, temp_C[13]);
    func_tcp    f14(A, B, temp_C[14]);
    func_zero   f15(A, B, temp_C[15]);
    
    mux_16to1 mux0({temp_C[15][0], temp_C[14][0], temp_C[13][0], temp_C[12][0], temp_C[11][0], temp_C[10][0], temp_C[9][0], temp_C[8][0],
                    temp_C[7][0], temp_C[6][0], temp_C[5][0], temp_C[4][0], temp_C[3][0], temp_C[2][0], temp_C[1][0], temp_C[0][0]}, FuncCode, C[0]); 
                    
    mux_16to1 mux1({temp_C[15][1], temp_C[14][1], temp_C[13][1], temp_C[12][1], temp_C[11][1], temp_C[10][1], temp_C[9][1], temp_C[8][1],
                    temp_C[7][1], temp_C[6][1], temp_C[5][1], temp_C[4][1], temp_C[3][1], temp_C[2][1], temp_C[1][1], temp_C[0][1]}, FuncCode, C[1]);
    
    mux_16to1 mux2({temp_C[15][2], temp_C[14][2], temp_C[13][2], temp_C[12][2], temp_C[11][2], temp_C[10][2], temp_C[9][2], temp_C[8][2],
                    temp_C[7][2], temp_C[6][2], temp_C[5][2], temp_C[4][2], temp_C[3][2], temp_C[2][2], temp_C[1][2], temp_C[0][2]}, FuncCode, C[2]);

    mux_16to1 mux3({temp_C[15][3], temp_C[14][3], temp_C[13][3], temp_C[12][3], temp_C[11][3], temp_C[10][3], temp_C[9][3], temp_C[8][3],
                    temp_C[7][3], temp_C[6][3], temp_C[5][3], temp_C[4][3], temp_C[3][3], temp_C[2][3], temp_C[1][3], temp_C[0][3]}, FuncCode, C[3]);
    
    mux_16to1 mux4({temp_C[15][4], temp_C[14][4], temp_C[13][4], temp_C[12][4], temp_C[11][4], temp_C[10][4], temp_C[9][4], temp_C[8][4],
                    temp_C[7][4], temp_C[6][4], temp_C[5][4], temp_C[4][4], temp_C[3][4], temp_C[2][4], temp_C[1][4], temp_C[0][4]}, FuncCode, C[4]);
    
    mux_16to1 mux5({temp_C[15][5], temp_C[14][5], temp_C[13][5], temp_C[12][5], temp_C[11][5], temp_C[10][5], temp_C[9][5], temp_C[8][5],
                    temp_C[7][5], temp_C[6][5], temp_C[5][5], temp_C[4][5], temp_C[3][5], temp_C[2][5], temp_C[1][5], temp_C[0][5]}, FuncCode, C[5]);
    
    mux_16to1 mux6({temp_C[15][6], temp_C[14][6], temp_C[13][6], temp_C[12][6], temp_C[11][6], temp_C[10][6], temp_C[9][6], temp_C[8][6],
                    temp_C[7][6], temp_C[6][6], temp_C[5][6], temp_C[4][6], temp_C[3][6], temp_C[2][6], temp_C[1][6], temp_C[0][6]}, FuncCode, C[6]);
    
    mux_16to1 mux7({temp_C[15][7], temp_C[14][7], temp_C[13][7], temp_C[12][7], temp_C[11][7], temp_C[10][7], temp_C[9][7], temp_C[8][7],
                    temp_C[7][7], temp_C[6][7], temp_C[5][7], temp_C[4][7], temp_C[3][7], temp_C[2][7], temp_C[1][7], temp_C[0][7]}, FuncCode, C[7]);
             
    mux_16to1 mux8({temp_C[15][8], temp_C[14][8], temp_C[13][8], temp_C[12][8], temp_C[11][8], temp_C[10][8], temp_C[9][8], temp_C[8][8],
                    temp_C[7][8], temp_C[6][8], temp_C[5][8], temp_C[4][8], temp_C[3][8], temp_C[2][8], temp_C[1][8], temp_C[0][8]}, FuncCode, C[8]);

    mux_16to1 mux9({temp_C[15][9], temp_C[14][9], temp_C[13][9], temp_C[12][9], temp_C[11][9], temp_C[10][9], temp_C[9][9], temp_C[8][9],
                    temp_C[7][9], temp_C[6][9], temp_C[5][9], temp_C[4][9], temp_C[3][9], temp_C[2][9], temp_C[1][9], temp_C[0][9]}, FuncCode, C[9]);

    mux_16to1 mux10({temp_C[15][10], temp_C[14][10], temp_C[13][10], temp_C[12][10], temp_C[11][10], temp_C[10][10], temp_C[9][10], temp_C[8][10],
                    temp_C[7][10], temp_C[6][10], temp_C[5][10], temp_C[4][10], temp_C[3][10], temp_C[2][10], temp_C[1][10], temp_C[0][10]}, FuncCode, C[10]);

    mux_16to1 mux11({temp_C[15][11], temp_C[14][11], temp_C[13][11], temp_C[12][11], temp_C[11][11], temp_C[10][11], temp_C[9][11], temp_C[8][11],
                    temp_C[7][11], temp_C[6][11], temp_C[5][11], temp_C[4][11], temp_C[3][11], temp_C[2][11], temp_C[1][11], temp_C[0][11]}, FuncCode, C[11]);

    mux_16to1 mux12({temp_C[15][12], temp_C[14][12], temp_C[13][12], temp_C[12][12], temp_C[11][12], temp_C[10][12], temp_C[9][12], temp_C[8][12],
                    temp_C[7][12], temp_C[6][12], temp_C[5][12], temp_C[4][12], temp_C[3][12], temp_C[2][12], temp_C[1][12], temp_C[0][12]}, FuncCode, C[12]);

    mux_16to1 mux13({temp_C[15][13], temp_C[14][13], temp_C[13][13], temp_C[12][13], temp_C[11][13], temp_C[10][13], temp_C[9][13], temp_C[8][13],
                    temp_C[7][13], temp_C[6][13], temp_C[5][13], temp_C[4][13], temp_C[3][13], temp_C[2][13], temp_C[1][13], temp_C[0][13]}, FuncCode, C[13]);

    mux_16to1 mux14({temp_C[15][14], temp_C[14][14], temp_C[13][14], temp_C[12][14], temp_C[11][14], temp_C[10][14], temp_C[9][14], temp_C[8][14],
                    temp_C[7][14], temp_C[6][14], temp_C[5][14], temp_C[4][14], temp_C[3][14], temp_C[2][14], temp_C[1][14], temp_C[0][14]}, FuncCode, C[14]);

    mux_16to1 mux15({temp_C[15][15], temp_C[14][15], temp_C[13][15], temp_C[12][15], temp_C[11][15], temp_C[10][15], temp_C[9][15], temp_C[8][15],
                    temp_C[7][15], temp_C[6][15], temp_C[5][15], temp_C[4][15], temp_C[3][15], temp_C[2][15], temp_C[1][15], temp_C[0][15]}, FuncCode, C[15]);
            
            
    assign OverflowFlag = (temp_overflow[0] | temp_overflow[1])& (~FuncCode[3])& (~FuncCode[2])& (~FuncCode[1]);
    
endmodule