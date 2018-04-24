// $Id: $
// File name:   LookupTableController.sv
// Created:     4/18/2018
// Author:      Ben Yanek
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: LookupTableController.sv
module LookupTableController
(
	input clk,
	input n_rst,
	input [15:0] Lookup_Index,
	output [15:0] address,
	input [7:0] read_data,
	output [15:0] Waveform_Sample
);
reg Clear;
reg Enable;
reg [11:0] Count_Out;
reg [15:0]addressreg;
reg New_Sample;
reg New_Data;
reg [15:0] Sample_Buffer;
reg [15:0] Wave_Value;
reg [7:0] readdata1;
reg [7:0] readdata2;

assign address = addressreg;
assign Waveform_Sample = Wave_Value;
assign New_Data = 1;
assign Clear = 0;
assign Enable = 1;

flex_counter #(.NUM_CNT_BITS(12)) flex3 (.clk(clk), .n_rst(n_rst), .clear(Clear), .count_enable(Enable), .rollover_val(12'd2268), .count_out(Count_Out), .rollover_flag(New_Sample));
//SRAMController wl (.clk(clk), .n_rst(n_rst), .New_Data(New_Data), .address(Lookup_Index), .read_data(Sample_Buffer));

typedef enum bit [2:0] {IDLE, NEW_ADDRESS1, WAIT1, NEW_ADDRESS2, WAIT2, TRANSMIT} stateType;
stateType state;
stateType next_state;

always_ff @(posedge clk, negedge n_rst)
begin
	if(n_rst == 0)
		state <= IDLE;
	else
		state <= next_state;
end

always_comb
begin
	case(state)
	IDLE:
	begin
		next_state = NEW_ADDRESS1;
	end
	NEW_ADDRESS1:
	begin
		addressreg = Lookup_Index;	
		next_state = WAIT1;
	end
	WAIT1:
	begin
		readdata1 = read_data[7:0];
		next_state = NEW_ADDRESS2;
	end
	NEW_ADDRESS2:
	begin
		addressreg = Lookup_Index + 1;
		next_state = WAIT2;
	end
	WAIT2:
	begin
		readdata2 = read_data[7:0];
		next_state = IDLE;
	end
	default:
	begin
		next_state = IDLE;
	end
	endcase
end

always@(posedge clk)
begin
	if(New_Sample == 1)
		Wave_Value = {readdata1, readdata2};
	else
		Wave_Value = Wave_Value;
end
endmodule
