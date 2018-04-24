// $Id: $
// File name:   tb_MIDI_Data_Processor.sv
// Created:     4/19/18
// Author:      Sanjay Rao
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: testbench for MIDI_Data_Processor.sv
`timescale 1ns / 10ps

module tb_MIDI_Data_Processor();

	
	// Declare DUT portmap signals
	reg tb_data_ready;
	reg [31:0] tb_MIDI_data;
	wire [7:0] tb_MIDI_pitch;
	
	// Declare test bench signals
	integer tb_test_num;
	string tb_test_case;
	integer tb_stream_test_num;
	
	
	// DUT Port map
	MIDI_Data_Processor DUT(.data_ready(tb_data_ready), .MIDI_data(tb_MIDI_data), .MIDI_pitch(tb_MIDI_pitch));
	
	// Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_data_ready = 1'b0;	
		tb_MIDI_data = 32'b0;
		tb_test_num = 0;
		tb_test_case = "INITIALIZATION";
		#(0.1);
		
		// Test Case 1: data_ready is 0
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 1";
		#(0.1);
		// Check that tb_MIDI_Data is 0 initially
		if(8'b0 == tb_MIDI_pitch)
		begin
			$info("Correct tb_MIDI_pitch for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_pitch for %s", tb_test_case);
		end
		//////////////////////////////////////////////////////////////////////

		tb_data_ready = 1'b1;	
		tb_MIDI_data = 32'h0090AA00;
		#(0.1);
		
		// Test Case 2: Note on Message w/ data_ready HIGH
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 2";
		#(0.1);
		// Check that MIDI_pitch is 'AA' because data_ready is HIGH and it's a note on message.
		if(8'hAA == tb_MIDI_pitch)
		begin
			$info("Correct tb_MIDI_pitch for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_pitch for %s", tb_test_case);
		end

		tb_data_ready = 1'b1;	
		tb_MIDI_data = 32'h0080AA00;
		#(0.1);
		
		// Test Case 3: Note off message w/ data_ready HIGH
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 3";
		#(0.1);
		// Check that MIDI_pitch is 'AA' because data_ready is HIGH and it's a note on message.
		if(8'hFF == tb_MIDI_pitch)
		begin
			$info("Correct tb_MIDI_pitch for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_pitch for %s", tb_test_case);
		end
		
		
		
	end
endmodule

