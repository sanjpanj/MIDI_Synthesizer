// $Id: $
// File name:   APB_slave.sv
// Created:     4/13/18
// Author:      Sanjay Rao
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: This block takes in various APB Signals into a state machine and allows MIDI data to be written into a buffer. The MIDI data in the buffer will then be written to the APB data bus where it can be read by the MIDI data processor.

module APB_slave(
	input wire clk,
	input wire n_rst,
	input wire PSEL,
	input wire PENABLE,
	input wire PWRITE,
	input wire [31:0]PWDATA,
	output reg [31:0] MIDI_Data,
	output reg data_ready
);

	typedef enum bit [2:0] {IDLE, WAIT_WRITE, WAIT_ENABLE, RECEIVE, OUTPUT}stateType;
	
	stateType state;
	stateType nxt_state;
	
	
	reg [31:0] midiout;
	reg d_ready;
	reg load_enable;

	always_comb begin
	case(state)
		IDLE: begin
			if (PSEL == 1) nxt_state = WAIT_WRITE;
			else nxt_state = IDLE;
			load_enable = 0;
			d_ready = 0;
			midiout = 32'b0;

		end

		WAIT_WRITE: begin
			if (PWRITE == 1) nxt_state = WAIT_ENABLE;
			else nxt_state = WAIT_WRITE; 
			load_enable = 0;
			d_ready = 0;
			midiout = 32'b0;
		end

		WAIT_ENABLE: begin
			if (PENABLE == 1) nxt_state = RECEIVE;
			else nxt_state = WAIT_ENABLE; 
			load_enable = 0;
			d_ready = 0;
			midiout = 32'b0;
		end

		RECEIVE: begin
			nxt_state = OUTPUT;
			load_enable = 1;
			d_ready = 0;
			midiout = PWDATA;
		end

		OUTPUT: begin
			nxt_state = IDLE;
			load_enable = 0;
			d_ready = 1;
		end
	endcase
	end
			

	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 0)
			state <= IDLE;
		else
			state <= nxt_state;
	end

	assign MIDI_Data = midiout;
	assign data_ready = d_ready;


endmodule
