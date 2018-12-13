-- ----------------------------------------------------------------------------
-- FILE:          vctcxo_tamer_log.vhd
-- DESCRIPTION:   VCTCXO tamer data logger with uart module interface
-- DATE:          2:47 PM Wednesday, March 21, 2018
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
entity vctcxo_tamer_log is
   port (
      clk                  : in  std_logic;
      reset_n              : in  std_logic;
         
      --Data to log  
      pps_1s_error         : in  std_logic_vector(31 downto 0);
      pps_10s_error        : in  std_logic_vector(31 downto 0);
      pps_100s_error       : in  std_logic_vector(31 downto 0);
      accuracy             : in  std_logic_vector(3 downto 0);
      state                : in  std_logic_vector(3 downto 0);
      dac_tuned_val        : in  std_logic_vector(15 downto 0);
      pps_1s_count_v       : in  std_logic;
      pps_10s_count_v      : in  std_logic;
      pps_100s_count_v     : in  std_logic;
      fan_ctrl_in          : in  std_logic;
      
      --To uart module
      uart_data_in         : out std_logic_vector(7 downto 0);
      uart_data_in_stb     : out std_logic;
      uart_data_in_ack     : in  std_logic
      
      );
end vctcxo_tamer_log;

-- ----------------------------------------------------------------------------
-- Architecture
-- ----------------------------------------------------------------------------
architecture arch of vctcxo_tamer_log is
--declare signals,  components here
signal my_sig_name   : std_logic_vector (7 downto 0); 
signal capture_en    : std_logic;   
signal shift_en      : std_logic;
signal fan_char      : std_logic_vector(3 downto 0);

signal ack_cnt       : unsigned(7 downto 0);

constant c_comma     : std_logic_vector(7 downto 0) := x"2C";
constant c_CR        : std_logic_vector(7 downto 0) := x"0D";
constant c_LF        : std_logic_vector(7 downto 0) := x"0A";

signal data_reg      : std_logic_vector(311 downto 0);

constant bytes       : integer := 39;

type state_type is (idle, set_stb, stb_ack);
signal current_state, next_state : state_type;

-- Function to convert std_logic_vector in HEX representation to 
-- String characters in std_logic_vector
function slv_to_char(h : std_logic_vector) return std_logic_vector is
   constant  hh : std_logic_vector(3 downto 0) := h;
begin 
   case hh is 
      when x"0" => 
         return x"30";
      when x"1" => 
         return x"31";
      when x"2" => 
         return x"32";
      when x"3" => 
         return x"33";         
      when x"4" => 
         return x"34";
      when x"5" => 
         return x"35";
      when x"6" => 
         return x"36";
      when x"7" => 
         return x"37";
      when x"8" => 
         return x"38";
      when x"9" => 
         return x"39";
      when x"A" => 
         return x"41";
      when x"B" => 
         return x"42";
      when x"C" => 
         return x"43";             
      when x"D" => 
         return x"44";
      when x"E" => 
         return x"45"; 
      when x"F" => 
         return x"46";
      when others=> 
         return x"00";
   end case;
end function;

-- Function to convert std_logic_vector in HEX representation to 
-- String characters in std_logic_vector
function conv_slv_to_char( d : std_logic_vector)
   return std_logic_vector is 
   variable tmp : std_logic_vector(2*d'length-1 downto 0); 
begin 
   for i in 0 to d'length/4-1 loop
      tmp(i*8+7 downto i*8) := slv_to_char(d(i*4+3 downto i*4));
   end loop;
   
   return std_logic_vector(tmp);
   
end function;


begin

fan_char <= "000" & fan_ctrl_in;
  
-- Trigger selection
capture_en <= pps_10s_count_v;


--Capture all characters to one array
process(reset_n, clk)
   begin
   if reset_n='0' then
      data_reg<=(others=>'0');  
   elsif (clk'event and clk = '1') then
      if capture_en = '1' then 
         data_reg <= slv_to_char(fan_char) & 
                     c_comma &
                     slv_to_char(state) & 
                     c_comma &
                     slv_to_char(accuracy) & 
                     c_comma &
                     conv_slv_to_char(dac_tuned_val) &
                     c_comma &
                     conv_slv_to_char(pps_1s_error) &
                     c_comma &
                     conv_slv_to_char(pps_10s_error) &
                     c_comma &
                     conv_slv_to_char(pps_100s_error) & 
                     c_CR & c_LF;
                     
      elsif shift_en = '1' then 
         data_reg <= data_reg(303 downto 0) & x"00"; 
      else 
         data_reg <= data_reg;
      end if;
   end if;
end process;


--Count ack signal from UART
process(clk, reset_n)
begin
   if reset_n = '0' then 
      ack_cnt <= (others => '0');
   elsif (clk'event AND clk='1') then 
      if current_state = stb_ack then 
         ack_cnt <= ack_cnt + 1;
      elsif current_state = idle then 
         ack_cnt <= (others => '0');
      else 
         ack_cnt <= ack_cnt;
      end if;
   end if;
end process;


-- ----------------------------------------------------------------------------
-- state machine
-- ----------------------------------------------------------------------------
fsm_f : process(clk, reset_n)begin
	if(reset_n = '0')then
		current_state <= idle;
	elsif(clk'event and clk = '1')then 
		current_state <= next_state;
	end if;	
end process;

-- ----------------------------------------------------------------------------
-- state machine combo
-- ----------------------------------------------------------------------------
fsm : process(current_state, capture_en, uart_data_in_ack, ack_cnt) begin
	next_state <= current_state;
	case current_state is
	  
		when idle =>         -- idle state waiting for capture enable
         if capture_en = '1' then 
            next_state <= set_stb;
         else 
            next_state <= idle;
         end if;
      
      when set_stb =>      -- send one character
         if uart_data_in_ack = '1' then 
            next_state <= stb_ack;
         else 
            next_state <= set_stb;
         end if;
         
      when stb_ack =>      -- check if this is last character
         if ack_cnt < bytes - 1 then 
            next_state <= set_stb;
         else 
            next_state <= idle;
         end if;

		when others => 
			next_state <= idle;
	end case;
end process;


--Generate UART stb signal
process(clk, reset_n)
begin
   if reset_n = '0' then 
      uart_data_in_stb <= '0';
   elsif (clk'event AND clk='1') then 
      if current_state = set_stb then 
         uart_data_in_stb <= '1';
      else 
         uart_data_in_stb <= '0';
      end if;
   end if;
end process;

-- Enable signal for data_reg shift register
shift_en <= '1' when current_state = stb_ack else '0';

-- ----------------------------------------------------------------------------
-- Output ports
-- ----------------------------------------------------------------------------
uart_data_in <= data_reg(311 downto 304);




  
end arch;   


