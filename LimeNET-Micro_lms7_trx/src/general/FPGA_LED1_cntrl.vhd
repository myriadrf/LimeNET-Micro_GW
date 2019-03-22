-- ----------------------------------------------------------------------------
-- FILE:          FPGA_LED1_cntrl.vhd
-- DESCRIPTION:   FPGA_LED1 control module
-- DATE:          4:36 PM Monday, May 7, 2018
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
entity FPGA_LED1_cntrl is
   port (
      --input ports 
      pll1_locked    : in std_logic;
      pll2_locked    : in std_logic;
      alive          : in std_logic;
      --output ports 
      led_g          : out std_logic;
      led_r          : out std_logic
      
   );
end FPGA_LED1_cntrl;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of FPGA_LED1_cntrl is
signal all_pll_locked   : std_logic;
signal led_r_def        : std_logic;
  
begin

all_pll_locked <= pll1_locked and pll2_locked;
led_r_def      <= not alive when all_pll_locked='0' else '0';
                  
led_g <= alive;
led_r <= led_r_def;
  
end arch;

