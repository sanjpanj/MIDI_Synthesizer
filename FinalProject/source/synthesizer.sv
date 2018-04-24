// $Id: $
// File name:   synthesizer.sv
// Created:     4/20/18
// Author:      Sanjay Rao
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: This is the top-level design file that connects all of the other functional unit design files. 


module synthesizer
(
	input wire clk, n_rst, PSEL, PENABLE, PWRITE,
	input wire [31:0] PWDATA,
	output wire [15:0] address,
	output wire [15:0] rolloveraddress,
	output wire [15:0] waveformaddress,
	output wire [7:0] rolloverdata,
	output wire [7:0] waveformdata,
	output wire [15:0] Waveform_Sample
);
	reg data_ready;
	reg [31:0] MIDI_data;
	reg [7:0] MIDI_pitch;
	reg [15:0] read_data;
	reg [15:0] Lookup_Index;

	APB_slave APBSLAVE(
				.clk(clk),
				.n_rst(n_rst),
				.PSEL(PSEL),
				.PENABLE(PENABLE),
				.PWRITE(PWRITE),
				.PWDATA(PWDATA),
				.MIDI_Data(MIDI_data),
				.data_ready(data_ready)
	);


	MIDI_Data_Processor MDP(
				.data_ready(data_ready),
				.MIDI_data(MIDI_data),
				.MIDI_pitch(MIDI_pitch)
	);


	VariableClockDivider VCD(
				
				.clk(clk),
				.n_rst(n_rst),
				.Note_Pitch(MIDI_pitch),
				.address(rolloveraddress),
				.read_data(rolloverdata),
				.Lookup_Index(Lookup_Index)
	);

	LookupTableController LTC(
				
				.clk(clk),
				.n_rst(n_rst),
				.Lookup_Index(Lookup_Index),
				.read_data(waveformdata),
				.address(waveformaddress),
				.Waveform_Sample(Waveform_Sample)
	);

endmodule

