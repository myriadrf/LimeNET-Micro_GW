-- ----------------------------------------------------------------------------
-- FILE:          vctcxo_tamer_top.vhd
-- DESCRIPTION:   describe file
-- DATE:          Jan 27, 2016
-- AUTHOR(s):     Lime Microsystems
-- REVISIONS:
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
--NOTES:
-- ----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ----------------------------------------------------------------------------
-- Entity declaration
-- ----------------------------------------------------------------------------
entity vctcxo_tamer_top is
   generic ( 
      UART_BAUD_RATE          : positive := 9600;
      MM_CLOCK_FREQUENCY      : positive := 100000000
   );
   port (
      -- SPI interface
      -- Address and location of SPI memory module
      -- Will be hard wired at the top level
      maddress             : in  std_logic_vector(9 downto 0);   
      -- Serial port IOs
      sdin                 : in  std_logic;   -- Data in
      sclk                 : in  std_logic;   -- Data clock
      sen                  : in  std_logic;   -- Enable signal (active low)
      sdout                : out std_logic;   -- Data out
   
      -- Signals coming from the pins or top level serial interface
      lreset               : in  std_logic;   -- Logic reset signal, resets logic cells only  (use only one reset)
      mreset               : in  std_logic;   -- Memory reset signal, resets configuration memory only (use only one reset)
   
      -- NIOS PIO
      en                   : out std_logic;
      
      -- Physical VCXO tamer Interface
      tune_ref             : in  std_logic;
      vctcxo_clock         : in  std_logic;
      vctcxo_tune_accuracy : out std_logic_vector(3 downto 0); -- 0000 - no tune, 0001 - 1s, 0010 - 10s, 0011 - 100s
      
      -- Avalon-MM Interface (External master)
      mm_clock             : in  std_logic;
      mm_reset             : in  std_logic;
      mm_rd_req            : in  std_logic;
      mm_wr_req            : in  std_logic;
      mm_addr              : in  std_logic_vector(7 downto 0);
      mm_wr_data           : in  std_logic_vector(7 downto 0);
      mm_rd_data           : out std_logic_vector(7 downto 0);
      mm_rd_datav          : out std_logic;
      mm_wait_req          : out std_logic := '0';
      
      -- Avalon Interrupts
      mm_irq               : out std_logic := '0';
      
      -- To UART MODULE (TESTING)
      fan_ctrl_in          : in std_logic;
      uart_tx              : out std_logic
   
   
      
      );
end vctcxo_tamer_top;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of vctcxo_tamer_top is
--declare signals,  components here
signal mm_reset_n                : std_logic;
   
--inst0  
signal inst0_pps_1s_error        : std_logic_vector (31 downto 0); 
signal inst0_pps_10s_error       : std_logic_vector (31 downto 0); 
signal inst0_pps_100s_error      : std_logic_vector (31 downto 0); 
signal inst0_mm_irq              : std_logic;
signal inst0_accuracy            : std_logic_vector (3 downto 0);
signal inst0_state               : std_logic_vector (3 downto 0);
signal inst0_dac_tuned_val       : std_logic_vector (15 downto 0); 
signal inst0_pps_1s_err_tol      : std_logic_vector (31 downto 0); 
signal inst0_pps_10s_err_tol     : std_logic_vector (31 downto 0);
signal inst0_pps_100s_err_tol    : std_logic_vector (31 downto 0);
signal inst0_pps_1s_count_v      : std_logic;
signal inst0_pps_10s_count_v     : std_logic;
signal inst0_pps_100s_count_v    : std_logic;

--inst1 
signal inst1_pps_1s_err_tol      : std_logic_vector (31 downto 0); 
signal inst1_pps_10s_err_tol     : std_logic_vector (31 downto 0);
signal inst1_pps_100s_err_tol    : std_logic_vector (31 downto 0);

--inst2
signal inst2_uart_data_in        : std_logic_vector(7 downto 0);
signal inst2_uart_data_in_stb    : std_logic;


--inst3  
signal inst3_DATA_STREAM_IN_ACK  : std_logic;



  
begin

mm_reset_n <= not mm_reset;
   
-- ----------------------------------------------------------------------------
-- vctcxo_tamer instance
-- ----------------------------------------------------------------------------   
   vctcxo_tamer_inst0 : entity work.vctcxo_tamer
    port map(
      -- Physical Interface
      tune_ref             => tune_ref,
      vctcxo_clock         => vctcxo_clock,
      -- Avalon-MM Interface
      mm_clock             => mm_clock,
      mm_reset             => mm_reset,
      mm_rd_req            => mm_rd_req,
      mm_wr_req            => mm_wr_req,
      mm_addr              => mm_addr,
      mm_wr_data           => mm_wr_data,
      mm_rd_data           => mm_rd_data,
      mm_rd_datav          => mm_rd_datav,
      mm_wait_req          => mm_wait_req,
      -- Avalon Interrupts
      mm_irq               => inst0_mm_irq,
      PPS_1S_ERROR_TOL     => inst0_pps_1s_err_tol,
      PPS_10S_ERROR_TOL    => inst0_pps_10s_err_tol,
      PPS_100S_ERROR_TOL   => inst0_pps_100s_err_tol,
        
      pps_1s_error         => inst0_pps_1s_error,
      pps_10s_error        => inst0_pps_10s_error,
      pps_100s_error       => inst0_pps_100s_error,
      accuracy             => inst0_accuracy,
      state                => inst0_state,
      dac_tuned_val        => inst0_dac_tuned_val,
      pps_1s_count_v       => inst0_pps_1s_count_v,
      pps_10s_count_v      => inst0_pps_10s_count_v,
      pps_100s_count_v     => inst0_pps_100s_count_v
      
    );
 
 
    -- to synchronize to mm_clock domain
   bus_sync_reg0 : entity work.bus_sync_reg
   generic map (32) 
   port map(mm_clock, mm_reset_n, inst1_pps_1s_err_tol, inst0_pps_1s_err_tol);
   
   bus_sync_reg1 : entity work.bus_sync_reg
   generic map (32) 
   port map(mm_clock, mm_reset_n, inst1_pps_10s_err_tol, inst0_pps_10s_err_tol);
   
   bus_sync_reg2 : entity work.bus_sync_reg
   generic map (32) 
   port map(mm_clock, mm_reset_n, inst1_pps_100s_err_tol, inst0_pps_100s_err_tol);
   
-- ----------------------------------------------------------------------------
-- vctcxo_tamer SPI configuration memory
-- ---------------------------------------------------------------------------- 
   vctcxo_tamercfg_inst1 : entity work.vctcxo_tamercfg
   port map (
      maddress          => maddress,
      mimo_en           => '1',
      sdin              => sdin,
      sclk              => sclk,
      sen               => sen,
      sdout             => sdout,
      lreset            => lreset,
      mreset            => lreset,   
      oen               => open,
      stateo            => open,     
      en                => en,
      accuracy          => inst0_accuracy,
      state             => inst0_state,
      dac_tuned_val     => inst0_dac_tuned_val,
      pps_1s_err_tol    => inst1_pps_1s_err_tol,
      pps_10s_err_tol   => inst1_pps_10s_err_tol,
      pps_100s_err_tol  => inst1_pps_100s_err_tol,
      pps_1s_err        => inst0_pps_1s_error,
      pps_10s_err       => inst0_pps_10s_error,
      pps_100s_err      => inst0_pps_100s_error
      
   );
   
   
   vctcxo_tamer_log_inst2 : entity work.vctcxo_tamer_log
   port map(
      clk                  => mm_clock,
      reset_n              => mm_reset_n,
         
      --Data to log  
      pps_1s_error         => inst0_pps_1s_error,
      pps_10s_error        => inst0_pps_10s_error,
      pps_100s_error       => inst0_pps_100s_error,
      accuracy             => inst0_accuracy,
      state                => inst0_state,
      dac_tuned_val        => inst0_dac_tuned_val,
      pps_1s_count_v       => inst0_pps_1s_count_v,
      pps_10s_count_v      => inst0_pps_10s_count_v,
      pps_100s_count_v     => inst0_pps_100s_count_v,
      fan_ctrl_in          => fan_ctrl_in,
      
      --To uart module
      uart_data_in         => inst2_uart_data_in,
      uart_data_in_stb     => inst2_uart_data_in_stb,
      uart_data_in_ack     => inst3_DATA_STREAM_IN_ACK
      
      );
   
   
-- ----------------------------------------------------------------------------
-- UART module
-- ----------------------------------------------------------------------------
UART_inst3 : entity work.UART
   generic map(
      BAUD_RATE            => UART_BAUD_RATE,
      CLOCK_FREQUENCY      => MM_CLOCK_FREQUENCY
   )
    port map(     
      CLOCK                => mm_clock,   
      RESET                => mm_reset,
      DATA_STREAM_IN       => inst2_uart_data_in,
      DATA_STREAM_IN_STB   => inst2_uart_data_in_stb,
      DATA_STREAM_IN_ACK   => inst3_DATA_STREAM_IN_ACK,
      DATA_STREAM_OUT      => open,
      DATA_STREAM_OUT_STB  => open,
      DATA_STREAM_OUT_ACK  => '0',
      TX                   => uart_tx,
      RX                   => '0'
   );
   
   
-- ----------------------------------------------------------------------------
-- output ports
-- ---------------------------------------------------------------------------- 
   mm_irq <= inst0_mm_irq;
   
   vctcxo_tune_accuracy <= inst0_accuracy;
  
end arch;   


