-- ----------------------------------------------------------------------------
-- FILE:          nios_cpu.vhd
-- DESCRIPTION:   NIOS CPU top level
-- DATE:          10:52 AM Friday, May 11, 2018
-- AUTHOR(s):     Lime Microsystems
-- REVISIONS:
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
--NOTES:
-- ----------------------------------------------------------------------------
-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fpgacfg_pkg.all;
use work.pllcfg_pkg.all;
use work.tstcfg_pkg.all;
use work.periphcfg_pkg.all;

-- ----------------------------------------------------------------------------
-- Entity declaration
-- ----------------------------------------------------------------------------
entity nios_cpu is
   generic(
      -- CFG_START_ADDR has to be multiple of 32, because there are 32 addresses
      FPGACFG_START_ADDR   : integer := 0;
      PLLCFG_START_ADDR    : integer := 32;
      TSTCFG_START_ADDR    : integer := 64;
      PERIPHCFG_START_ADDR : integer := 192
      );
   port (
      clk                  : in     std_logic;
      reset_n              : in     std_logic;
      -- Control data FIFO
      exfifo_if_d          : in     std_logic_vector(31 downto 0);
      exfifo_if_rd         : out    std_logic;
      exfifo_if_rdempty    : in     std_logic;
      exfifo_of_d          : out    std_logic_vector(31 downto 0);
      exfifo_of_wr         : out    std_logic;
      exfifo_of_wrfull     : in     std_logic;
      exfifo_of_rst        : out    std_logic;
      -- SPI 0
      spi_0_MISO           : in     std_logic;
      spi_0_MOSI           : out    std_logic;
      spi_0_SCLK           : out    std_logic;
      spi_0_SS_n           : out    std_logic_vector(4 downto 0);
         -- SPI 1
      spi_1_MISO           : in     std_logic;
      spi_1_MOSI           : out    std_logic;
      spi_1_SCLK           : out    std_logic;
      spi_1_SS_n           : out    std_logic_vector(1 downto 0);
      -- I2C
      i2c_scl              : inout  std_logic;
      i2c_sda              : inout  std_logic;
      -- Genral purpose I/O
      gpi                  : in     std_logic_vector(7 downto 0);      
      gpo                  : out    std_logic_vector(7 downto 0);
      -- LMS7002 control 
      lms_ctr_gpio         : out    std_logic_vector(3 downto 0);
      -- Configuration registers
      from_fpgacfg         : out    t_FROM_FPGACFG;
      to_fpgacfg           : in     t_TO_FPGACFG;
      from_pllcfg          : out    t_FROM_PLLCFG;
      to_pllcfg            : in     t_TO_PLLCFG;
      from_tstcfg          : out    t_FROM_TSTCFG;
      to_tstcfg            : in     t_TO_TSTCFG;
      to_tstcfg_from_rxtx  : in     t_TO_TSTCFG_FROM_RXTX;
      to_periphcfg         : in     t_TO_PERIPHCFG;
      from_periphcfg       : out    t_FROM_PERIPHCFG;
      
      cfg_top_MOSI         : in std_logic;
      cfg_top_SCLK         : in std_logic;
      cfg_top_CS           : in std_logic;
      cfg_top_or_lms_ctrl_MISO	: out std_logic;
      
      vctcxo_tune_en       : in    std_logic;
      vctcxo_irq           : in    std_logic;
      avm_m0_address       : out   std_logic_vector(7 downto 0);                     --                           avm_m0.address
      avm_m0_read          : out   std_logic;                                        --                                 .read
      avm_m0_waitrequest   : in    std_logic                     := '0';             --                                 .waitrequest
      avm_m0_readdata      : in    std_logic_vector(7 downto 0)  := (others => '0'); --                                 .readdata
      avm_m0_readdatavalid : in    std_logic                     := '0';             --                                 .readdatavalid
      avm_m0_write         : out   std_logic;                                        --                                 .write
      avm_m0_writedata     : out   std_logic_vector(7 downto 0);                     --                                 .writedata
      avm_m0_clk_clk       : out   std_logic;                                        --                       avm_m0_clk.clk
      avm_m0_reset_reset   : out   std_logic       


   );
end nios_cpu;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of nios_cpu is
--declare signals,  components here

   signal vctcxo_tune_en_sync       : std_logic;
   signal vctcxo_irq_sync           : std_logic;
   
--inst0
   signal inst0_dac_spi_ext_MOSI    : std_logic;
   signal inst0_dac_spi_ext_SCLK    : std_logic;
   signal inst0_dac_spi_ext_SS_n    : std_logic;
   signal inst0_fpga_spi_ext_MISO   : std_logic;   
   signal inst0_fpga_spi_ext_MOSI   : std_logic;
   signal inst0_fpga_spi_ext_SCLK   : std_logic;
   signal inst0_fpga_spi_ext_SS_n   : std_logic_vector(2 downto 0);
   
   signal inst0_flash_spi_SS_n      : std_logic;
   
-- inst1
   signal inst1_sdout               : std_logic;
   
   signal vctcxo_tamer_0_irq_out_irq   : std_logic;
   signal vctcxo_tamer_0_ctrl_export   : std_logic_vector(3 downto 0);

   
   component lms_ctr is
   port (
      clk_clk                                 : in    std_logic                    := 'X';             -- clk
      reset_reset_n                           : in    std_logic                     := '0';            --                            reset.reset_n
      exfifo_if_d_export                      : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
      exfifo_if_rd_export                     : out   std_logic;                                       -- export
      exfifo_if_rdempty_export                : in    std_logic                    := 'X';             -- export
      exfifo_of_d_export                      : out   std_logic_vector(31 downto 0);                    -- export
      exfifo_of_wr_export                     : out   std_logic;                                       -- export
      exfifo_of_wrfull_export                 : in    std_logic                    := 'X';             -- export
      exfifo_rst_export                       : out   std_logic;                                       -- export
      leds_external_connection_export         : out   std_logic_vector(7 downto 0);                    -- export
      lms_ctr_gpio_external_connection_export : out   std_logic_vector(3 downto 0);                    -- export
      dac_spi_ext_MISO                        : in    std_logic                    := 'X';             -- MISO
      dac_spi_ext_MOSI                        : out   std_logic;                                       -- MOSI
      dac_spi_ext_SCLK                        : out   std_logic;                                       -- SCLK
      dac_spi_ext_SS_n                        : out   std_logic;                                       -- SS_n
      fpga_spi_ext_MISO                       : in    std_logic                    := 'X';             -- MISO
      fpga_spi_ext_MOSI                       : out   std_logic;                                       -- MOSI
      fpga_spi_ext_SCLK                       : out   std_logic;                                       -- SCLK
      fpga_spi_ext_SS_n                       : out   std_logic_vector(2 downto 0);                    -- SS_n 
      switch_external_connection_export       : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
      i2c_scl_export                          : inout std_logic                    := 'X';             -- export
      i2c_sda_export                          : inout std_logic                    := 'X';             -- export
      flash_spi_MISO                          : in    std_logic                     := 'X';             -- MISO
      flash_spi_MOSI                          : out   std_logic;                                        -- MOSI
      flash_spi_SCLK                          : out   std_logic;                                        -- SCLK
      flash_spi_SS_n                          : out   std_logic;                                        -- SS_n
      vctcxo_tamer_0_ctrl_export              : in    std_logic_vector(3 downto 0)  := (others=>'0');             --            vctcxo_tamer_0_irq_in.export
      avm_m0_address                          : out   std_logic_vector(7 downto 0);                     --                           avm_m0.address
      avm_m0_read                             : out   std_logic;                                        --                                 .read
      avm_m0_waitrequest                      : in    std_logic                     := '0';             --                                 .waitrequest
      avm_m0_readdata                         : in    std_logic_vector(7 downto 0)  := (others => '0'); --                                 .readdata
      avm_m0_write                            : out   std_logic;                                        --                                 .write
      avm_m0_writedata                        : out   std_logic_vector(7 downto 0);                     --                                 .writedata
      avm_m0_readdatavalid                    : in    std_logic                     := '0';             --                                 .readdatavalid
      avm_m0_clk_clk                          : out   std_logic;                                        --                       avm_m0_clk.clk
      avm_m0_reset_reset                      : out   std_logic                                          --                     avm_m0_reset.reset       
   );
   end component lms_ctr;
  
begin

   sync_reg0 : entity work.sync_reg 
   port map(clk, '1', vctcxo_tune_en, vctcxo_tune_en_sync);

   sync_reg1 : entity work.sync_reg 
   port map(clk, '1', vctcxo_irq, vctcxo_irq_sync);

-- ----------------------------------------------------------------------------
-- NIOS instance
-- ----------------------------------------------------------------------------
   lms_ctr_inst0 : component lms_ctr
   port map (
      clk_clk                                   => clk,
      reset_reset_n                             => reset_n,
      exfifo_if_d_export                        => exfifo_if_d,
      exfifo_if_rd_export                       => exfifo_if_rd,
      exfifo_if_rdempty_export                  => exfifo_if_rdempty,
      exfifo_of_d_export                        => exfifo_of_d,
      exfifo_of_wr_export                       => exfifo_of_wr,
      exfifo_of_wrfull_export                   => exfifo_of_wrfull,
      exfifo_rst_export                         => exfifo_of_rst,
      leds_external_connection_export           => gpo,
      lms_ctr_gpio_external_connection_export   => lms_ctr_gpio,
      dac_spi_ext_MISO                          => '0',
      dac_spi_ext_MOSI                          => inst0_dac_spi_ext_MOSI,
      dac_spi_ext_SCLK                          => inst0_dac_spi_ext_SCLK,
      dac_spi_ext_SS_n                          => inst0_dac_spi_ext_SS_n,
      fpga_spi_ext_MISO                         => inst0_fpga_spi_ext_MISO,
      fpga_spi_ext_MOSI                         => inst0_fpga_spi_ext_MOSI,
      fpga_spi_ext_SCLK                         => inst0_fpga_spi_ext_SCLK,
      fpga_spi_ext_SS_n                         => inst0_fpga_spi_ext_SS_n,
      switch_external_connection_export         => gpi,
      i2c_scl_export                            => i2c_scl,
      i2c_sda_export                            => i2c_sda,
      flash_spi_MISO                            => spi_1_MISO,
      flash_spi_MOSI                            => spi_1_MOSI,
      flash_spi_SCLK                            => spi_1_SCLK,
      flash_spi_SS_n                            => inst0_flash_spi_SS_n,
      vctcxo_tamer_0_ctrl_export                => vctcxo_tamer_0_ctrl_export,
      avm_m0_address                            => avm_m0_address,
      avm_m0_read                               => avm_m0_read,
      avm_m0_waitrequest                        => avm_m0_waitrequest,
      avm_m0_readdatavalid                      => avm_m0_readdatavalid,
      avm_m0_readdata                           => avm_m0_readdata,
      avm_m0_write                              => avm_m0_write,
      avm_m0_writedata                          => avm_m0_writedata,
      avm_m0_clk_clk                            => avm_m0_clk_clk,
      avm_m0_reset_reset                        => avm_m0_reset_reset
   );
-- ----------------------------------------------------------------------------
-- fpgacfg instance
-- ----------------------------------------------------------------------------     
   cfg_top_inst1 : entity work.cfg_top
   generic map (
      FPGACFG_START_ADDR   => FPGACFG_START_ADDR,
      PLLCFG_START_ADDR    => PLLCFG_START_ADDR,
      TSTCFG_START_ADDR    => TSTCFG_START_ADDR,
      PERIPHCFG_START_ADDR => PERIPHCFG_START_ADDR
      )
   port map(
      -- Serial port IOs
      sdin                 => inst0_fpga_spi_ext_MOSI,
      sclk                 => inst0_fpga_spi_ext_SCLK,
      sen                  => inst0_fpga_spi_ext_SS_n(1),
      sdout                => inst1_sdout,  
      -- Signals coming from the pins or top level serial interface
      lreset               => reset_n,   -- Logic reset signal, resets logic cells only  (use only one reset)
      mreset               => reset_n,   -- Memory reset signal, resets configuration memory only (use only one reset)          
      to_fpgacfg           => to_fpgacfg,
      from_fpgacfg         => from_fpgacfg,
      to_pllcfg            => to_pllcfg,
      from_pllcfg          => from_pllcfg,
      to_tstcfg            => to_tstcfg,
      from_tstcfg          => from_tstcfg,
      to_tstcfg_from_rxtx  => to_tstcfg_from_rxtx,
      to_periphcfg         => to_periphcfg,
      from_periphcfg       => from_periphcfg
   );
   
   
   inst0_fpga_spi_ext_MISO <= inst1_sdout OR spi_0_MISO;
   
   vctcxo_tamer_0_ctrl_export(0) <= vctcxo_tune_en_sync;
   vctcxo_tamer_0_ctrl_export(1) <= vctcxo_irq_sync;
   vctcxo_tamer_0_ctrl_export(2) <= '0';
   vctcxo_tamer_0_ctrl_export(3) <= '0';
   
-- ----------------------------------------------------------------------------
-- Output ports
-- ----------------------------------------------------------------------------   
   spi_0_SS_n  <= '1' & inst0_fpga_spi_ext_SS_n(2) & inst0_dac_spi_ext_SS_n & inst0_fpga_spi_ext_SS_n(1 downto 0);
   -- SPI switch to select between AD5601 and the rest of slaves.
   -- This is neccessary, while ADF4002 CLOCK_PHASE = 0, while AD5601 CLOCK_PHASE = 1
   spi_0_MOSI <= inst0_fpga_spi_ext_MOSI when inst0_dac_spi_ext_SS_n = '1' else inst0_dac_spi_ext_MOSI;
   spi_0_SCLK <= inst0_fpga_spi_ext_SCLK when inst0_dac_spi_ext_SS_n = '1' else inst0_dac_spi_ext_SCLK;
   
   spi_1_SS_n  <= '1' & inst0_flash_spi_SS_n;
   
   
   
   

end arch;   




