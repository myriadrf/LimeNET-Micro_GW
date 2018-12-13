-- ----------------------------------------------------------------------------
-- FILE:          IC_74HC595_top.vhd
-- DESCRIPTION:   top file for IC_74HC595
-- DATE:          4:36 PM Thursday, December 14, 2017
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
entity IC_74HC595_top is
   port (

      clk      : in std_logic;
      reset_n  : in std_logic;
      data     : in std_logic_vector(31 downto 0);
      busy     : out std_logic;
      
      SHCP     : out std_logic;  -- shift register clock
      STCP     : out std_logic;  -- storage register clock
      DS       : out std_logic   -- serial data
      
        );
end IC_74HC595_top;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of IC_74HC595_top is
--declare signals,  components here
signal reset_n_sync     : std_logic;
signal reset_n_delayed  : std_logic;
signal data_sync        : std_logic_vector (31 downto 0); 
signal reset_cnt        : unsigned(7 downto 0);

signal inst0_en         : std_logic;
signal inst0_busy       : std_logic;


begin

-- ----------------------------------------------------------------------------
-- Data synchronization into clk domain
-- ----------------------------------------------------------------------------
sync_reg0 : entity work.sync_reg 
port map(clk, reset_n, reset_n, reset_n_sync);

bus_sync_reg0 : entity work.bus_sync_reg
generic map (32)
port map(clk, reset_n_sync, data, data_sync);

process(clk, reset_n_sync)
begin
   if reset_n_sync = '0' then 
      reset_cnt         <= (others=>'0');
      reset_n_delayed   <= '0';
   elsif (clk'event AND clk='1') then 
      if reset_cnt < 255 then 
         reset_cnt <= reset_cnt + 1;
         reset_n_delayed <= '0';
      else 
         reset_cnt <= reset_cnt;
         reset_n_delayed <= '1';
      end if;         
   end if;
end process;

   
-- ----------------------------------------------------------------------------
-- Enabling shift register continously
-- ----------------------------------------------------------------------------
 process(reset_n_delayed, clk)
    begin
      if reset_n_delayed='0' then
         inst0_en    <= '0';
      elsif (clk'event and clk = '1') then
         inst0_en <= NOT inst0_busy;
      end if;
    end process;    

-- ----------------------------------------------------------------------------
-- Module instance
-- ----------------------------------------------------------------------------
IC_74HC595_inst0 : entity work.IC_74HC595
   generic map (
      data_width   => 32
   )
   port map (
      clk      => clk,
      reset_n  => reset_n_delayed,
      en       => inst0_en,
      data     => data_sync,
      busy     => inst0_busy,
      
      SHCP     => SHCP,
      STCP     => STCP,
      DS       => DS
      );
      
busy <= inst0_busy;
  
end arch;   


