/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 24 14:20:26 2018
/////////////////////////////////////////////////////////////


module MIDI_Data_Processor ( data_ready, MIDI_data, MIDI_pitch );
  input [31:0] MIDI_data;
  output [7:0] MIDI_pitch;
  input data_ready;
  wire   n7, n8, n9;

  OR2X1 U16 ( .A(MIDI_data[15]), .B(n7), .Y(MIDI_pitch[7]) );
  OR2X1 U17 ( .A(MIDI_data[14]), .B(n7), .Y(MIDI_pitch[6]) );
  OR2X1 U18 ( .A(MIDI_data[13]), .B(n7), .Y(MIDI_pitch[5]) );
  OR2X1 U19 ( .A(MIDI_data[12]), .B(n7), .Y(MIDI_pitch[4]) );
  OR2X1 U20 ( .A(MIDI_data[11]), .B(n7), .Y(MIDI_pitch[3]) );
  OR2X1 U21 ( .A(MIDI_data[10]), .B(n7), .Y(MIDI_pitch[2]) );
  OR2X1 U22 ( .A(MIDI_data[9]), .B(n7), .Y(MIDI_pitch[1]) );
  OR2X1 U23 ( .A(MIDI_data[8]), .B(n7), .Y(MIDI_pitch[0]) );
  NAND3X1 U24 ( .A(n8), .B(MIDI_data[20]), .C(n9), .Y(n7) );
  AND2X1 U25 ( .A(data_ready), .B(MIDI_data[23]), .Y(n9) );
  NOR2X1 U26 ( .A(MIDI_data[22]), .B(MIDI_data[21]), .Y(n8) );
endmodule

