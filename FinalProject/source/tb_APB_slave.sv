// $Id: $
// File name:   tb_eop_detect.sv
// Created:     4/19/18
// Author:      Sanjay Rao
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: testbench for MIDI_Data_Processor.sv
`timescale 1ns / 10ps

module tb_APB_slave();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 2.5;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= 1; // Check right before the setup time starts
	
	
	// Declare DUT portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_PSEL;
	reg tb_PENABLE;
	reg tb_PWRITE;
	reg [31:0] tb_PWDATA;
	wire [31:0] tb_MIDI_Data;
	wire tb_data_ready;
	
	// Declare test bench signals
	integer tb_test_num;
	string tb_test_case;
	integer tb_stream_test_num;
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// DUT Port map
	APB_slave DUT(.clk(tb_clk), .n_rst(tb_n_rst), .PSEL(tb_PSEL), .PENABLE(tb_PENABLE), .PWRITE(tb_PWRITE), .PWDATA(tb_PWDATA), .MIDI_Data(tb_MIDI_Data), .data_ready(tb_data_ready));
	
	// Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_PSEL	= 1'b0;	
		tb_PENABLE= 1'b0;
		tb_PWRITE = 1'b0;
		tb_PWDATA = 32'b0;	// Initialize to be low
		tb_test_num = 0;
		tb_test_case = "INITIALIZATION";
		#(0.1);
		
		// Test Case 1: IDLE STATE
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 1";
		#(0.1);
		tb_n_rst	= 1'b0; 	// Activate reset
		#(CLK_PERIOD * 0.5);
		// Check that tb_MIDI_Data is 0 initially
		if(32'b0 == tb_MIDI_Data)
		begin
			$info("Correct tb_MIDI_Data for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_Data for %s", tb_test_case);
		end
		// Check that the data_ready is correct
		#(CLK_PERIOD);
		if(1'b0 == tb_data_ready)
		begin
			$info("Correct data_ready for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect data_ready for %s", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;

		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_PSEL	= 1'b1;	
		tb_PENABLE= 1'b0;
		tb_PWRITE = 1'b0;
		tb_PWDATA = 32'b0;	// Initialize to be low
		
		// Test Case 2: PSEL is HIGH
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 2";
		#(0.1);
		#(CLK_PERIOD * 0.5);
		// Check that tb_MIDI_Data is 0 after PSEL is HIGH
		if(32'b0 == tb_MIDI_Data)
		begin
			$info("Correct tb_MIDI_Data for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_Data for %s", tb_test_case);
		end
		// Check that the data_ready is 0 after PSEL is HIGH
		#(CLK_PERIOD);
		if(1'b0 == tb_data_ready)
		begin
			$info("Correct data_ready for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect data_ready for %s", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;
		
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_PSEL	= 1'b1;	
		tb_PENABLE= 1'b0;
		tb_PWRITE = 1'b1;
		tb_PWDATA = 32'b0;	// Initialize to be low
		
		// Test Case 3: PWRITE is HIGH
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 3";
		#(0.1);
		#(CLK_PERIOD * 0.5);
		// Check that tb_MIDI_Data is 0 after PWRITE is HIGH
		if(32'b0 == tb_MIDI_Data)
		begin
			$info("Correct tb_MIDI_Data for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_Data for %s", tb_test_case);
		end
		// Check that the data_ready is 0 after PWRITE is HIGH
		#(CLK_PERIOD);
		if(1'b0 == tb_data_ready)
		begin
			$info("Correct data_ready for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect data_ready for %s", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;
		
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_PSEL	= 1'b1;	
		tb_PENABLE= 1'b1;
		tb_PWRITE = 1'b1;
		tb_PWDATA = 32'hFFFFFFFF;	// Initialize to be low


		// Test Case 4: PSEL, PWRITE, PENABLE, and PWDATA are HIGH
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 4";
		#(0.1);
		#(CLK_PERIOD * 0.5);
		// Check that tb_MIDI_Data is 0 after PWRITE is HIGH
		if(32'hFFFFFFFF == tb_MIDI_Data)
		begin
			$info("Correct tb_MIDI_Data for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_Data for %s", tb_test_case);
		end
		// Check that the data_ready is 0 after PWRITE is HIGH
		#(CLK_PERIOD);
		if(1'b1 == tb_data_ready)
		begin
			$info("Correct data_ready for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect data_ready for %s", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;
		

		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_PSEL	= 1'b0;	
		tb_PENABLE= 1'b0;
		tb_PWRITE = 1'b0;
		tb_PWDATA = 32'b0;	// Initialize to be low


		// Test Case 5: All inputs back to 0
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "TEST CASE 5";
		#(0.1);
		#(CLK_PERIOD * 0.5);
		// Check that tb_MIDI_Data is 0 after PWRITE is HIGH
		if(32'b0 == tb_MIDI_Data)
		begin
			$info("Correct tb_MIDI_Data for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect tb_MIDI_Data for %s", tb_test_case);
		end
		// Check that the data_ready is 0 after PWRITE is HIGH
		#(CLK_PERIOD);
		if(1'b0 == tb_data_ready)
		begin
			$info("Correct data_ready for %s", tb_test_case);
		end
		else
		begin
			$error("Incorrect data_ready for %s", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;
		
		
	end
endmodule

