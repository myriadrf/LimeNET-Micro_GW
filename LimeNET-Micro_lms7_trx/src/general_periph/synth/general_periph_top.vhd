-- ----------------------------------------------------------------------------
-- FILE:          general_periph_top.vhd
-- DESCRIPTION:   Top wrapper file for general periphery components
-- DATE:          3:39 PM Monday, May 7, 2018
-- AUTHOR(s):     Lime Microsystems
-- REVISIONS:
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
--NOTES:
-- ----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.periphcfg_pkg.all;

-- ----------------------------------------------------------------------------
-- Entity declaration
-- ----------------------------------------------------------------------------
entity general_periph_top is
   generic(
      DEV_FAMILY  : string := "CYCLONE IV E";
      N_GPIO      : integer := 8;
      led1_active_lvl      : std_logic := '0';
      led2_active_lvl      : std_logic := '0';
      led3_active_lvl      : std_logic := '0';
      led4_active_lvl      : std_logic := '0';
      led5_active_lvl      : std_logic := '0'
   );
   port (
      -- General ports
      clk                  : in     std_logic; -- Free running clock
      reset_n              : in     std_logic; -- Asynchronous, active low reset
      
      to_periphcfg         : out    t_TO_PERIPHCFG;
      from_periphcfg       : in     t_FROM_PERIPHCFG;
      
      -- Dual colour LEDs
      -- LED1 ( Raspberry eMMC enable )
      led1_in_g            : in     std_logic;
      led1_in_r            : in     std_logic;
      led1_ctrl            : in     std_logic_vector(2 downto 0);
      led1_out_g           : out    std_logic;
      led1_out_r           : out    std_logic;
      
      -- LED2 ( FTDI and NIOS busy )
      led2_in_g            : in     std_logic;
      led2_in_r            : in     std_logic;
      led2_ctrl            : in     std_logic_vector(2 downto 0);
      led2_out_g           : out    std_logic;
      led2_out_r           : out    std_logic;      
      led2_hw_ver          : in     std_logic_vector(3 downto 0);
      
      
      -- LED3 ( Clock and PLL lock )
      led3_ctrl            : in     std_logic_vector(2 downto 0);
      led3_out_g           : out    std_logic;
      led3_out_r           : out    std_logic; 
      led3_pll1_locked     : in     std_logic;
      led3_pll2_locked     : in     std_logic;      
      
      
      -- LED4 ( TCXO control status )
      led4_ctrl            : in     std_logic_vector(2 downto 0);
      led4_out_g           : out    std_logic;
      led4_out_r           : out    std_logic;

      led4_clk             : in     std_logic;
      led4_adf_muxout      : in     std_logic;
      led4_dac_ss          : in     std_logic;
      led4_adf_ss          : in     std_logic;   
      
      
      -- LED5 ( GNSS status )
      led5_in_g            : in     std_logic;
      led5_in_r            : in     std_logic;
      led5_ctrl            : in     std_logic_vector(2 downto 0);
      led5_out_g           : out    std_logic;
      led5_out_r           : out    std_logic;            
      
      
      --GPIO
      gpio_dir             : in     std_logic_vector(N_GPIO-1 downto 0);
      gpio_out_val         : in     std_logic_vector(N_GPIO-1 downto 0);
      gpio_rd_val          : out    std_logic_vector(N_GPIO-1 downto 0);
      gpio                 : inout  std_logic_vector(N_GPIO-1 downto 0); -- to FPGA pins
      
      --Fan control
      fan_sens_in          : in     std_logic;
      fan_ctrl_out         : out    std_logic;
      
      --Button
      FPGA_BTN             : in     std_logic;
      
      --Buzzer
      Buzzer_en            : in     std_logic;
      Buzzer               : out    std_logic

   );
end general_periph_top;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of general_periph_top is
--declare signals,  components here
--inst0
signal inst0_beat : std_logic; 

--inst1 
signal inst1_board_gpio_ovrd        : std_logic_vector(15 downto 0);
signal inst1_board_gpio_rd          : std_logic_vector(15 downto 0);
signal inst1_board_gpio_dir         : std_logic_vector(15 downto 0);
signal inst1_board_gpio_val         : std_logic_vector(15 downto 0);
signal inst1_periph_input_rd_0      : std_logic_vector(15 downto 0);
signal inst1_periph_input_rd_1      : std_logic_vector(15 downto 0);
signal inst1_periph_output_ovrd_0   : std_logic_vector(15 downto 0);
signal inst1_periph_output_val_0    : std_logic_vector(15 downto 0);
signal inst1_periph_output_ovrd_1   : std_logic_vector(15 downto 0);
signal inst1_periph_output_val_1    : std_logic_vector(15 downto 0);

--inst5
signal inst5_gpio_in                : std_logic_vector(N_GPIO-1 downto 0);
signal inst5_mux_sel                : std_logic_vector(N_GPIO-1 downto 0);
signal inst5_dir_0                  : std_logic_vector(N_GPIO-1 downto 0);
signal inst5_dir_1                  : std_logic_vector(N_GPIO-1 downto 0);
signal inst5_out_val_0              : std_logic_vector(N_GPIO-1 downto 0);
signal inst5_out_val_1              : std_logic_vector(N_GPIO-1 downto 0);

--leds
signal led1_g,led1_r                : std_logic;
signal led2_g,led2_r                : std_logic;
signal led3_g,led3_r                : std_logic;
signal led4_g,led4_r                : std_logic;
signal led5_g,led5_r                : std_logic;

begin
   
-- ----------------------------------------------------------------------------
-- Alive instance
-- Simple counter to toggle output
-- ----------------------------------------------------------------------------   
   alive_inst0 : entity work.alive
   port map(
      clk      => clk,
      reset_n  => reset_n,
      beat     => inst0_beat
   );

   process(inst5_gpio_in)
   begin 
      inst1_board_gpio_rd <= (others=>'0');
      inst1_board_gpio_rd(N_GPIO-1 downto 0) <= inst5_gpio_in;
   end process;
   
   inst1_periph_input_rd_0 <= (others=>'0');
   inst1_periph_input_rd_1 <= (others=>'0');
   
-- ----------------------------------------------------------------------------
-- FPGA LED 1 control module
-- Green - Raspberry eMMC enabled
-- Red   - Raspberry eMMC disabled
-- ----------------------------------------------------------------------------      
   
   FPGA_LED1_Output_ctrl : entity work.led_ctrl
   generic map(
      active_lvl     => led1_active_lvl
      )
   port map(
      ovrd_en        => led1_ctrl(0),
      ovrd_val_g     => led1_ctrl(1),
      ovrd_val_r     => led1_ctrl(2),
      input_g        => led1_in_g,
      input_r        => led1_in_r,
      output_g       => led1_out_g,
      output_r       => led1_out_r
      );
      
      
-- ----------------------------------------------------------------------------
-- FPGA LED 2 control module
-- FTDI controller and NIOS CPU activity indication:
-- Green - idle, Red - busy.
-- ---------------------------------------------------------------------------- 
      
   FPGA_LED2_Output_ctrl : entity work.led_ctrl
   generic map(
      active_lvl     => led2_active_lvl
      )
   port map(
      ovrd_en        => led2_ctrl(0),
      ovrd_val_g     => led2_ctrl(1),
      ovrd_val_r     => led2_ctrl(2),
      input_g        => led2_in_g,
      input_r        => led2_in_r,
      output_g       => led2_out_g,
      output_r       => led2_out_r
      );
   
   
-- ----------------------------------------------------------------------------
-- FPGA LED3 control modules
-- Blinking indicates presence of TCXO clock.
-- Colour indicates status of FPGA PLLs that are used for LMS digital interface clocking: 
-- Green - both PLLs are locked; Red/Green - at least one -- PLL is not locked.
-- ----------------------------------------------------------------------------    
   FPGA_LED3_cntrl_inst2 : entity work.FPGA_LED1_cntrl
   port map(
      pll1_locked    => led3_pll1_locked,
      pll2_locked    => led3_pll2_locked,
      alive          => inst0_beat,
      led_g          => led3_g,
      led_r          => led3_r
   );
   
   FPGA_LED3_Output_ctrl : entity work.led_ctrl
   generic map(
      active_lvl     => led3_active_lvl
      )
   port map(
      ovrd_en        => led3_ctrl(0),
      ovrd_val_g     => led3_ctrl(1),
      ovrd_val_r     => led3_ctrl(2),
      input_g        => led3_g,
      input_r        => led3_r,
      output_g       => led3_out_g,
      output_r       => led3_out_r
      );
   
-- ----------------------------------------------------------------------------
-- FPGA LED4 control modules
-- No light - TCXO is controlled from DAC
-- Red - TCXO is controlled from phase detector and is not locked to external reference clock,
-- Green - TCXO is controlled from phase detector and is -- locked to external reference clock
-- ---------------------------------------------------------------------------- 
   FPGA_LED4_ctrl_inst3 : entity work.FPGA_LED2_ctrl
   port map(
      clk            => led4_clk,
      reset_n        => reset_n,
      adf_muxout     => led4_adf_muxout,
      dac_ss         => led4_dac_ss,
      adf_ss         => led4_adf_ss,
      led_g          => led4_g,
      led_r          => led4_r
   );
   
   FPGA_LED4_Output_ctrl : entity work.led_ctrl
   generic map(
      active_lvl     => led4_active_lvl
      )
   port map(
      ovrd_en        => led4_ctrl(0),
      ovrd_val_g     => led4_ctrl(1),
      ovrd_val_r     => led4_ctrl(2),
      input_g        => led4_g,
      input_r        => led4_r,
      output_g       => led4_out_g,
      output_r       => led4_out_r
      );
      
-- ----------------------------------------------------------------------------
-- FPGA LED 5 control module
-- Blinking red         - low accuracy
-- Blinking red/green   - medium accuracy
-- Blinking green       - high accuracy
-- Solid red            - no fix
-- No light             - disabled
-- ----------------------------------------------------------------------------      
   
   FPGA_LED5_Output_ctrl : entity work.led_ctrl
   generic map(
      active_lvl     => led5_active_lvl
      )
   port map(
      ovrd_en        => led5_ctrl(0),
      ovrd_val_g     => led5_ctrl(1),
      ovrd_val_r     => led5_ctrl(2),
      input_g        => led5_in_g,
      input_r        => led5_in_r,
      output_g       => led5_out_g,
      output_r       => led5_out_r
      );


-- ----------------------------------------------------------------------------
-- gpio_ctrl_top instance
-- ----------------------------------------------------------------------------      
   gpio_ctrl_top_inst5 : entity work.gpio_ctrl_top
   generic map(
      bus_width   => N_GPIO
   )
   port map(
      gpio        => gpio,
      gpio_in     => inst5_gpio_in,
      mux_sel     => inst5_mux_sel,
      dir_0       => gpio_dir,
      dir_1       => inst5_dir_1,
      out_val_0   => gpio_out_val,
      out_val_1   => inst5_out_val_1

   );
   
   
   inst5_mux_sel   <= from_periphcfg.BOARD_GPIO_OVRD(N_GPIO-1 downto 0);
   inst5_dir_1     <= from_periphcfg.BOARD_GPIO_DIR(N_GPIO-1 downto 0);
   inst5_out_val_1 <= from_periphcfg.BOARD_GPIO_VAL(N_GPIO-1 downto 0);
   
-- ----------------------------------------------------------------------------
-- Output ports
-- ----------------------------------------------------------------------------      
      
   fan_ctrl_out   <= fan_sens_in when from_periphcfg.PERIPH_OUTPUT_OVRD_0(0) = '0' else 
                     from_periphcfg.PERIPH_OUTPUT_VAL_0(0);
                     
   Buzzer         <= Buzzer_en   when from_periphcfg.PERIPH_OUTPUT_OVRD_0(1) = '0' else
                     from_periphcfg.PERIPH_OUTPUT_VAL_0(1);
                     
   gpio_rd_val    <= inst5_gpio_in;
   
   process(inst5_gpio_in)
   begin 
      to_periphcfg.BOARD_GPIO_RD <= (others=>'0');
      to_periphcfg.BOARD_GPIO_RD(N_GPIO-1 downto 0) <= inst5_gpio_in;

   end process;
   
   process(fan_sens_in,FPGA_BTN)
   begin 
      to_periphcfg.PERIPH_INPUT_RD_0                <= (others=>'0');
      to_periphcfg.PERIPH_INPUT_RD_0(0)             <= fan_sens_in;
      to_periphcfg.PERIPH_INPUT_RD_0(1)             <= FPGA_BTN;
   end process;
   
   to_periphcfg.PERIPH_INPUT_RD_1 <= (others=>'0');
                     
      
end arch;   


