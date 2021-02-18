
module lms_ctr (
	avm_m0_address,
	avm_m0_read,
	avm_m0_waitrequest,
	avm_m0_readdata,
	avm_m0_write,
	avm_m0_writedata,
	avm_m0_readdatavalid,
	avm_m0_clk_clk,
	avm_m0_reset_reset,
	clk_clk,
	dac_spi_ext_MISO,
	dac_spi_ext_MOSI,
	dac_spi_ext_SCLK,
	dac_spi_ext_SS_n,
	exfifo_if_d_export,
	exfifo_if_rd_export,
	exfifo_if_rdempty_export,
	exfifo_of_d_export,
	exfifo_of_wr_export,
	exfifo_of_wrfull_export,
	exfifo_rst_export,
	flash_spi_MISO,
	flash_spi_MOSI,
	flash_spi_SCLK,
	flash_spi_SS_n,
	fpga_spi_ext_MISO,
	fpga_spi_ext_MOSI,
	fpga_spi_ext_SCLK,
	fpga_spi_ext_SS_n,
	i2c_scl_export,
	i2c_sda_export,
	leds_external_connection_export,
	lms_ctr_gpio_external_connection_export,
	reset_reset_n,
	switch_external_connection_export,
	vctcxo_tamer_0_ctrl_export);	

	output	[7:0]	avm_m0_address;
	output		avm_m0_read;
	input		avm_m0_waitrequest;
	input	[7:0]	avm_m0_readdata;
	output		avm_m0_write;
	output	[7:0]	avm_m0_writedata;
	input		avm_m0_readdatavalid;
	output		avm_m0_clk_clk;
	output		avm_m0_reset_reset;
	input		clk_clk;
	input		dac_spi_ext_MISO;
	output		dac_spi_ext_MOSI;
	output		dac_spi_ext_SCLK;
	output		dac_spi_ext_SS_n;
	input	[31:0]	exfifo_if_d_export;
	output		exfifo_if_rd_export;
	input		exfifo_if_rdempty_export;
	output	[31:0]	exfifo_of_d_export;
	output		exfifo_of_wr_export;
	input		exfifo_of_wrfull_export;
	output		exfifo_rst_export;
	input		flash_spi_MISO;
	output		flash_spi_MOSI;
	output		flash_spi_SCLK;
	output		flash_spi_SS_n;
	input		fpga_spi_ext_MISO;
	output		fpga_spi_ext_MOSI;
	output		fpga_spi_ext_SCLK;
	output	[2:0]	fpga_spi_ext_SS_n;
	inout		i2c_scl_export;
	inout		i2c_sda_export;
	output	[7:0]	leds_external_connection_export;
	output	[3:0]	lms_ctr_gpio_external_connection_export;
	input		reset_reset_n;
	input	[7:0]	switch_external_connection_export;
	input	[3:0]	vctcxo_tamer_0_ctrl_export;
endmodule
