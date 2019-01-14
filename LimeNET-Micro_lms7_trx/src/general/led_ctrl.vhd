-- ----------------------------------------------------------------------------
-- FILE:          led_ctrl.vhd
-- DESCRIPTION:   led control module
-- DATE:          11:35 AM Monday, January 11, 2019
-- AUTHOR(s):     Lime Microsystems
-- REVISIONS:
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
--NOTES:
-- ----------------------------------------------------------------------------
-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
entity led_ctrl is
   generic(
      active_lvl  : std_logic := '0'
      );
   port (
      ovrd_en     : in  std_logic;
      ovrd_val_g  : in  std_logic;
      ovrd_val_r  : in  std_logic;
      input_g     : in  std_logic;
      input_r     : in  std_logic;
      output_g    : out std_logic;
      output_r    : out std_logic
   );
end entity led_ctrl;

architecture rtl of led_ctrl is
begin

led_g_ctrl : entity work.out_ctrl
generic map(
   active_lvl  => active_lvl
   )
port map(
   ovrd_en     => ovrd_en,
   ovrd_val    => ovrd_val_g,
   input       => input_g,
   output      => output_g
   );
   
led_r_ctrl : entity work.out_ctrl
generic map(
   active_lvl  => active_lvl
   )
port map(
   ovrd_en     => ovrd_en,
   ovrd_val    => ovrd_val_r,
   input       => input_r,
   output      => output_r
   );

end architecture rtl;