	component lms_ctr is
		port (
			avm_m0_address                          : out   std_logic_vector(7 downto 0);                     -- address
			avm_m0_read                             : out   std_logic;                                        -- read
			avm_m0_waitrequest                      : in    std_logic                     := 'X';             -- waitrequest
			avm_m0_readdata                         : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- readdata
			avm_m0_write                            : out   std_logic;                                        -- write
			avm_m0_writedata                        : out   std_logic_vector(7 downto 0);                     -- writedata
			avm_m0_readdatavalid                    : in    std_logic                     := 'X';             -- readdatavalid
			avm_m0_clk_clk                          : out   std_logic;                                        -- clk
			avm_m0_reset_reset                      : out   std_logic;                                        -- reset
			clk_clk                                 : in    std_logic                     := 'X';             -- clk
			dac_spi_ext_MISO                        : in    std_logic                     := 'X';             -- MISO
			dac_spi_ext_MOSI                        : out   std_logic;                                        -- MOSI
			dac_spi_ext_SCLK                        : out   std_logic;                                        -- SCLK
			dac_spi_ext_SS_n                        : out   std_logic;                                        -- SS_n
			exfifo_if_d_export                      : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			exfifo_if_rd_export                     : out   std_logic;                                        -- export
			exfifo_if_rdempty_export                : in    std_logic                     := 'X';             -- export
			exfifo_of_d_export                      : out   std_logic_vector(31 downto 0);                    -- export
			exfifo_of_wr_export                     : out   std_logic;                                        -- export
			exfifo_of_wrfull_export                 : in    std_logic                     := 'X';             -- export
			exfifo_rst_export                       : out   std_logic;                                        -- export
			flash_spi_MISO                          : in    std_logic                     := 'X';             -- MISO
			flash_spi_MOSI                          : out   std_logic;                                        -- MOSI
			flash_spi_SCLK                          : out   std_logic;                                        -- SCLK
			flash_spi_SS_n                          : out   std_logic;                                        -- SS_n
			fpga_spi_ext_MISO                       : in    std_logic                     := 'X';             -- MISO
			fpga_spi_ext_MOSI                       : out   std_logic;                                        -- MOSI
			fpga_spi_ext_SCLK                       : out   std_logic;                                        -- SCLK
			fpga_spi_ext_SS_n                       : out   std_logic_vector(2 downto 0);                     -- SS_n
			i2c_scl_export                          : inout std_logic                     := 'X';             -- export
			i2c_sda_export                          : inout std_logic                     := 'X';             -- export
			leds_external_connection_export         : out   std_logic_vector(7 downto 0);                     -- export
			lms_ctr_gpio_external_connection_export : out   std_logic_vector(3 downto 0);                     -- export
			reset_reset_n                           : in    std_logic                     := 'X';             -- reset_n
			switch_external_connection_export       : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			vctcxo_tamer_0_ctrl_export              : in    std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component lms_ctr;

	u0 : component lms_ctr
		port map (
			avm_m0_address                          => CONNECTED_TO_avm_m0_address,                          --                           avm_m0.address
			avm_m0_read                             => CONNECTED_TO_avm_m0_read,                             --                                 .read
			avm_m0_waitrequest                      => CONNECTED_TO_avm_m0_waitrequest,                      --                                 .waitrequest
			avm_m0_readdata                         => CONNECTED_TO_avm_m0_readdata,                         --                                 .readdata
			avm_m0_write                            => CONNECTED_TO_avm_m0_write,                            --                                 .write
			avm_m0_writedata                        => CONNECTED_TO_avm_m0_writedata,                        --                                 .writedata
			avm_m0_readdatavalid                    => CONNECTED_TO_avm_m0_readdatavalid,                    --                                 .readdatavalid
			avm_m0_clk_clk                          => CONNECTED_TO_avm_m0_clk_clk,                          --                       avm_m0_clk.clk
			avm_m0_reset_reset                      => CONNECTED_TO_avm_m0_reset_reset,                      --                     avm_m0_reset.reset
			clk_clk                                 => CONNECTED_TO_clk_clk,                                 --                              clk.clk
			dac_spi_ext_MISO                        => CONNECTED_TO_dac_spi_ext_MISO,                        --                      dac_spi_ext.MISO
			dac_spi_ext_MOSI                        => CONNECTED_TO_dac_spi_ext_MOSI,                        --                                 .MOSI
			dac_spi_ext_SCLK                        => CONNECTED_TO_dac_spi_ext_SCLK,                        --                                 .SCLK
			dac_spi_ext_SS_n                        => CONNECTED_TO_dac_spi_ext_SS_n,                        --                                 .SS_n
			exfifo_if_d_export                      => CONNECTED_TO_exfifo_if_d_export,                      --                      exfifo_if_d.export
			exfifo_if_rd_export                     => CONNECTED_TO_exfifo_if_rd_export,                     --                     exfifo_if_rd.export
			exfifo_if_rdempty_export                => CONNECTED_TO_exfifo_if_rdempty_export,                --                exfifo_if_rdempty.export
			exfifo_of_d_export                      => CONNECTED_TO_exfifo_of_d_export,                      --                      exfifo_of_d.export
			exfifo_of_wr_export                     => CONNECTED_TO_exfifo_of_wr_export,                     --                     exfifo_of_wr.export
			exfifo_of_wrfull_export                 => CONNECTED_TO_exfifo_of_wrfull_export,                 --                 exfifo_of_wrfull.export
			exfifo_rst_export                       => CONNECTED_TO_exfifo_rst_export,                       --                       exfifo_rst.export
			flash_spi_MISO                          => CONNECTED_TO_flash_spi_MISO,                          --                        flash_spi.MISO
			flash_spi_MOSI                          => CONNECTED_TO_flash_spi_MOSI,                          --                                 .MOSI
			flash_spi_SCLK                          => CONNECTED_TO_flash_spi_SCLK,                          --                                 .SCLK
			flash_spi_SS_n                          => CONNECTED_TO_flash_spi_SS_n,                          --                                 .SS_n
			fpga_spi_ext_MISO                       => CONNECTED_TO_fpga_spi_ext_MISO,                       --                     fpga_spi_ext.MISO
			fpga_spi_ext_MOSI                       => CONNECTED_TO_fpga_spi_ext_MOSI,                       --                                 .MOSI
			fpga_spi_ext_SCLK                       => CONNECTED_TO_fpga_spi_ext_SCLK,                       --                                 .SCLK
			fpga_spi_ext_SS_n                       => CONNECTED_TO_fpga_spi_ext_SS_n,                       --                                 .SS_n
			i2c_scl_export                          => CONNECTED_TO_i2c_scl_export,                          --                          i2c_scl.export
			i2c_sda_export                          => CONNECTED_TO_i2c_sda_export,                          --                          i2c_sda.export
			leds_external_connection_export         => CONNECTED_TO_leds_external_connection_export,         --         leds_external_connection.export
			lms_ctr_gpio_external_connection_export => CONNECTED_TO_lms_ctr_gpio_external_connection_export, -- lms_ctr_gpio_external_connection.export
			reset_reset_n                           => CONNECTED_TO_reset_reset_n,                           --                            reset.reset_n
			switch_external_connection_export       => CONNECTED_TO_switch_external_connection_export,       --       switch_external_connection.export
			vctcxo_tamer_0_ctrl_export              => CONNECTED_TO_vctcxo_tamer_0_ctrl_export               --              vctcxo_tamer_0_ctrl.export
		);

