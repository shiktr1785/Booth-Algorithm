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

reg n1orn2z_reg1;
reg n1orn2z_reg2;
reg n1orn2z_reg3;
reg n1orn2z_reg4;
reg n1orn2z_reg5;
reg n1orn2z_reg6;
reg n1orn2z_reg7;

reg [10:0] p1_reg2;
reg [10:0] p2_reg2;
reg [10:0] p3_reg2;
reg [10:0] p4_reg2;
reg [10:0] p5_reg2;
reg [10:0] p6_reg2;
reg [10:0] p7_reg2;
reg [10:0] p8_reg2;

reg [12:0] s11_reg3;
reg [12:0] s12_reg3;
reg [12:0] s13_reg3;
reg [12:0] s14_reg3;

reg [12:0] s11_reg4;
reg [12:0] s12_reg4;
reg [12:0] s13_reg4;
reg [12:0] s14_reg4;

reg [7:0] s21a_reg4;
reg [7:0] s22a_reg4;

reg [14:0] s21_reg5;
reg [14:0] s22_reg5;
reg [14:0] s21_reg6;
reg [14:0] s22_reg6;

reg [8:0] s31a_reg6;
reg [17:0] s31_reg7;
reg [18:0] result;

always @(n1)
begin
    if (n1[10] == 1'b0)
        n1_mag = n1[10:0];
    else
        n1_mag = ~n1[10:0] + 1;
end

always @(n2)
begin
    if (n2[7] == 1'b0)
        n2_mag = n2[7:0];
    else
        n2_mag = ~n2[7:0] + 1;
end

assign n1orn2z = ((n1 == 11'b0)||(n2 == 7'b0)) ? 1'b1 : 1'b0;  //if n1 or n2 is zero, make final result +0

assign p1 = n1_mag[10:0] & {11{n2_mag[0]}};   //compute the partial product, multiply n1 by n2[0], etc
assign p2 = n1_mag[10:0] & {11{n2_mag[1]}};
assign p3 = n1_mag[10:0] & {11{n2_mag[2]}};
assign p4 = n1_mag[10:0] & {11{n2_mag[3]}};
assign p5 = n1_mag[10:0] & {11{n2_mag[4]}};
assign p6 = n1_mag[10:0] & {11{n2_mag[5]}};
assign p7 = n1_mag[10:0] & {11{n2_mag[6]}};
assign p8 = n1_mag[10:0] & {11{n2_mag[7]}};

always @(posedge clk)       //these are the first pipeline register at clk (1) stage.

begin
    p1_reg1 <= p1;
    p2_reg1 <= p2;
    p3_reg1 <= p3;
    p4_reg1 <= p4;
    p5_reg1 <= p5;
    p6_reg1 <= p6;
    p7_reg1 <= p7;
    p8_reg1 <= p8;

    n1_reg1 <= n1[10];      //preserve sign bit and the status
    n2_reg1 <= n2[7];
    n1orn2z_reg1 <= n1orn2z;        //whether result is zero or not
end

//p1_reg1, etc means p1, etc are registered at positive edge of clk (1), clk (2), etc.

assign s11a[6:0] = p1_reg1[6:1] + p2_reg1[5:0];     //LSBs are added here after left shifting p1_reg1 by one bit
assign s12a[6:0] = p3_reg1[6:1] + p4_reg1[5:0];
assign s13a[6:0] = p5_reg1[6:1] + p6_reg1[5:0];
assign s14a[6:0] = p7_reg1[6:1] + p8_reg1[5:0];     //left shift are taken care of for p1, p3, p5, and p7
                                                    //p1_reg1[0], etc will be processed at the clk(2)
                                                    //s11a[6], etc are the carry bits.

always @(posedge clk)
begin
    s11a_reg2 <= s11a;      //store the LSB partial sums.
    s12a_reg2 <= s12a;
    s13a_reg2 <= s13a;
    s14a_reg2 <= s14a;
    
    p1_reg2[10:7] <= p1_reg1[10:7];     //store the MSB of partial products.
    p2_reg2[10:6] <= p2_reg1[10:6];
    p3_reg2[10:7] <= p3_reg1[10:7];
    p4_reg2[10:6] <= p4_reg1[10:6];
    p5_reg2[10:7] <= p5_reg1[10:7];
    p6_reg2[10:6] <= p6_reg1[10:6];
    p7_reg2[10:7] <= p7_reg1[10:7];
    p8_reg2[10:6] <= p8_reg1[10:6];

    p1_reg2[0] <= p1_reg1[0];       //store 0th bit since it is not processed
    p3_reg2[0] <= p3_reg1[0];
    p5_reg2[0] <= p5_reg1[0];
    p7_reg2[0] <= p7_reg1[0];

    n1_reg2 <= n1_reg1;     //store sign bit and zero status
    n2_reg2 <= n2_reg1;
    n1orn2z_reg2 <= n1orn2z_reg1;
end

//MSB is added here along with carry


endmodule