# ----------------------------------------------------------------------------
# FILE: 	rpi_spi.sdc
# DESCRIPTION:	
# DATE:	June 2, 2017
# AUTHOR(s):	Lime Microsystems
# REVISIONS:
# ----------------------------------------------------------------------------
# NOTES:
# 
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Timing parameters
# ----------------------------------------------------------------------------
set RAPI_SPI0_SCLK_period 20.00
set RAPI_SPI1_SCLK_period 20.00

# ----------------------------------------------------------------------------
# Base clocks
# ----------------------------------------------------------------------------                       
create_clock   -name RAPI_SPI0_SCLK \
               -period 	$RAPI_SPI0_SCLK_period \
               -waveform {10 20} \
               [get_ports RAPI_SPI0_SCLK]

create_clock   -name RAPI_SPI1_SCLK \
               -period $RAPI_SPI1_SCLK_period \
               -waveform {10 20} \
               [get_ports RAPI_SPI1_SCLK]
               

# ----------------------------------------------------------------------------
# Virtual clocks
# ----------------------------------------------------------------------------
create_clock   -name RAPI_SPI0_SCLK_virt \
               -period 	$RAPI_SPI0_SCLK_period

create_clock   -name RAPI_SPI1_SCLK_virt \
               -period $RAPI_SPI1_SCLK_period
               
# ----------------------------------------------------------------------------
#Generated clocks
# ----------------------------------------------------------------------------               
           
# ----------------------------------------------------------------------------
# Input constraints
# ----------------------------------------------------------------------------
#RAPI_SPI0

set_input_delay   -max 0 \
                  -clock [get_clocks RAPI_SPI0_SCLK_virt] \
                  [get_ports {RAPI_SPI0_MOSI}]

set_input_delay   -min 0 \
                  -clock [get_clocks RAPI_SPI0_SCLK_virt] \
                  [get_ports {RAPI_SPI0_MOSI}]
#RAPI_SPI1                                        
set_input_delay   -max 0 \
                  -clock [get_clocks RAPI_SPI1_SCLK_virt] \
                  [get_ports {RAPI_SPI1_MOSI}]

set_input_delay   -min 0 \
                  -clock [get_clocks RAPI_SPI1_SCLK_virt] \
                  [get_ports {RAPI_SPI1_MOSI}]
                              
# ----------------------------------------------------------------------------
# Output constraints
# ----------------------------------------------------------------------------                             
#RAPI_SPI0
set_output_delay  -max 5 \
                  -clock [get_clocks RAPI_SPI0_SCLK] \
                  [get_ports {RAPI_SPI0_MISO}]

set_output_delay  -min -0 \
                  -clock [get_clocks RAPI_SPI0_SCLK] \
                  [get_ports {RAPI_SPI0_MISO}]  
#RAPI_SPI1                                   
set_output_delay  -max 5 \
                  -clock [get_clocks RAPI_SPI1_SCLK] \
                  [get_ports {RAPI_SPI1_MISO}]

set_output_delay  -min -0 \
                  -clock [get_clocks RAPI_SPI1_SCLK] \
                  [get_ports {RAPI_SPI1_MISO}]   
                  
                  
# set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*ram_block11a7~portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -setup 8
# set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*ram_block11a7~portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -hold -end 7    
# 
# set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*ram_block11a15~portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -setup 8
# set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*ram_block11a15~portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -hold -end 7   

set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*portb_address_reg0*] -to [get_registers {*spi_module*|rx_shiftreg[*]}] -setup 8
set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*portb_address_reg0*] -to [get_registers {*spi_module*|rx_shiftreg[*]}] -hold -end 7

set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|address_reg_b[0]] -to [get_registers {*spi_module*|rx_shiftreg[*]}] -setup 8
set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|address_reg_b[0]] -to [get_registers {*spi_module*|rx_shiftreg[*]}] -hold -end 7 

set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|address_reg_b[0]] -to [get_ports {RAPI_SPI0_MISO}] -setup 8
set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|address_reg_b[0]] -to [get_ports {RAPI_SPI0_MISO}] -hold -end 7 

set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -setup 8
set_multicycle_path -from [get_registers *spi_module*|*rx_fifo*|*portb_address_reg0*] -to [get_ports {RAPI_SPI0_MISO}] -hold -end 7


# ----------------------------------------------------------------------------
# Exceptions
# ----------------------------------------------------------------------------

set_false_path -from {spi_module:ints0_spimodule|fifo_inst:rx_fifo_spi|dcfifo_mixed_widths:dcfifo_mixed_widths_component|dcfifo_rbn1:auto_generated|altsyncram_ko01:fifo_ram|ram_block11a15~portb_address_reg0} -to {FPGA_GPIO[7]}
set_false_path -from {spi_module:ints0_spimodule|fifo_inst:rx_fifo_spi|dcfifo_mixed_widths:dcfifo_mixed_widths_component|dcfifo_rbn1:auto_generated|altsyncram_ko01:fifo_ram|address_reg_b[0]} -to {FPGA_GPIO[7]}
set_false_path -from {spi_module:ints0_spimodule|fifo_inst:rx_fifo_spi|dcfifo_mixed_widths:dcfifo_mixed_widths_component|dcfifo_rbn1:auto_generated|altsyncram_ko01:fifo_ram|ram_block11a7~portb_address_reg0} -to {FPGA_GPIO[7]}