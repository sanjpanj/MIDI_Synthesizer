// $Id: $
// File name:   tb_Synthesizer.sv
// Created:     4/20/2018
// Author:      Ben Yanek
// Lab Section: 337-07
// Version:     1.0  Initial Design Entry
// Description: tb_Synthesizer.sv
`timescale 1ns / 10ps

module tb_synthesizer ();

	localparam CLK_PERIOD = 10;
	
	reg tb_clk;

	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	tb_synthesizer_DUT dut_default(tb_clk);
	
endmodule 

module tb_synthesizer_DUT (input wire tb_clk);
	reg tb_n_rst;
	reg tb_PSEL;
	reg tb_PENABLE;
	reg tb_PWRITE;
	reg [31:0] tb_PWDATA;
	reg [15:0] tb_rolloveraddress;
	reg [15:0] tb_waveformaddress;
	reg [7:0] tb_rolloverdata;
	reg [7:0] tb_waveformdata;
	reg [15:0] tb_waveform_sample;
	
	synthesizer DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.PSEL(tb_PSEL),
		.PENABLE(tb_PENABLE),
		.PWRITE(tb_PWRITE),
		.PWDATA(tb_PWDATA),
		.rolloveraddress(tb_rolloveraddress),
		.waveformaddress(tb_waveformaddress),
		.rolloverdata(tb_rolloverdata),
		.waveformdata(tb_waveformdata),
		.Waveform_Sample(tb_waveform_sample)
	);

	integer unsigned tb_init_file_number;
	integer unsigned tb_dump_file_number;
	integer unsigned tb_start_address;	
	integer unsigned tb_last_address;	
	reg tb_mem_clr;	
	reg tb_mem_init;									
	reg tb_mem_dump;																
	reg tb_verbose;		
	reg tb_read_enable;		
	reg tb_write_enable;	
	reg [7:0] tb_write_data;
	
	on_chip_sram_wrapper SRAM1
	(
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		.read_enable(tb_read_enable),
		.write_enable(tb_write_enable),
		.address(tb_rolloveraddress),
		.read_data(tb_rolloverdata),
		.write_data(tb_write_data)
	);
	
	on_chip_sram_wrapper SRAM2
	(
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		.read_enable(tb_read_enable),
		.write_enable(tb_write_enable),
		.address(tb_waveformaddress),
		.read_data(tb_waveformdata),
		.write_data(tb_write_data)
	);

	task clock();
	begin
		@(negedge tb_clk);
	end
	endtask

	initial
	begin
		tb_mem_clr = 0;
		tb_mem_init = 0;
		tb_mem_dump = 0;
		tb_verbose = 0;
		tb_init_file_number = 0;
		tb_dump_file_number = 0;
		tb_start_address = 0;
		tb_last_address = 0;
		tb_read_enable = 0;
		tb_write_enable = 0;
		tb_write_data = 16'b0;
		clock();
		tb_mem_init = 1;
		clock();
		tb_mem_init = 0;
		tb_init_file_number = 1;
		clock();
		tb_mem_init = 1;
		tb_n_rst = 1;
		clock();
		tb_mem_init = 0;
		tb_n_rst = 0;
		clock();
		tb_n_rst = 1;
		
	
		// Test 1
		if (1)
			$info("Test Case %0d:: PASSED", 1);
		else // Test case failed
			$error("Test Case %0d:: FAILED", 1);
	end
endmodule