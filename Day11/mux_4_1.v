module mux_4_1(
input [1:0] sel,
input i0,i1,i2,i3,
output y);
wire not0,not1,and0,and1,and2,and3,and4,and5,and6,and7,or0,or1;
not (not0,sel[0]);
not (not1,sel[1]);
and (and0,not0,not1);
and (and1,sel[0],not1);
and (and2,not0,sel[1]);
and (and3,sel[0],sel[1]);
and (and4,and0,i0);
and (and5,and1,i1);
and (and6,and2,i2);
and (and7,and3,i3);
or (or0 , and5, and4);
or (or1 , or0, and6);
or (y , or1, and7);
endmodule
