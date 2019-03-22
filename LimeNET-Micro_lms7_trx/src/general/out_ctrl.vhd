-- ----------------------------------------------------------------------------
-- FILE:          out_ctrl.vhd
-- DESCRIPTION:   output control module
-- DATE:          11:27 AM Friday, January 11, 2019
-- AUTHOR(s):     Lime Microsystems
-- REVISIONS:
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- NOTES:
-- ----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ----------------------------------------------------------------------------
-- Entity declaration
-- ----------------------------------------------------------------------------
entity out_ctrl is
   generic(
      active_lvl   : std_logic := '0'  -- Active level of output
   );
   port (

      ovrd_en  : in std_logic;
      ovrd_val : in std_logic;
      input    : in std_logic;
      output   : out std_logic

   );
end out_ctrl;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of out_ctrl is
--declare signals,  components here
signal output_tmp  : std_logic;


begin
   
   -- MUX between input and override value
   output_tmp  <= input       when ovrd_en='0'        else ovrd_val;
   -- Output active level 
   output      <= output_tmp  when active_lvl = '1'   else not output_tmp;
 
end arch;   


