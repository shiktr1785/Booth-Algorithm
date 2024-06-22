module mult11s8s (
    clk,        //Declare the design module
    n1,
    n2,
    result
);

input clk;      //Declare the input and output ports
input [10:0] n1;
input [7:0] n2;
output [18:0] result;

//Declare Combination Circuit
wire n1orn2z;
wire [10:0] p1;
wire [10:0] p2;
wire [10:0] p3;
wire [10:0] p4;
wire [10:0] p5;
wire [10:0] p6;
wire [10:0] p7;
wire [10:0] p8;

wire [6:0] s11a;
wire [6:0] s12a;
wire [6:0] s13a;
wire [6:0] s14a;

wire [5:0] s11b;
wire [5:0] s12b;
wire [5:0] s13b;
wire [5:0] s14b;

wire [12:0] s11;
wire [12:0] s12;
wire [12:0] s13;
wire [12:0] s14;

wire [7:0] s21a;
wire [7:0] s22a;

wire [6:0] s21b;
wire [6:0] s22b;

wire [14:0] s21;
wire [14:0] s22;

wire [8:0] s31a;
wire [7:0] s31b;

wire [17:0] s31;
wire        res_sign;
wire [18:0] res;

reg [10:0] n1_mag;
reg [7:0] n2_mag;
reg [10:0] p1_reg1;
reg [10:0] p2_reg1;
reg [10:0] p3_reg1;
reg [10:0] p4_reg1;
reg [10:0] p5_reg1;
reg [10:0] p6_reg1;
reg [10:0] p7_reg1;
reg [10:0] p8_reg1;

reg [6:0] s11a_reg2;
reg [6:0] s12a_reg2;
reg [6:0] s13a_reg2;
reg [6:0] s14a_reg2;

reg n1_reg1;
reg n1_reg2;
reg n1_reg3;
reg n1_reg4;
reg n1_reg5;
reg n1_reg6;
reg n1_reg7;

reg n2_reg1;
reg n2_reg2;
reg n2_reg3;
reg n2_reg4;
reg n2_reg5;
reg n2_reg6;
reg n2_reg7;


endmodule