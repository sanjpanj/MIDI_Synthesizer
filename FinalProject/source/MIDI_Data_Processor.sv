// $Id: $
// File name:   MIDI_Data_Processor.sv
// Created:     4/13/18
// Author:      Sanjay Rao
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: This block is responsible for taking in MIDI data off of the APB bus and parsing it to separate status bytes and data bytes. The block will then differentiate between "note off" and "note on" data bytes and send the appropriate pitch value to the output. 

module MIDI_Data_Processor(
	input wire data_ready,
	input wire [31:0] MIDI_data,
	output reg [7:0] MIDI_pitch
);

	always_comb begin
		if ((data_ready == 1) && (MIDI_data[23:20] == 4'b1001))
			MIDI_pitch = MIDI_data[15:8]; //NOTE ON MESSAGE
		else if ((data_ready == 1) && (MIDI_data[23:20] == 4'b1000))
			MIDI_pitch = 8'b11111111; //NOTE OFF MESSAGE
		else
			MIDI_pitch = 8'b11111111; //DEFAULT
	end
endmodule
			

			
