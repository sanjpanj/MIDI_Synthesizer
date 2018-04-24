/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 24 14:36:26 2018
/////////////////////////////////////////////////////////////


module APB_slave ( clk, n_rst, PSEL, PENABLE, PWRITE, PWDATA, MIDI_Data, 
        data_ready );
  input [31:0] PWDATA;
  output [31:0] MIDI_Data;
  input clk, n_rst, PSEL, PENABLE, PWRITE;
  output data_ready;
  wire   N28, N29, N30, N32, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43,
         N44, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57,
         N58, N59, N60, N61, N62, N63, N64, N65, n4, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19;
  wire   [2:0] state;
  wire   [2:0] nxt_state;

  DFFSR \state_reg[0]  ( .D(nxt_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[0]) );
  LATCH \nxt_state_reg[1]  ( .CLK(N28), .D(N30), .Q(nxt_state[1]) );
  DFFSR \state_reg[1]  ( .D(nxt_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[1]) );
  LATCH \nxt_state_reg[2]  ( .CLK(N28), .D(n19), .Q(nxt_state[2]) );
  DFFSR \state_reg[2]  ( .D(nxt_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[2]) );
  LATCH \midiout_reg[31]  ( .CLK(n18), .D(N65), .Q(MIDI_Data[31]) );
  LATCH \midiout_reg[30]  ( .CLK(n17), .D(N64), .Q(MIDI_Data[30]) );
  LATCH \midiout_reg[29]  ( .CLK(n18), .D(N63), .Q(MIDI_Data[29]) );
  LATCH \midiout_reg[28]  ( .CLK(n17), .D(N62), .Q(MIDI_Data[28]) );
  LATCH \midiout_reg[27]  ( .CLK(n17), .D(N61), .Q(MIDI_Data[27]) );
  LATCH \midiout_reg[26]  ( .CLK(n18), .D(N60), .Q(MIDI_Data[26]) );
  LATCH \midiout_reg[25]  ( .CLK(n17), .D(N59), .Q(MIDI_Data[25]) );
  LATCH \midiout_reg[24]  ( .CLK(n18), .D(N58), .Q(MIDI_Data[24]) );
  LATCH \midiout_reg[23]  ( .CLK(n17), .D(N57), .Q(MIDI_Data[23]) );
  LATCH \midiout_reg[22]  ( .CLK(n18), .D(N56), .Q(MIDI_Data[22]) );
  LATCH \midiout_reg[21]  ( .CLK(n17), .D(N55), .Q(MIDI_Data[21]) );
  LATCH \midiout_reg[20]  ( .CLK(n18), .D(N54), .Q(MIDI_Data[20]) );
  LATCH \midiout_reg[19]  ( .CLK(n17), .D(N53), .Q(MIDI_Data[19]) );
  LATCH \midiout_reg[18]  ( .CLK(n17), .D(N52), .Q(MIDI_Data[18]) );
  LATCH \midiout_reg[17]  ( .CLK(n17), .D(N51), .Q(MIDI_Data[17]) );
  LATCH \midiout_reg[16]  ( .CLK(n17), .D(N50), .Q(MIDI_Data[16]) );
  LATCH \midiout_reg[15]  ( .CLK(n17), .D(N49), .Q(MIDI_Data[15]) );
  LATCH \midiout_reg[14]  ( .CLK(n17), .D(N48), .Q(MIDI_Data[14]) );
  LATCH \midiout_reg[13]  ( .CLK(n17), .D(N47), .Q(MIDI_Data[13]) );
  LATCH \midiout_reg[12]  ( .CLK(n17), .D(N46), .Q(MIDI_Data[12]) );
  LATCH \midiout_reg[11]  ( .CLK(n17), .D(N45), .Q(MIDI_Data[11]) );
  LATCH \midiout_reg[10]  ( .CLK(n17), .D(N44), .Q(MIDI_Data[10]) );
  LATCH \midiout_reg[9]  ( .CLK(n17), .D(N43), .Q(MIDI_Data[9]) );
  LATCH \midiout_reg[8]  ( .CLK(n18), .D(N42), .Q(MIDI_Data[8]) );
  LATCH \midiout_reg[7]  ( .CLK(n18), .D(N41), .Q(MIDI_Data[7]) );
  LATCH \midiout_reg[6]  ( .CLK(n18), .D(N40), .Q(MIDI_Data[6]) );
  LATCH \midiout_reg[5]  ( .CLK(n18), .D(N39), .Q(MIDI_Data[5]) );
  LATCH \midiout_reg[4]  ( .CLK(n18), .D(N38), .Q(MIDI_Data[4]) );
  LATCH \midiout_reg[3]  ( .CLK(n18), .D(N37), .Q(MIDI_Data[3]) );
  LATCH \midiout_reg[2]  ( .CLK(n18), .D(N36), .Q(MIDI_Data[2]) );
  LATCH \midiout_reg[1]  ( .CLK(n18), .D(N35), .Q(MIDI_Data[1]) );
  LATCH \midiout_reg[0]  ( .CLK(n18), .D(N34), .Q(MIDI_Data[0]) );
  LATCH d_ready_reg ( .CLK(N28), .D(N32), .Q(data_ready) );
  LATCH \nxt_state_reg[0]  ( .CLK(N28), .D(N29), .Q(nxt_state[0]) );
  AND2X2 U6 ( .A(PWDATA[31]), .B(n19), .Y(N65) );
  AND2X2 U7 ( .A(PWDATA[30]), .B(n19), .Y(N64) );
  AND2X2 U8 ( .A(PWDATA[29]), .B(n19), .Y(N63) );
  AND2X2 U9 ( .A(PWDATA[28]), .B(n19), .Y(N62) );
  AND2X2 U10 ( .A(PWDATA[27]), .B(n19), .Y(N61) );
  AND2X2 U11 ( .A(PWDATA[26]), .B(n19), .Y(N60) );
  AND2X2 U12 ( .A(PWDATA[25]), .B(n19), .Y(N59) );
  AND2X2 U13 ( .A(PWDATA[24]), .B(n19), .Y(N58) );
  AND2X2 U14 ( .A(PWDATA[23]), .B(n19), .Y(N57) );
  AND2X2 U15 ( .A(PWDATA[22]), .B(n19), .Y(N56) );
  AND2X2 U16 ( .A(PWDATA[21]), .B(n19), .Y(N55) );
  AND2X2 U17 ( .A(PWDATA[20]), .B(n19), .Y(N54) );
  AND2X2 U18 ( .A(PWDATA[19]), .B(n19), .Y(N53) );
  AND2X2 U19 ( .A(PWDATA[18]), .B(n19), .Y(N52) );
  AND2X2 U20 ( .A(PWDATA[17]), .B(n19), .Y(N51) );
  AND2X2 U21 ( .A(PWDATA[16]), .B(n19), .Y(N50) );
  AND2X2 U22 ( .A(PWDATA[15]), .B(n19), .Y(N49) );
  AND2X2 U23 ( .A(PWDATA[14]), .B(n19), .Y(N48) );
  AND2X2 U24 ( .A(PWDATA[13]), .B(n19), .Y(N47) );
  AND2X2 U25 ( .A(PWDATA[12]), .B(n19), .Y(N46) );
  AND2X2 U26 ( .A(PWDATA[11]), .B(n19), .Y(N45) );
  AND2X2 U27 ( .A(PWDATA[10]), .B(n19), .Y(N44) );
  AND2X2 U28 ( .A(PWDATA[9]), .B(n19), .Y(N43) );
  AND2X2 U29 ( .A(PWDATA[8]), .B(n19), .Y(N42) );
  AND2X2 U30 ( .A(PWDATA[7]), .B(n19), .Y(N41) );
  AND2X2 U31 ( .A(PWDATA[6]), .B(n19), .Y(N40) );
  AND2X2 U32 ( .A(PWDATA[5]), .B(n19), .Y(N39) );
  AND2X2 U33 ( .A(PWDATA[4]), .B(n19), .Y(N38) );
  AND2X2 U34 ( .A(PWDATA[3]), .B(n19), .Y(N37) );
  AND2X2 U35 ( .A(PWDATA[2]), .B(n19), .Y(N36) );
  AND2X2 U36 ( .A(PWDATA[1]), .B(n19), .Y(N35) );
  AND2X2 U37 ( .A(PWDATA[0]), .B(n19), .Y(N34) );
  AND2X2 U38 ( .A(n12), .B(n13), .Y(n16) );
  INVX2 U39 ( .A(n13), .Y(n4) );
  INVX2 U42 ( .A(state[1]), .Y(n7) );
  INVX2 U43 ( .A(state[0]), .Y(n8) );
  INVX2 U44 ( .A(PWRITE), .Y(n9) );
  NOR2X1 U45 ( .A(n18), .B(n10), .Y(N32) );
  OAI21X1 U46 ( .A(n12), .B(n9), .C(n13), .Y(N30) );
  OAI21X1 U47 ( .A(PWRITE), .B(n12), .C(n14), .Y(N29) );
  AOI22X1 U48 ( .A(n15), .B(PSEL), .C(PENABLE), .D(n4), .Y(n14) );
  NOR2X1 U49 ( .A(state[2]), .B(n10), .Y(n15) );
  NAND3X1 U50 ( .A(n11), .B(n10), .C(n16), .Y(N28) );
  NAND3X1 U51 ( .A(n8), .B(n18), .C(state[1]), .Y(n13) );
  NAND3X1 U52 ( .A(n7), .B(n18), .C(state[0]), .Y(n12) );
  NAND2X1 U53 ( .A(n8), .B(n7), .Y(n10) );
  NAND3X1 U54 ( .A(state[0]), .B(n18), .C(state[1]), .Y(n11) );
  INVX2 U55 ( .A(n11), .Y(n19) );
  INVX2 U56 ( .A(state[2]), .Y(n17) );
  INVX2 U57 ( .A(state[2]), .Y(n18) );
endmodule

