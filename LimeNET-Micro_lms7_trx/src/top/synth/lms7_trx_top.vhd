-- ----------------------------------------------------------------------------
-- FILE:          lms7_trx_top.vhd
-- DESCRIPTION:   Top level file for LimeNET-Micro board
-- DATE:          10:06 AM Friday, May 11, 2018
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
use work.FIFO_PACK.all;
library altera; 
use altera.altera_primitives_components.all;

-- ----------------------------------------------------------------------------
-- Entity declaration
-- ----------------------------------------------------------------------------
entity lms7_trx_top is
   generic(
      -- General parameters
      BOARD                   : string := "LimeNET-Micro";
      DEV_FAMILY              : string := "MAX 10";
      -- LMS7002 related 
      LMS_DIQ_WIDTH           : integer := 12;
      -- FTDI (USB3) related
      FTDI_DQ_WIDTH           : integer := 32;     -- FTDI Data bus size      
      CTRL0_FPGA_RX_SIZE      : integer := 1024;   -- Control PC->FPGA, FIFO size in bytes.
      CTRL0_FPGA_RX_RWIDTH    : integer := 32;     -- Control PC->FPGA, FIFO rd width.
      CTRL0_FPGA_TX_SIZE      : integer := 1024;   -- Control FPGA->PC, FIFO size in bytes
      CTRL0_FPGA_TX_WWIDTH    : integer := 32;     -- Control FPGA->PC, FIFO wr width
      STRM0_FPGA_RX_SIZE      : integer := 4096;   -- Stream PC->FPGA, FIFO size in bytes
      STRM0_FPGA_RX_RWIDTH    : integer := 128;    -- Stream PC->FPGA, rd width
      STRM0_FPGA_TX_SIZE      : integer := 16384;  -- Stream FPGA->PC, FIFO size in bytes
      STRM0_FPGA_TX_WWIDTH    : integer := 64;     -- Stream FPGA->PC, wr width
      -- 
      TX_N_BUFF               : integer := 4;      -- N 4KB buffers in TX interface (2 OR 4)
      TX_PCT_SIZE             : integer := 4096;   -- TX packet size in bytes
      TX_IN_PCT_HDR_SIZE      : integer := 16;
      -- Internal configuration memory 
      FPGACFG_START_ADDR      : integer := 0;
      PLLCFG_START_ADDR       : integer := 32;
      TSTCFG_START_ADDR       : integer := 96;
      PERIPHCFG_START_ADDR    : integer := 192
   );
   port (
      -- ----------------------------------------------------------------------------
      -- External GND pin for reset
      --EXT_GND           : in     std_logic;
      -- ---------------------------------------------------------------------what SDR board are you using, and h-------
      -- Clock sources
         -- Reference clock, coming from LMK clock buffer.
      LMK_CLK           : in     std_logic;
      -- ----------------------------------------------------------------------------
      -- LMS7002 Digital
         -- PORT1
      LMS_MCLK1         : in     std_logic;
      LMS_FCLK1         : out    std_logic;
      LMS_TXNRX1        : out    std_logic;
      LMS_ENABLE_IQSEL1 : out    std_logic;
      LMS_DIQ1_D        : out    std_logic_vector(LMS_DIQ_WIDTH-1 downto 0);
         -- PORT2
      LMS_MCLK2         : in     std_logic;
      LMS_FCLK2         : out    std_logic;
      LMS_TXNRX2        : out    std_logic;
      LMS_ENABLE_IQSEL2 : in     std_logic;
      LMS_DIQ2_D        : in     std_logic_vector(LMS_DIQ_WIDTH-1 downto 0);
         --MISC
      --LMS_RESET         : out    std_logic := '1';
      --LMS_TXEN          : out    std_logic;   -- Shift register
      --LMS_RXEN          : out    std_logic;   -- Shift register
      --LMS_CORE_LDO_EN   : out    std_logic;   -- Shift register
      -- ----------------------------------------------------------------------------
      -- Raspberry
         --SPI0
      RAPI_SPI0_SCLK    : in     std_logic;
      RAPI_SPI0_MOSI    : in     std_logic;
      RAPI_SPI0_MISO    : out    std_logic;
      RAPI_SPI0_CE0     : in     std_logic;
      --RAPI_SPI0_CE1     : in     std_logic;
         -- SPI1
      RAPI_SPI1_SCLK    : in     std_logic;
      RAPI_SPI1_MOSI    : in     std_logic;
      RAPI_SPI1_MISO    : out    std_logic;
      RAPI_SPI1_CE0     : in     std_logic;
      --RAPI_SPI1_CE1     : in     std_logic;
      --RAPI_SPI1_CE2     : in     std_logic;      
         -- UART
      --RAPI_UART1_RX     : out    std_logic;
      --RAPI_UART1_TX     : in     std_logic;     
         -- I2C
      --RAPI_I2C1_SCL     : inout  std_logic;       
      --RAPI_I2C1_SDA     : inout  std_logic;
         -- MISC
      --RAPI_ACT          : in     std_logic;
      --RAPI_RUN          : in     std_logic; -- Shift register
      RAPI_EMMC_EN      : in     std_logic;
      RAPI_GPIO12       : out    std_logic;
      --RAPI_GPIO13       : in     std_logic;
      --RAPI_GPIO27       : in     std_logic;
      -- FTDI (USB3)
         -- Clock source
      FT_CLK            : in     std_logic;
         -- DATA
      FT_BE             : inout  std_logic_vector(FTDI_DQ_WIDTH/8-1 downto 0);
      FT_D              : inout  std_logic_vector(FTDI_DQ_WIDTH-1 downto 0);
         -- Control, flags
      FT_RXFn           : in     std_logic;
      FT_TXEn           : in     std_logic;
      FT_WRn            : out    std_logic;
      FT_OEn            : out    std_logic;
      FT_WAKEUPn        : out    std_logic; 
      FT_RDn            : out    std_logic;
      -- ----------------------------------------------------------------------------
      -- Ethernet
      --ETH_NRESET        : out    std_logic; -- Shift register
      --ETH_LED1          : out    std_logic; -- Shift register
      --ETH_LED2          : out    std_logic; -- Shift register
      ETH_GPIO0         : in     std_logic;  -- Weak Pull-UP enabled
      ETH_GPIO1         : in     std_logic;  -- Weak Pull-UP enabled
      ETH_GPIO2         : in     std_logic;  -- Weak Pull-UP enabled
      --ETH_AUTOMDIX_EN   : out    std_logic; -- Shift register
      -- ----------------------------------------------------------------------------
      -- GNSS
      GNSS_TPULSE       : in     std_logic;
      --GNSS_DDC_SDA      : inout  std_logic;
      --GNSS_DDC_SCL      : inout  std_logic;
      GNSS_UART_TX      : in     std_logic;
      GNSS_UART_RX      : out    std_logic:='1';
      -- ----------------------------------------------------------------------------
      -- External communication interfaces
         -- FPGA_SPI
      FPGA_SPI_SCLK     : out    std_logic;
      FPGA_SPI_MOSI     : out    std_logic;
      FPGA_SPI_MISO     : in     std_logic;      
      FPGA_SPI_LMS_SS   : out    std_logic;
      --FPGA_SPI_ADF_SS   : out    std_logic;  -- Shift register
      --FPGA_SPI_DAC_SS   : out    std_logic;  -- Shift register
         -- FPGA_QSPI
--      FPGA_QSPI_SCLK    : out    std_logic;
--      FPGA_QSPI_IO0     : out    std_logic;
--      FPGA_QSPI_IO1     : in     std_logic;
--      FPGA_QSPI_IO2     : out    std_logic;
--      FPGA_QSPI_IO3     : out    std_logic;
--      FPGA_QSPI_FLASH_SS: out    std_logic;
         -- FPGA I2C
      FPGA_I2C_SCL      : inout  std_logic;
      FPGA_I2C_SDA      : inout  std_logic;
      -- ----------------------------------------------------------------------------
      -- General periphery
      -- Shift registers
      SR_SCLK           : out    std_logic;
      SR_DIN            : out    std_logic;
      SR_LATCH          : out    std_logic; 
      -- WIFI module
      WIFI_PIO5         : inout  std_logic;
         -- LEDs          
      --FPGA_LED1_R       : out    std_logic;
      --FPGA_LED1_G       : out    std_logic;
      --FPGA_LED2_R       : out    std_logic;
      --FPGA_LED2_G       : out    std_logic;
      --FPGA_LED3_R       : out    std_logic;
      --FPGA_LED3_G       : out    std_logic;
      --FPGA_LED4_R       : out    std_logic;
      --FPGA_LED4_G       : out    std_logic;
      --FPGA_LED5_R       : out    std_logic;
      --FPGA_LED5_G       : out    std_logic;      
         -- Button
      FPGA_BTN          : in     std_logic;
         -- Switch
      --FPGA_SW           : in     std_logic_vector(3 downto 0);
         -- Buzzer
      BUZZER            : out    std_logic;
         -- GPIO 
      FPGA_GPIO         : inout  std_logic_vector(7 downto 0);
         -- Temperature sensor
      LM75_OS           : in     std_logic;
         -- Fan control 
      FAN_CTRL          : out    std_logic;
         -- Phase detector
      ADF_MUXOUT        : in     std_logic;
         -- Power
      --FPGA_EN_REG       : out    std_logic;
      --FPGA_PWR_MON      : in     std_logic;
         -- Bill Of material and hardware version 
      BOM_VER           : in     std_logic_vector(3 downto 0);
      HW_VER            : in     std_logic_vector(2 downto 0)
   );
end lms7_trx_top;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of lms7_trx_top is
--declare signals,  components here
signal reset_n                   : std_logic; 
signal reset_n_ft_clk            : std_logic;
signal reset_n_lmk_clk           : std_logic;

-- internal signals
signal int_FPGA_SPI_DAC_SS       : std_logic;
signal int_FPGA_SPI_ADF_SS       : std_logic;
signal int_FPGA_SPI_FLASH_SS     : std_logic;

--inst0 (NIOS CPU instance)
signal inst0_exfifo_if_rd        : std_logic;
signal inst0_exfifo_of_d         : std_logic_vector(FTDI_DQ_WIDTH-1 downto 0);
signal inst0_exfifo_of_wr        : std_logic;
signal inst0_exfifo_of_rst       : std_logic;
signal inst0_gpo                 : std_logic_vector(7 downto 0);
signal inst0_lms_ctr_gpio        : std_logic_vector(3 downto 0);
signal inst0_spi_0_MISO          : std_logic;
signal inst0_spi_0_MOSI          : std_logic;
signal inst0_spi_0_SCLK          : std_logic;
signal inst0_spi_0_SS_n          : std_logic_vector(4 downto 0);
signal inst0_spi_1_MISO          : std_logic;
signal inst0_spi_1_MOSI          : std_logic;
signal inst0_spi_1_SCLK          : std_logic;
signal inst0_spi_1_SS_n          : std_logic_vector(1 downto 0);
signal inst0_from_fpgacfg        : t_FROM_FPGACFG;
signal inst0_to_fpgacfg          : t_TO_FPGACFG;
signal inst0_from_pllcfg         : t_FROM_PLLCFG;
signal inst0_to_pllcfg           : t_TO_PLLCFG;
signal inst0_from_tstcfg         : t_FROM_TSTCFG;
signal inst0_to_tstcfg           : t_TO_TSTCFG;
signal inst0_from_periphcfg      : t_FROM_PERIPHCFG;
signal inst0_to_periphcfg        : t_TO_PERIPHCFG;
signal inst0_cfg_top_CS          : std_logic;
signal inst0_avm_m0_address      : std_logic_vector(7 downto 0);
signal inst0_avm_m0_read         : std_logic;
signal inst0_avm_m0_write        : std_logic;
signal inst0_avm_m0_writedata    : std_logic_vector(7 downto 0);
signal inst0_avm_m0_clk_clk      : std_logic;
signal inst0_avm_m0_reset_reset  : std_logic;
signal inst0_uart_txd            : std_logic;
signal inst0_cfg_top_or_lms_ctrl_MISO  : std_logic;

--inst1 (pll_top instance)
signal inst1_pll_c1              : std_logic;
signal inst1_pll_c3              : std_logic;
signal inst1_pll_locked          : std_logic;
signal inst1_pll_smpl_cmp_en     : std_logic;
signal inst1_pll_smpl_cmp_cnt    : std_logic_vector(15 downto 0);

--inst2
constant C_EP02_RDUSEDW_WIDTH    : integer := FIFO_WORDS_TO_Nbits(CTRL0_FPGA_RX_SIZE/(CTRL0_FPGA_RX_RWIDTH/8),true);
constant C_EP82_WRUSEDW_WIDTH    : integer := FIFO_WORDS_TO_Nbits(CTRL0_FPGA_TX_SIZE/(CTRL0_FPGA_TX_WWIDTH/8),true);
constant C_EP03_RDUSEDW_WIDTH    : integer := FIFO_WORDS_TO_Nbits(STRM0_FPGA_RX_SIZE/(STRM0_FPGA_RX_RWIDTH/8),true);
constant C_EP83_WRUSEDW_WIDTH    : integer := FIFO_WORDS_TO_Nbits(STRM0_FPGA_TX_SIZE/(STRM0_FPGA_TX_WWIDTH/8),true);
signal inst2_ext_buff_data       : std_logic_vector(FTDI_DQ_WIDTH-1 downto 0);
signal inst2_ext_buff_wr         : std_logic;
signal inst2_EP82_wfull          : std_logic;
signal inst2_EP82_wrusedw        : std_logic_vector(C_EP82_WRUSEDW_WIDTH-1 downto 0);
signal inst2_EP03_rdata          : std_logic_vector(STRM0_FPGA_RX_RWIDTH-1 downto 0);
signal inst2_EP03_rempty         : std_logic;
signal inst2_EP03_rdusedw        : std_logic_vector(C_EP03_RDUSEDW_WIDTH-1 downto 0);
signal inst2_EP83_wfull          : std_logic := '0';
signal inst2_EP83_wrusedw        : std_logic_vector(C_EP83_WRUSEDW_WIDTH-1 downto 0);
signal inst2_GPIF_busy           : std_logic;
signal inst2_faddr               : std_logic_vector(4 downto 0);
signal inst2_EP02_rdata          : std_logic_vector(CTRL0_FPGA_RX_RWIDTH-1 downto 0);
signal inst2_EP02_rempty         : std_logic := '1';
signal inst2_EP02_rdusedw        : std_logic_vector(C_EP02_RDUSEDW_WIDTH-1 downto 0);
signal inst2_EP_act              : std_logic;

--inst4
constant C_INST4_GPIO_N          : integer := 10; --FPGA_GPIO'length + FPGA_EGPIO'length;
signal inst4_gpio                : std_logic_vector(C_INST4_GPIO_N-1 downto 0);
signal inst4_led1_g              : std_logic;
signal inst4_led1_r              : std_logic;
signal inst4_led2_g              : std_logic;
signal inst4_led2_r              : std_logic;
signal inst4_led3_g              : std_logic;
signal inst4_led3_r              : std_logic;
signal FPGA_LED1_G,FPGA_LED1_R   : std_logic;
signal FPGA_LED2_G,FPGA_LED2_R   : std_logic;
signal FPGA_LED3_G,FPGA_LED3_R   : std_logic;
signal FPGA_LED4_G,FPGA_LED4_R   : std_logic;
signal FPGA_LED5_G,FPGA_LED5_R   : std_logic;


--inst5
signal inst5_busy : std_logic;

--inst6
signal inst6_tx_pct_loss_flg        : std_logic;
signal inst6_tx_txant_en            : std_logic;
signal inst6_tx_in_pct_full         : std_logic;
signal inst6_rx_pct_fifo_wrreq      : std_logic;
signal inst6_rx_pct_fifo_wdata      : std_logic_vector(63 downto 0);
signal inst6_rx_smpl_cmp_done       : std_logic;
signal inst6_rx_smpl_cmp_err        : std_logic;
signal inst6_to_tstcfg_from_rxtx    : t_TO_TSTCFG_FROM_RXTX;
signal inst6_rx_pct_fifo_aclrn_req  : std_logic;
signal inst6_tx_in_pct_rdreq        : std_logic;
signal inst6_tx_in_pct_reset_n_req  : std_logic;
signal inst6_wfm_in_pct_reset_n_req : std_logic;
signal inst6_wfm_in_pct_rdreq       : std_logic;
signal inst6_wfm_phy_clk            : std_logic;

signal rpi_S1CE2: std_logic;
signal RAPI_SPI1_CE3_int            : std_logic;

signal beat : std_logic;

--inst7
signal inst7_sdout                  : std_logic;
signal inst7_en                     : std_logic;
signal inst7_mm_rd_data             : std_logic_vector(7 downto 0);
signal inst7_mm_rd_datav            : std_logic;
signal inst7_mm_wait_req            : std_logic;
signal inst7_mm_irq                 : std_logic;
signal inst7_uart_tx                : std_logic;
signal inst7_fpga_led_g             : std_logic;
signal inst7_fpga_led_r             : std_logic;

--inst9
signal inst9_data                   : std_logic_vector(31 downto 0);

signal eth_led1                     : std_logic;
signal eth_led2                     : std_logic;


begin

-- ----------------------------------------------------------------------------
--SPI MODULE FOR GSMBOARD
-- ----------------------------------------------------------------------------
--   ints0_spimodule : entity work.spi_module 
--   port map(
--      MISO                    => RAPI_SPI0_MISO,
--      MOSI                    => RAPI_SPI0_MOSI,
--      MCLK                    => RAPI_SPI0_SCLK,
--      CS                      => RAPI_SPI0_CE0,
--      reset_n                 => reset_n,
--      clk30_72mhz             => LMK_CLK,
--      tx_fifo_rdclk           => inst1_pll_c1,
--      tx_fifo_reset_n         => inst6_tx_in_pct_reset_n_req,
--      tx_fifo_q               => inst2_EP03_rdata,
--      tx_fifo_rdempty         => inst2_EP03_rempty,
--      tx_fifo_rdusedw         => inst2_EP03_rdusedw,
--      tx_fifo_rdreq           => inst6_tx_in_pct_rdreq,
--      rx_fifo_reset_n         => inst6_rx_pct_fifo_aclrn_req,
--      rx_fifo_wrclk           => inst1_pll_c3,
--      rx_fifo_data            => inst6_rx_pct_fifo_wdata,
--      rx_fifo_wrreq           => inst6_rx_pct_fifo_wrreq,
--      rx_fifo_wrusedw         => inst2_EP83_wrusedw,
--      data_request_interrupt  => RAPI_GPIO12 -- Connect rapi interrupt pin
--   );
-- ----------------------------------------------------------------------------
-- Reset logic
-- ----------------------------------------------------------------------------
   -- Reset from FPGA pin. 
   reset_n <= not HW_VER(2);
   
      -- Reset signal with synchronous removal to FTDI_PCLK clock domain, 
   sync_reg0 : entity work.sync_reg 
   port map(FT_CLK, reset_n, '1', reset_n_ft_clk);
   
   sync_reg1 : entity work.sync_reg 
   port map(LMK_CLK, reset_n, '1', reset_n_lmk_clk);   

-- ----------------------------------------------------------------------------
-- NIOS CPU instance.
-- CPU is responsible for communication interfaces and control logic
-- ----------------------------------------------------------------------------
   -- TODO: FIX SWitch input to gpi
   inst0_nios_cpu : entity work.nios_cpu
   generic map (
      FPGACFG_START_ADDR   => FPGACFG_START_ADDR,
      PLLCFG_START_ADDR    => PLLCFG_START_ADDR,
      TSTCFG_START_ADDR    => TSTCFG_START_ADDR,
      PERIPHCFG_START_ADDR => PERIPHCFG_START_ADDR
   )
   port map(
      clk                        => LMK_CLK,
      reset_n                    => reset_n_lmk_clk,
      -- Control data FIFO
      exfifo_if_d                => inst2_EP02_rdata,
      exfifo_if_rd               => inst0_exfifo_if_rd, 
      exfifo_if_rdempty          => inst2_EP02_rempty,
      exfifo_of_d                => inst0_exfifo_of_d, 
      exfifo_of_wr               => inst0_exfifo_of_wr, 
      exfifo_of_wrfull           => inst2_EP82_wfull,
      exfifo_of_rst              => inst0_exfifo_of_rst, 
      -- SPI 0 
      spi_0_MISO                 => FPGA_SPI_MISO,
      spi_0_MOSI                 => inst0_spi_0_MOSI,
      spi_0_SCLK                 => inst0_spi_0_SCLK,
      spi_0_SS_n                 => inst0_spi_0_SS_n,
      -- SPI 1
      spi_1_MISO                 => FPGA_SPI_MISO,
      spi_1_MOSI                 => inst0_spi_1_MOSI,
      spi_1_SCLK                 => inst0_spi_1_SCLK,
      spi_1_SS_n                 => inst0_spi_1_SS_n,
      -- I2C
      i2c_scl                    => FPGA_I2C_SCL,
      i2c_sda                    => FPGA_I2C_SDA,
      -- Genral purpose I/O
      --gpi                        => "0000" & FPGA_SW(3 downto 1) &  (FPGA_SW(0) AND NOT inst0_from_tstcfg.BOOT_EN),
      gpi                        => "0000" & "000" &  ('0' AND NOT inst0_from_tstcfg.BOOT_EN),
      gpo                        => inst0_gpo, 
      -- LMS7002 control 
      lms_ctr_gpio               => inst0_lms_ctr_gpio,
      -- Configuration registers
      from_fpgacfg               => inst0_from_fpgacfg,
      to_fpgacfg                 => inst0_to_fpgacfg,
      from_pllcfg                => inst0_from_pllcfg,
      to_pllcfg                  => inst0_to_pllcfg,
      from_tstcfg                => inst0_from_tstcfg,
      to_tstcfg                  => inst0_to_tstcfg,
      to_tstcfg_from_rxtx        => inst6_to_tstcfg_from_rxtx,
      from_periphcfg             => inst0_from_periphcfg,
      to_periphcfg               => inst0_to_periphcfg,
      
      cfg_top_MOSI               => RAPI_SPI1_MOSI,
      cfg_top_SCLK               => RAPI_SPI1_SCLK,
      cfg_top_CS                 => RAPI_SPI1_CE0,--RAPI_SPI1_CE2,
      cfg_top_or_lms_ctrl_MISO   => inst0_cfg_top_or_lms_ctrl_MISO,
      vctcxo_tune_en             => inst7_en,
      vctcxo_irq                 => inst7_mm_irq,
      avm_m0_address             => inst0_avm_m0_address,
      avm_m0_read                => inst0_avm_m0_read,
      avm_m0_waitrequest         => inst7_mm_wait_req,
      avm_m0_readdata            => inst7_mm_rd_data,
      avm_m0_readdatavalid       => inst7_mm_rd_datav,
      avm_m0_write               => inst0_avm_m0_write,
      avm_m0_writedata           => inst0_avm_m0_writedata,
      avm_m0_clk_clk             => inst0_avm_m0_clk_clk,
      avm_m0_reset_reset         => inst0_avm_m0_reset_reset
      
      
   );
   
   --rpi_S1CE2 <= '0' when RAPI_SPI1_CE0 = '1' and RAPI_SPI1_CE1 = '1' else '1'; --workaround for insufficient amount of LimeSDR-mini fpga gpio pins
   --RAPI_SPI1_CE3_int <= '0' when (RAPI_SPI1_CE0 = '1' AND 
   --                              RAPI_SPI1_CE1 = '1' AND 
   --                              RAPI_SPI1_CE2 = '1') else '1'; --workaround for insufficient amount of LimeSDR-mini fpga gpio pins
   
   -- TODO: Change spi CE control from FPGA registers
   RAPI_SPI1_CE3_int <= '0' when (RAPI_SPI1_CE0 = '1') else '1'; --workaround for insufficient amount of LimeSDR-mini fpga gpio pins
   
   inst0_to_fpgacfg.HW_VER    <= '0' & HW_VER;
   inst0_to_fpgacfg.BOM_VER   <= BOM_VER; 
   inst0_to_fpgacfg.PWR_SRC   <= '0';
   
   RAPI_SPI1_MISO             <= inst0_cfg_top_or_lms_ctrl_MISO OR inst7_sdout OR FPGA_SPI_MISO;
   
-- ----------------------------------------------------------------------------
-- pll_top instance.
-- Clock source for LMS7002 RX and TX logic
-- ----------------------------------------------------------------------------   
   inst1_pll_top : entity work.pll_top
   generic map(
      N_PLL                   => 1,
      -- PLL parameters       
      BANDWIDTH_TYPE          => "AUTO",
      CLK0_DIVIDE_BY          => 1,
      CLK0_DUTY_CYCLE         => 50,
      CLK0_MULTIPLY_BY        => 1,
      CLK0_PHASE_SHIFT        => "0",
      CLK1_DIVIDE_BY          => 1,
      CLK1_DUTY_CYCLE         => 50,
      CLK1_MULTIPLY_BY        => 1,
      CLK1_PHASE_SHIFT        => "0",
      CLK2_DIVIDE_BY          => 1,
      CLK2_DUTY_CYCLE         => 50,
      CLK2_MULTIPLY_BY        => 1,
      CLK2_PHASE_SHIFT        => "0",
      CLK3_DIVIDE_BY          => 1,
      CLK3_DUTY_CYCLE         => 50,
      CLK3_MULTIPLY_BY        => 1,
      CLK3_PHASE_SHIFT        => "0",
      COMPENSATE_CLOCK        => "CLK3",
      INCLK0_INPUT_FREQUENCY  => 6250,
      INTENDED_DEVICE_FAMILY  => "MAX 10",
      OPERATION_MODE          => "NORMAL",
      SCAN_CHAIN_MIF_FILE     => "ip/pll/pll.mif",
      DRCT_C0_NDLY            => 1,
      DRCT_C1_NDLY            => 8,
      DRCT_C2_NDLY            => 1,
      DRCT_C3_NDLY            => 8
   )
   port map(
      -- PLL ports
      pll_inclk            => LMS_MCLK2,
      pll_reconfig_clk     => LMK_CLK,
      pll_logic_reset_n    => reset_n,
      pll_clk_ena          => inst0_from_fpgacfg.CLK_ENA(3 downto 0),
      pll_drct_clk_en      => inst0_from_fpgacfg.drct_clk_en(0) & inst0_from_fpgacfg.drct_clk_en(0) & inst0_from_fpgacfg.drct_clk_en(0) & inst0_from_fpgacfg.drct_clk_en(0),
      pll_c0               => LMS_FCLK1,
      pll_c1               => inst1_pll_c1,
      pll_c2               => LMS_FCLK2,
      pll_c3               => inst1_pll_c3,
      pll_locked           => inst1_pll_locked,
      pll_smpl_cmp_en      => inst1_pll_smpl_cmp_en,      
      pll_smpl_cmp_done    => inst6_rx_smpl_cmp_done,
      pll_smpl_cmp_error   => inst6_rx_smpl_cmp_err,
      pll_smpl_cmp_cnt     => inst1_pll_smpl_cmp_cnt,       
      -- pllcfg ports
      from_pllcfg          => inst0_from_pllcfg,
      to_pllcfg            => inst0_to_pllcfg
   );
   
	

	

	
-- ----------------------------------------------------------------------------
-- FT601_top instance.
-- USB3 interface 
-- ----------------------------------------------------------------------------
   inst2_FT601_top : entity work.FT601_top
   generic map(
      FT_data_width        => FTDI_DQ_WIDTH,
      FT_be_width          => FTDI_DQ_WIDTH/8,
      EP02_rdusedw_width   => C_EP02_RDUSEDW_WIDTH, 
      EP02_rwidth          => CTRL0_FPGA_RX_RWIDTH,
      EP82_wrusedw_width   => C_EP82_WRUSEDW_WIDTH,
      EP82_wwidth          => CTRL0_FPGA_TX_WWIDTH,
      EP82_wsize           => 64,  --packet size in bytes, has to be multiple of 4 bytes
      EP03_rdusedw_width   => C_EP03_RDUSEDW_WIDTH,    
      EP03_rwidth          => STRM0_FPGA_RX_RWIDTH,
      EP83_wrusedw_width   => C_EP83_WRUSEDW_WIDTH,
      EP83_wwidth          => STRM0_FPGA_TX_WWIDTH,
      EP83_wsize           => 2048 --packet size in bytes, has to be multiple of 4 bytes	
   )
   port map(
      --input ports 
      clk            => FT_CLK,   --FTDI CLK
      reset_n        => reset_n,
      --FTDI external ports
      FT_wr_n        => FT_WRn,
      FT_rxf_n       => FT_RXFn,
      FT_data        => FT_D,
      FT_be          => FT_BE,
      FT_txe_n       => FT_TXEn,
      --controll endpoint fifo PC->FPGA 
      EP02_rdclk     => LMK_CLK, 
      EP02_rd        => inst0_exfifo_if_rd,
      EP02_rdata     => inst2_EP02_rdata,
      EP02_rempty    => inst2_EP02_rempty,
      --controll endpoint fifo FPGA->PC
      EP82_wclk      => LMK_CLK,
      EP82_aclrn     => not inst0_exfifo_of_rst,
      EP82_wr        => inst0_exfifo_of_wr,
      EP82_wdata     => inst0_exfifo_of_d,
      EP82_wfull     => inst2_EP82_wfull,
      --stream endpoint fifo PC->FPGA
      EP03_aclrn_0   => inst0_from_fpgacfg.rx_en,
      EP03_aclrn_1   => inst6_tx_in_pct_reset_n_req,
      EP03_rdclk     => inst1_pll_c1,
      EP03_rd        => inst6_tx_in_pct_rdreq,
      EP03_rdata     => inst2_EP03_rdata,
      EP03_rempty    => inst2_EP03_rempty,
      EP03_rusedw    => inst2_EP03_rdusedw,
      --stream endpoint fifo FPGA->PC
      EP83_wclk      => inst1_pll_c3, 
      EP83_aclrn     => inst6_rx_pct_fifo_aclrn_req,
      EP83_wr        => inst6_rx_pct_fifo_wrreq,
      EP83_wdata     => inst6_rx_pct_fifo_wdata,
      EP83_wfull     => inst2_EP83_wfull,
      EP83_wrusedw   => inst2_EP83_wrusedw,
      -- status
      EP_act         => inst2_EP_act
   );

-- ----------------------------------------------------------------------------
-- tst_top instance.
-- Clock test logic
-- ----------------------------------------------------------------------------
   inst3_tst_top : entity work.tst_top
   port map(
      --input ports 
      FX3_clk           => FT_CLK,
      reset_n           => reset_n_ft_clk,    
      Si5351C_clk_0     => '0',
      Si5351C_clk_1     => '0',
      Si5351C_clk_2     => '0',
      Si5351C_clk_3     => '0',
      Si5351C_clk_5     => '0',
      Si5351C_clk_6     => '0',
      Si5351C_clk_7     => '0',
      LMK_CLK           => LMK_CLK,
      ADF_MUXOUT        => ADF_MUXOUT,    
   
      -- To configuration memory
      to_tstcfg         => inst0_to_tstcfg,
      from_tstcfg       => inst0_from_tstcfg
   );
   
-- ----------------------------------------------------------------------------
-- general_periph_top instance.
-- Control module for external periphery
-- ----------------------------------------------------------------------------
   inst4_general_periph_top : entity work.general_periph_top
   generic map(
      DEV_FAMILY        => DEV_FAMILY,
      N_GPIO            => C_INST4_GPIO_N,
      led1_active_lvl   => '0',
      led2_active_lvl   => '0',
      led3_active_lvl   => '0',
      led4_active_lvl   => '0',
      led5_active_lvl   => '0'
   )
   port map(
      -- General ports
      clk                  => LMK_CLK,
      reset_n              => reset_n_lmk_clk,
      -- configuration memory
      to_periphcfg         => inst0_to_periphcfg,
      from_periphcfg       => inst0_from_periphcfg,     
      -- Dual colour LEDs
      -- LED1 ( Raspberry eMMC enable )
      led1_in_g            => RAPI_EMMC_EN,
      led1_in_r            => inst5_busy,
      led1_ctrl            => inst0_from_fpgacfg.FPGA_LED1_CTRL,
      led1_out_g           => FPGA_LED1_G,
      led1_out_r           => FPGA_LED1_R,
      
      -- LED2 ( FTDI and NIOS busy )
      led2_in_g            => NOT ETH_GPIO1,
      led2_in_r            => NOT WIFI_PIO5,
      led2_ctrl            => inst0_from_fpgacfg.FPGA_LED2_CTRL,
      led2_out_g           => FPGA_LED2_G,
      led2_out_r           => FPGA_LED2_R,
      led2_hw_ver          => "0011",
      
      
      -- LED3 ( Clock and PLL lock )
      led3_ctrl            => inst0_from_fpgacfg.FPGA_LED3_CTRL,
      led3_out_g           => FPGA_LED3_G,
      led3_out_r           => FPGA_LED3_R,
      led3_pll1_locked     => inst1_pll_locked,
      led3_pll2_locked     => inst1_pll_locked,
      
      
      -- LED4 ( TCXO control status )
      led4_ctrl            => inst0_from_fpgacfg.FPGA_LED4_CTRL,
      led4_out_g           => FPGA_LED4_G,
      led4_out_r           => FPGA_LED4_R,
                           
      led4_clk             => inst0_spi_0_SCLK,
      led4_adf_muxout      => ADF_MUXOUT,
      led4_dac_ss          => inst0_spi_0_SS_n(2),
      led4_adf_ss          => inst0_spi_0_SS_n(3),
      led4_gnss_en         => inst7_en,
      
      
      -- LED5 ( GNSS status )
      led5_in_g            => inst7_fpga_led_g,
      led5_in_r            => inst7_fpga_led_r,
      led5_ctrl            => inst0_from_fpgacfg.FPGA_LED5_CTRL,
      led5_out_g           => FPGA_LED5_G,
      led5_out_r           => FPGA_LED5_R,
      --GPIO
      gpio_dir             => (others=>'1'),
      gpio_out_val         => "000000000" & inst1_pll_locked,
      gpio_rd_val          => open,
      gpio                 => inst4_gpio,      
      --Fan control
      fan_sens_in          => LM75_OS,
      fan_ctrl_out         => FAN_CTRL,
      
      --Button
      FPGA_BTN             => NOT FPGA_BTN,
      
      --Buzzer
      Buzzer_en            => '0',
      Buzzer               => BUZZER
   );
   
      inst5_busy_delay : entity work.busy_delay
   generic map(
      clock_period   => 10,  -- 10ns = 100MHz
      delay_time     => 200  -- delay time in ms
      --counter_value=delay_time*1000/clock_period<2^32
      --delay counter is 32bit wide, 
   )
   port map(
      --input ports 
      clk      => FT_CLK,
      reset_n  => reset_n_ft_clk,
      busy_in  => inst2_EP_act,
      busy_out => inst5_busy
   );
   
   -- ----------------------------------------------------------------------------
-- rxtx_top instance.
-- Receive and transmit interface for LMS7002
-- ----------------------------------------------------------------------------
   inst6_rxtx_top : entity work.rxtx_top
   generic map(
      DEV_FAMILY              => DEV_FAMILY,
      -- TX parameters
      TX_IQ_WIDTH             => LMS_DIQ_WIDTH,
      TX_N_BUFF               => TX_N_BUFF,              -- 2,4 valid values
      TX_IN_PCT_SIZE          => TX_PCT_SIZE,
      TX_IN_PCT_HDR_SIZE      => TX_IN_PCT_HDR_SIZE,
      TX_IN_PCT_DATA_W        => STRM0_FPGA_RX_RWIDTH,      -- 
      TX_IN_PCT_RDUSEDW_W     => C_EP03_RDUSEDW_WIDTH,
      
      -- RX parameters
      RX_IQ_WIDTH             => LMS_DIQ_WIDTH,
      RX_INVERT_INPUT_CLOCKS  => "ON",
      RX_PCT_BUFF_WRUSEDW_W   => C_EP83_WRUSEDW_WIDTH --bus width in bits 
      
   )
   port map(                                             
      from_fpgacfg            => inst0_from_fpgacfg,
      to_tstcfg_from_rxtx     => inst6_to_tstcfg_from_rxtx,
      from_tstcfg             => inst0_from_tstcfg,
      
      -- TX module signals
      tx_clk                  => inst1_pll_c1,
      tx_clk_reset_n          => inst1_pll_locked,     
      tx_pct_loss_flg         => inst6_tx_pct_loss_flg,
      tx_txant_en             => inst6_tx_txant_en,  
      --Tx interface data 
      tx_DIQ                  => LMS_DIQ1_D,
      tx_fsync                => LMS_ENABLE_IQSEL1,
      --fifo ports
      tx_in_pct_reset_n_req   => inst6_tx_in_pct_reset_n_req,
      tx_in_pct_rdreq         => inst6_tx_in_pct_rdreq,
      tx_in_pct_data          => inst2_EP03_rdata,
      tx_in_pct_rdempty       => inst2_EP03_rempty,
      tx_in_pct_rdusedw       => inst2_EP03_rdusedw,
      
      -- RX path
      rx_clk                  => inst1_pll_c3,
      rx_clk_reset_n          => inst1_pll_locked,
      --Rx interface data 
      rx_DIQ                  => LMS_DIQ2_D,
      rx_fsync                => LMS_ENABLE_IQSEL2,
      --Packet fifo ports
      rx_pct_fifo_aclrn_req   => inst6_rx_pct_fifo_aclrn_req,
      rx_pct_fifo_wusedw      => inst2_EP83_wrusedw,
      rx_pct_fifo_wrreq       => inst6_rx_pct_fifo_wrreq,
      rx_pct_fifo_wdata       => inst6_rx_pct_fifo_wdata,
      --sample compare
      rx_smpl_cmp_start       => inst1_pll_smpl_cmp_en,
      rx_smpl_cmp_length      => inst1_pll_smpl_cmp_cnt,
      rx_smpl_cmp_done        => inst6_rx_smpl_cmp_done,
      rx_smpl_cmp_err         => inst6_rx_smpl_cmp_err     
   );
 
 
   -- TODO: connect spi line sen
   inst7_limegnss_gpio_top : entity work.limegnss_gpio_top
   generic map( 
      UART_BAUD_RATE          => 9600,
      VCTCXO_CLOCK_FREQUENCY  => 30720000,
      MM_CLOCK_FREQUENCY      => 30720000
   )
   port map(
      areset_n          => reset_n,
      -- SPI interface
      -- Address and location of SPI memory module
      -- Will be hard wired at the top level
      tamercfg_maddress => "0000000111",
      gnsscfg_maddress  => "0000001000",
      -- Serial port IOs
      sdin              => inst0_spi_0_MOSI,    -- Data in
      sclk              => inst0_spi_0_SCLK,    -- Data clock
      sen               => inst0_spi_0_SS_n(1), -- Enable signal (active low)
      sdout             => inst7_sdout,            -- Data out 
      -- Signals coming from the pins or top level serial interface
      lreset            => reset_n,    -- Logic reset signal, resets logic cells only  (use only one reset)
      mreset            => reset_n,    -- Memory reset signal, resets configuration memory only (use only one reset)
      vctcxo_clk        => LMK_CLK,    -- Clock from VCTCXO       
      --LimeGNSS-GPIO pins
      gnss_tx           => open,   
      gnss_rx           => GNSS_UART_TX,  
      gnss_tpulse       => GNSS_TPULSE,   
      gnss_fix          => '0',           
      fpga_led_g        => inst7_fpga_led_g,
      fpga_led_r        => inst7_fpga_led_r, 
      -- NIOS PIO
      en                => inst7_en,     
      -- NIOs  Avalon-MM Interface (External master)
      mm_clock          => inst0_avm_m0_clk_clk,
      mm_reset          => inst0_avm_m0_reset_reset,
      mm_rd_req         => inst0_avm_m0_read,
      mm_wr_req         => inst0_avm_m0_write,
      mm_addr           => inst0_avm_m0_address,
      mm_wr_data        => inst0_avm_m0_writedata,
      mm_rd_data        => inst7_mm_rd_data,
      mm_rd_datav       => inst7_mm_rd_datav,
      mm_wait_req       => inst7_mm_wait_req,
      -- Avalon Interrupts
      mm_irq            => inst7_mm_irq,
      
      -- Testing (UART logger)
      fan_ctrl_in       => '0',
      uart_tx           => inst7_uart_tx
      
   ); 
   
   
   eth_led1 <= ETH_GPIO2 when inst0_from_periphcfg.PERIPH_OUTPUT_OVRD_0(2) = '0' else inst0_from_periphcfg.PERIPH_OUTPUT_VAL_0(2);
   eth_led2 <= ETH_GPIO1 when inst0_from_periphcfg.PERIPH_OUTPUT_OVRD_0(3) = '0' else inst0_from_periphcfg.PERIPH_OUTPUT_VAL_0(3);
   
-- ----------------------------------------------------------------------------
-- Shift registers
-- ----------------------------------------------------------------------------
   -- Raspberry activity
   inst9_data( 0) <= FPGA_LED1_R;
   inst9_data( 1) <= FPGA_LED1_G;
   -- FTDI activity
   inst9_data( 2) <= FPGA_LED2_R;
   inst9_data( 3) <= FPGA_LED2_G;
   -- FPGA alive and PLL lock
   inst9_data( 4) <= FPGA_LED3_R;
   inst9_data( 5) <= FPGA_LED3_G;
   -- VCTCXO tamer tune state
   inst9_data( 6) <= FPGA_LED4_R;
   inst9_data( 7) <= FPGA_LED4_G;
   
   inst9_data( 8) <= FPGA_LED5_R;    
   inst9_data( 9) <= FPGA_LED5_G;    
   inst9_data(10) <= eth_led1;               -- ETH_LED1       
   inst9_data(11) <= eth_led2;               -- ETH_LED2       
   inst9_data(12) <= inst0_from_fpgacfg.LMS1_RESET AND inst0_lms_ctr_gpio(0); -- LMS_RESET      
   inst9_data(13) <= inst0_from_fpgacfg.LMS1_CORE_LDO_EN;   -- LMS_CORE_LDO_EN
   inst9_data(14) <= inst0_from_fpgacfg.LMS1_RXEN;          -- LMS_RXEN       
   inst9_data(15) <= inst0_from_fpgacfg.LMS1_TXEN;          -- LMS_TXEN       
   inst9_data(16) <= int_FPGA_SPI_ADF_SS;    -- FPGA_SPI_ADF_SS  
   inst9_data(17) <= int_FPGA_SPI_DAC_SS;    -- FPGA_SPI_DAC_SS  
   inst9_data(18) <= int_FPGA_SPI_FLASH_SS;  -- FPGA_SPI_FLASH_SS
   inst9_data(19) <= '1'; -- ETH_AUTOMDIX_EN  
   inst9_data(20) <= '1'; -- ETH_NRESET       
   inst9_data(21) <= '1'; -- FT_RESETn        
   inst9_data(22) <= '1'; -- RAPI_RUN         
   inst9_data(23) <= '0'; -- -                  
   inst9_data(24) <= inst0_from_fpgacfg.GPIO(12);  -- RFSW_TX_V1
   inst9_data(25) <= inst0_from_fpgacfg.GPIO(13);  -- RFSW_TX_V2
   inst9_data(26) <= inst0_from_fpgacfg.GPIO(8);   -- RFSW_RX_V1
   inst9_data(27) <= inst0_from_fpgacfg.GPIO(9);   -- RFSW_RX_V2
   inst9_data(28) <= '0'; -- -
   inst9_data(29) <= '0'; -- - 
   inst9_data(30) <= '0'; -- - 
   inst9_data(31) <= '0'; -- -

   inst9_IC_74HC595_top : entity work.IC_74HC595_top
   port map(
      clk      => LMK_CLK,
      reset_n  => reset_n_lmk_clk,
      data     => inst9_data,
      busy     => open, 
      
      SHCP     => SR_SCLK,    -- shift register clock
      STCP     => SR_LATCH,   -- storage register clock
      DS       => SR_DIN      -- serial data
   );   
-- ----------------------------------------------------------------------------
-- Output ports
-- ----------------------------------------------------------------------------

   -- FPGA_SPI (LMS, DAC, ADF, FLASH) 
   FPGA_SPI_SCLK    <=  inst0_spi_1_SCLK when inst0_spi_1_SS_n(0) = '0' else inst0_spi_0_SCLK;                                  
   FPGA_SPI_MOSI    <=  inst0_spi_1_MOSI when inst0_spi_1_SS_n(0) = '0' else inst0_spi_0_MOSI;                      
   FPGA_SPI_LMS_SS  <=  inst0_spi_0_SS_n(0); --RAPI_SPI1_CE1;
   int_FPGA_SPI_DAC_SS  <= inst0_spi_0_SS_n(2);
   
   int_FPGA_SPI_ADF_SS  <= inst0_spi_0_SS_n(3);
  
   int_FPGA_SPI_FLASH_SS<= inst0_spi_1_SS_n(0); 
   
   
   -- FPGA_SPI (DAC, ADF)
      --When VCTCXO tamer is enabled, DAC is controlled from NIOS. 
      --Workaround for negative polarity clock for DAC when controlled from RAPI
      --Positive polarity 
--   FPGA_SPI_SCLK    <= inst0_spi_0_SCLK   when inst0_spi_0_SS_n(2) = '0' else
--                        not RAPI_SPI1_SCLK when RAPI_SPI1_CE0 = '0' else 
--                        RAPI_SPI1_SCLK;
--                                                                     
--   FPGA_SPI_MOSI    <= inst0_spi_0_MOSI  when inst0_spi_0_SS_n(2) = '0' else 
--                        RAPI_SPI1_MOSI;
                        
   --FPGA_SPI_DAC_SS  <= RAPI_SPI1_CE0     when inst7_en = '0' else 
   --                     inst0_spi_0_SS_n(2);
   
   --FPGA_SPI_ADF_SS  <= RAPI_SPI1_CE3_int; 
   
   -- FPGA_QSPI (Flash)
--   FPGA_QSPI_SCLK    <= inst0_spi_1_SCLK;
--   FPGA_QSPI_IO0     <= inst0_spi_1_MOSI;
--   FPGA_QSPI_IO2     <= '1';
--   FPGA_QSPI_IO3     <= '1';
--   FPGA_QSPI_FLASH_SS<= inst0_spi_1_SS_n(0);
   
   -- LMS MISC
   --LMS_RESET         <= inst0_from_fpgacfg.LMS1_RESET;-- AND inst0_lms_ctr_gpio(0);
   --LMS_TXEN          <= inst0_from_fpgacfg.LMS1_TXEN;
   --LMS_RXEN          <= inst0_from_fpgacfg.LMS1_RXEN;
   --LMS_CORE_LDO_EN   <= inst0_from_fpgacfg.LMS1_CORE_LDO_EN;
   LMS_TXNRX1        <= inst0_from_fpgacfg.LMS1_TXNRX1;
   LMS_TXNRX2        <= inst0_from_fpgacfg.LMS1_TXNRX2;

   -- Ethernet
   --ETH_NRESET        <= '1';
   --ETH_AUTOMDIX_EN   <= '1';  
   
   -- Instantiating OPNDRN
--   inst0_OPNDRN : OPNDRN
--   port map (a_in => ETH_GPIO0, a_out => ETH_LED1);
   
--   inst1_OPNDRN : OPNDRN
--   port map (a_in => ETH_GPIO1, a_out => ETH_LED2);
   
   -- LEDS
   --FPGA_LED1_R <= RAPI_EMMC_EN;     -- Raspberry activity
   --FPGA_LED1_G <= NOT RAPI_EMMC_EN;
   --FPGA_LED2_R <= inst4_led1_r;     -- FPGA PLL lock
   --FPGA_LED2_G <= inst4_led1_g;
   --FPGA_LED3_R <= inst7_fpga_led_r; -- VCTCXO tamer status
   --FPGA_LED3_G <= inst7_fpga_led_g; 
   --FPGA_LED4_R <= ETH_GPIO1;        -- Ethernet status (active low)
   --FPGA_LED4_G <= not ETH_GPIO1;
   --FPGA_LED5_R <= ETH_GPIO2;
   --FPGA_LED5_G <= not ETH_GPIO2;

   
   --Testing ()
   FPGA_GPIO(0) <=  inst7_uart_tx;
   
   
   

end arch;   



