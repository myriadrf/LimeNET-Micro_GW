--SPI Communication module
--Copyright Norbertas Kremeris 2018 LIME MICROSYSTEMS

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_module is
	port(
		MISO                   : out std_logic;
		MOSI                   : in  std_logic;
		MCLK                   : in  std_logic;
		CS                     : in  std_logic;
		data_request_interrupt : out std_logic;
		
		reset_n                : in  std_logic;
		clk30_72mhz            : in  std_logic;
		
		tx_fifo_rdclk          : in  std_logic;
		tx_fifo_reset_n        : in  std_logic;
		tx_fifo_q              : out std_logic_vector(127 downto 0);
		tx_fifo_rdempty        : out std_logic;
		tx_fifo_rdusedw        : out std_logic_vector(8 downto 0);
		tx_fifo_rdreq          : in  std_logic;
		
		rx_fifo_reset_n        : in  std_logic;
		rx_fifo_wrclk          : in  std_logic;
		rx_fifo_data           : in  std_logic_vector(63 downto 0);
		rx_fifo_wrreq          : in  std_logic;
		rx_fifo_wrusedw        : out std_logic_vector(11 downto 0)
	);
end entity spi_module;

architecture main of spi_module is
	signal tx_shift_reg : std_logic_vector(7 downto 0);
	signal databuffer   : std_logic_vector(7 downto 0);

	signal counter           : unsigned(2 downto 0);
	signal counter_out       : unsigned(2 downto 0);
	signal next_word_tx      : std_logic;
	signal next_word_rx      : std_logic;
	signal next_word_rx_reg  : std_logic_vector(2 downto 0);
	signal next_word_rx_long : std_logic;

	signal expected_data : unsigned(7 downto 0);

	signal shift_reg_out : std_logic_vector(7 downto 0);
	signal data_out      : unsigned(7 downto 0);

	signal toggle          : std_logic                := '0';
	signal divider_counter : integer range 0 to 39999 := 0;

	--fifo TX
	signal tx_reset_n, tx_wrclk, tx_wrfull, tx_wrreq, tx_wrempty, tx_rdclk, tx_rdreq, tx_rdempty : std_logic;
	signal tx_rdusedw                                                                            : std_logic_vector(8 downto 0);
	signal tx_wrusedw                                                                            : std_logic_vector(12 downto 0); --(11 downto 0);
	signal tx_q                                                                                  : std_logic_vector(127 downto 0); --(127 downto 0);
	signal tx_data                                                                               : std_logic_vector(7 downto 0);

	--fifo RX
	signal rx_reset_n, rx_wrclk, rx_wrfull, rx_wrreq, rx_wrempty, rx_rdclk, rx_rdreq, rx_rdempty : std_logic;
	signal rx_rdusedw                                                                            : std_logic_vector(14 downto 0);
	signal rx_wrusedw                                                                            : std_logic_vector(11 downto 0); --(11 downto 0);
	signal rx_q                                                                                  : std_logic_vector(7 downto 0); --(127 downto 0);
	signal rx_data                                                                               : std_logic_vector(63 downto 0);

	signal rx_shiftreg                      : std_logic_vector(6 downto 0);
	signal rx_shiftreg_read, rx_shiftreg_en : std_logic;

	signal rx_fifo_sync_stage : std_logic_vector(2 downto 0);
	signal rx_synced_rdreq    : std_logic;

	signal tx_fifo_synced_wrempty_stage : std_logic_vector(2 downto 0);
	signal tx_fifo_synced_wrempty : std_logic;
	
	signal data_ready, data_request : std_logic;
	signal data_sync                : std_logic;
	signal data_request_stage : std_logic_vector(1 downto 0);
	
	--keep for signaltap
--	attribute keep : boolean;
--	attribute keep of data_ready : signal is true;
--	attribute keep of tx_rdempty : signal is true;
--	attribute keep of tx_wrfull : signal is true;
--	attribute keep of rx_wrfull : signal is true;
--	attribute keep of rx_rdempty : signal is true;
--	attribute keep of rx_rdusedw : signal is true;

	signal rx_bit_order_reverse_q : std_logic_vector(7 downto 0);
	signal tx_bit_order_reverse_q : std_logic_vector(7 downto 0);

begin

	rxtx_spi_clock_counter_8bit : process(MCLK, CS)
	begin
		if (CS = '1') then
			counter     <= (others => '0');
		elsif (rising_edge(MCLK)) then
			counter     <= counter + 1;
		end if;
	end process rxtx_spi_clock_counter_8bit;
	next_word_tx <= '1' when counter = "111" else '0';
	next_word_rx <= '1' when counter = "001" else '0';

	tx_shift_register_8bit : process(MCLK, CS)
	begin
		if (CS = '1') then
			tx_shift_reg <= x"00";
		elsif (rising_edge(MCLK)) then
			tx_shift_reg <= MOSI & tx_shift_reg(7 downto 1);
		end if;
	end process tx_shift_register_8bit;

	tx_data_to_buffer : process(MCLK, reset_n)
	begin
		if (reset_n = '0') then
			databuffer <= (others => '0');
		elsif (rising_edge(MCLK)) then
			if (next_word_tx = '1') then
				databuffer <= mosi & tx_shift_reg(7 downto 1);
			end if;
		end if;
	end process tx_data_to_buffer;

	tx_wrreq_gen : process(MCLK, reset_n)
	begin
		if reset_n = '0' then
			tx_wrreq <= '0';
		elsif rising_edge(MCLK) then
			tx_wrreq <= next_word_tx;
		end if;
	end process;

	tx_bit_order_reverse_q(0)    <= databuffer(7);
	tx_bit_order_reverse_q(1)    <= databuffer(6);
	tx_bit_order_reverse_q(2)    <= databuffer(5);
	tx_bit_order_reverse_q(3)    <= databuffer(4);
	tx_bit_order_reverse_q(4)    <= databuffer(3);
	tx_bit_order_reverse_q(5)    <= databuffer(2);
	tx_bit_order_reverse_q(6)    <= databuffer(1);
	tx_bit_order_reverse_q(7)    <= databuffer(0);
	

	tx_data <= tx_bit_order_reverse_q;
	
	
	tx_reset_n <= tx_fifo_reset_n;
	tx_rdclk   <= tx_fifo_rdclk;
	tx_wrclk   <= MCLK;

	tx_fifo_spi : entity work.fifo_inst
		generic map(
			dev_family     => "MAX10",
			wrwidth        => 8,
			wrusedw_witdth => 13,
			rdwidth        => 128,
			rdusedw_width  => 9,
			show_ahead     => "off"
		)
		port map(
			reset_n => tx_reset_n,
			wrclk   => tx_wrclk,
			wrreq   => tx_wrreq,
			data    => tx_data,
			wrfull  => open,
			wrempty => tx_wrempty,
			wrusedw => tx_wrusedw,
			rdclk   => tx_rdclk,
			rdreq   => tx_rdreq,        --rdreq_tb,
			q       => tx_q,
			rdempty => tx_rdempty,
			rdusedw => tx_rdusedw
		);
	tx_fifo_q        <= tx_q;
	tx_fifo_rdempty  <= tx_rdempty;
	tx_fifo_rdusedw  <= tx_rdusedw;
	tx_rdreq         <= tx_fifo_rdreq;
	
	
	
	
	rx_shiftreg_read <= '1' when counter = "000" else '0';
	rx_shiftreg_en   <= not CS;

	rx_shift_register_8bit : process(MCLK, CS)
	begin
		if (CS = '1') then
			rx_shiftreg <= (others => '0');
		elsif (rising_edge(MCLK)) then
			if (rx_shiftreg_read = '1') then
				rx_shiftreg <= rx_q(7 downto 1);
			elsif (rx_shiftreg_en = '1') then
				rx_shiftreg <=  '1' & rx_shiftreg(6 downto 1);
			end if;
		end if;
	end process rx_shift_register_8bit;
	MISO <= rx_q(0) when counter = "000" else rx_shiftreg(0);

	rx_fifo_next_word_delay : process(clk30_72mhz)
	begin
		if (reset_n = '0') then
			next_word_rx_reg <= (others => '0');
		elsif (rising_edge(MCLK)) then
			next_word_rx_reg <= next_word_rx_reg(1 downto 0) & next_word_rx;
		end if;
	end process;
	next_word_rx_long <= next_word_rx or next_word_rx_reg(2) or next_word_rx_reg(1) or next_word_rx_reg(0);

	rx_fifo_rdreq_synchronisation : process(clk30_72mhz, counter)
	begin
		if (rising_edge(clk30_72mhz)) then
			rx_fifo_sync_stage <= rx_fifo_sync_stage(1 downto 0) & next_word_rx_long;
		end if;
	end process rx_fifo_rdreq_synchronisation;
	rx_synced_rdreq <= '1' when rx_fifo_sync_stage(2) = '0' and rx_fifo_sync_stage(1) = '1' else '0';
	rx_rdreq        <= rx_synced_rdreq;


	rx_reset_n <= rx_fifo_reset_n;
	rx_rdclk   <= clk30_72mhz;
	rx_wrclk   <= rx_fifo_wrclk;


	rx_q(0) <= rx_bit_order_reverse_q (7);
	rx_q(1) <= rx_bit_order_reverse_q (6);
	rx_q(2) <= rx_bit_order_reverse_q (5);
	rx_q(3) <= rx_bit_order_reverse_q (4);
	rx_q(4) <= rx_bit_order_reverse_q (3);
	rx_q(5) <= rx_bit_order_reverse_q (2);
	rx_q(6) <= rx_bit_order_reverse_q (1);
	rx_q(7) <= rx_bit_order_reverse_q (0);

	
	rx_fifo_spi : entity work.fifo_inst
		generic map(
			dev_family     => "MAX10",
			wrwidth        => 64,
			wrusedw_witdth => 12,
			rdwidth        => 8,        --16,       --128,
			rdusedw_width  => 15,       --11,       --5,	
			show_ahead     => "on"
		)
		port map(
			reset_n => rx_reset_n,
			wrclk   => rx_wrclk,
			wrreq   => rx_wrreq,
			data    => rx_data,
			wrfull  => open,
			wrempty => rx_wrempty,
			wrusedw => rx_wrusedw,
			rdclk   => rx_rdclk,
			rdreq   => rx_rdreq,
			q     =>  rx_bit_order_reverse_q,
			rdempty => rx_rdempty,
			rdusedw => rx_rdusedw
		);
	rx_data         <= rx_fifo_data;
	rx_wrreq        <= rx_fifo_wrreq;
	rx_fifo_wrusedw <= rx_wrusedw;
	

--	sync_tx_fifo_rdempty: process(clk30_72mhz, reset_n)
--	begin
--		if(reset_n = '0') then
--			tx_fifo_synced_wrempty_stage <= (others => '0');
--		elsif (rising_edge(clk30_72mhz)) then
--			tx_fifo_synced_wrempty_stage <= tx_wrempty & tx_fifo_synced_wrempty_stage(2 downto 1);
--		end if;
--	end process;
--			tx_fifo_synced_wrempty <= '1' when tx_fifo_synced_wrempty_stage(0) = '0' and tx_fifo_synced_wrempty_stage(1) = '1' else '0';
--			
			
	--data_ready             <= '1' when unsigned(rx_rdusedw) >= 4096 and tx_fifo_synced_wrempty = '1' and CS = '1' else '0'; 
	data_ready             <= '1' when unsigned(rx_rdusedw) >= 4096 and tx_rdempty = '1' and CS = '1' else '0'; 

--	data_request_gen : process(clk30_72mhz, reset_n)
--	begin
--		if (reset_n = '0') then
--			data_sync                    <= '0';
--			data_request_stage <= (others => '0');
--			
--		elsif (rising_edge(clk30_72mhz)) then
--			data_sync  <= data_ready;
--			data_request_stage(0) <= data_request;
--			data_request_stage(1) <= data_request_stage(0);
--		end if;
--	end process;
--	data_request <= '1' when data_ready = '1' and data_sync = '0' else '0';
--	data_request_interrupt <= data_request or data_request_stage(0) or data_request_stage(1);
	data_request_interrupt <= data_ready;

end architecture main;
