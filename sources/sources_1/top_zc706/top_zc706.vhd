--------------------------------------------------------------
--
-- (C) Copyright Kutu Pty. Ltd. 2014.
--
-- file: top_zc706.vhd
--
-- author: Greg Smart
--
--------------------------------------------------------------
--------------------------------------------------------------
--
-- This module is the top level module of zc706_base
-- running on a Xilinx ZC706 board.
--
--------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity top_zc706 is
   port (
      DDR_addr          : inout std_logic_vector ( 14 downto 0 );
      DDR_ba            : inout std_logic_vector ( 2 downto 0 );
      DDR_cas_n         : inout std_logic;
      DDR_ck_n          : inout std_logic;
      DDR_ck_p          : inout std_logic;
      DDR_cke           : inout std_logic;
      DDR_cs_n          : inout std_logic;
      DDR_dm            : inout std_logic_vector ( 3 downto 0 );
      DDR_dq            : inout std_logic_vector ( 31 downto 0 );
      DDR_dqs_n         : inout std_logic_vector ( 3 downto 0 );
      DDR_dqs_p         : inout std_logic_vector ( 3 downto 0 );
      DDR_odt           : inout std_logic;
      DDR_ras_n         : inout std_logic;
      DDR_reset_n       : inout std_logic;
      DDR_we_n          : inout std_logic;
      FIXED_IO_ddr_vrn  : inout std_logic;
      FIXED_IO_ddr_vrp  : inout std_logic;
      FIXED_IO_mio      : inout std_logic_vector ( 53 downto 0 );
      FIXED_IO_ps_clk   : inout std_logic;
      FIXED_IO_ps_porb  : inout std_logic;
      FIXED_IO_ps_srstb : inout std_logic;
      hdmio_clk         : out std_logic;
      hdmio_data        : out std_logic_vector ( 23 downto 0 );
      hdmio_de          : out std_logic;
      hdmio_hsync       : out std_logic;
      hdmio_vsync       : out std_logic;
      spdif_tx          : out std_logic;
      gpio_led_left     : out std_logic;
      gpio_led_center   : out std_logic;
      gpio_led_right    : out std_logic;
      gpio_led_0        : out std_logic
   );
end top_zc706;

architecture RTL of top_zc706 is

   component system_top_wrapper is
   port (
      DDR_addr          : inout std_logic_vector ( 14 downto 0 );
      DDR_ba            : inout std_logic_vector ( 2 downto 0 );
      DDR_cas_n         : inout std_logic;
      DDR_ck_n          : inout std_logic;
      DDR_ck_p          : inout std_logic;
      DDR_cke           : inout std_logic;
      DDR_cs_n          : inout std_logic;
      DDR_dm            : inout std_logic_vector ( 3 downto 0 );
      DDR_dq            : inout std_logic_vector ( 31 downto 0 );
      DDR_dqs_n         : inout std_logic_vector ( 3 downto 0 );
      DDR_dqs_p         : inout std_logic_vector ( 3 downto 0 );
      DDR_odt           : inout std_logic;
      DDR_ras_n         : inout std_logic;
      DDR_reset_n       : inout std_logic;
      DDR_we_n          : inout std_logic;
      FIXED_IO_ddr_vrn  : inout std_logic;
      FIXED_IO_ddr_vrp  : inout std_logic;
      FIXED_IO_mio      : inout std_logic_vector ( 53 downto 0 );
      FIXED_IO_ps_clk   : inout std_logic;
      FIXED_IO_ps_porb  : inout std_logic;
      FIXED_IO_ps_srstb : inout std_logic;
      hdmio_clk         : out std_logic;
      hdmio_data        : out std_logic_vector ( 23 downto 0 );
      hdmio_de          : out std_logic;
      hdmio_hsync       : out std_logic;
      hdmio_vsync       : out std_logic;
      spdif_tx          : out std_logic;
      sys_resetn        : out std_logic_vector ( 0 to 0 );
      sys_clk           : out std_logic;
      sys_rd_cmd        : out std_logic;
      sys_rd_endcmd     : in  std_logic;
      sys_rdaddr        : out std_logic_vector ( 12 downto 2 );
      sys_rddata        : in  std_logic_vector ( 31 downto 0 );
      sys_wr_cmd        : out std_logic;
      sys_wraddr        : out std_logic_vector ( 12 downto 2 );
      sys_wrdata        : out std_logic_vector ( 31 downto 0 )
   );
   end component;

   component axi4_lite_test
   port (
      resetn               : in std_logic;
      clk                  : in std_logic; 

      -- write interface from system
      sys_wraddr           : in std_logic_vector(12 downto 2);                      -- address for reads/writes
      sys_wrdata           : in std_logic_vector(31 downto 0);                      -- data/no. bytes
      sys_wr_cmd           : in std_logic;                                          -- write strobe

      sys_rdaddr           : in std_logic_vector(12 downto 2);                      -- address for reads/writes
      sys_rddata           : out std_logic_vector(31 downto 0);                     -- input data port for read operation
      sys_rd_cmd           : in std_logic;                                          -- read strobe
      sys_rd_endcmd        : out std_logic;                                         -- input read strobe

      -- led output
      gpio_led             : out std_logic_vector(3 downto 0)
   );
   end component;

   signal sys_resetn       : std_logic_vector(0 downto 0);         
   signal sys_clk          : std_logic;                                          -- system clk (same as AXI clock
   signal sys_wraddr       : std_logic_vector(13 downto 2);                      -- address for reads/writes
   signal sys_wrdata       : std_logic_vector(31 downto 0);                      -- data/no. bytes
   signal sys_wr_cmd       : std_logic;                                          -- write strobe

   signal sys_rdaddr       : std_logic_vector(13 downto 2);                      -- address for reads/writes
   signal sys_rddata       : std_logic_vector(31 downto 0);                      -- input data port for read operation
   signal sys_rd_cmd       : std_logic;                                          -- read strobe
   signal sys_rd_endcmd    : std_logic;                                          -- input read strobe

   signal gpio_led         : std_logic_vector(3 downto 0); 

begin

   gpio_led_left     <= gpio_led(3);
   gpio_led_center   <= gpio_led(2);
   gpio_led_right    <= gpio_led(1);
   gpio_led_0        <= gpio_led(0);

   system_top_wrapper_1 : system_top_wrapper
   port map (
      DDR_addr(14 downto 0)      => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0)         => DDR_ba(2 downto 0),
      DDR_cas_n                  => DDR_cas_n,
      DDR_ck_n                   => DDR_ck_n,
      DDR_ck_p                   => DDR_ck_p,
      DDR_cke                    => DDR_cke,
      DDR_cs_n                   => DDR_cs_n,
      DDR_dm(3 downto 0)         => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0)        => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0)      => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0)      => DDR_dqs_p(3 downto 0),
      DDR_odt                    => DDR_odt,
      DDR_ras_n                  => DDR_ras_n,
      DDR_reset_n                => DDR_reset_n,
      DDR_we_n                   => DDR_we_n,
      FIXED_IO_ddr_vrn           => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp           => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0)  => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk            => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb           => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb          => FIXED_IO_ps_srstb,
      hdmio_clk                  => hdmio_clk,
      hdmio_data(23 downto 0)    => hdmio_data(23 downto 0),
      hdmio_de                   => hdmio_de,
      hdmio_hsync                => hdmio_hsync,
      hdmio_vsync                => hdmio_vsync,
      spdif_tx                   => spdif_tx,
      sys_resetn                 => sys_resetn,
      sys_clk                    => sys_clk,
      sys_rd_cmd                 => sys_rd_cmd,       -- read strobe
      sys_rd_endcmd              => sys_rd_endcmd,    -- input read strobe
      sys_rdaddr                 => sys_rdaddr,       -- address for reads/writes
      sys_rddata                 => sys_rddata,       -- input data port for read operation
      sys_wr_cmd                 => sys_wr_cmd,       -- write strobe
      sys_wraddr                 => sys_wraddr,       -- address for reads/writes
      sys_wrdata                 => sys_wrdata        -- data/no. bytes
   );

   UUT_test : axi4_lite_test
   port map (
      resetn               => sys_resetn(0),
      clk                  => sys_clk,                -- system clk (same as AXI clock

      -- write interface from system
      sys_wraddr           => sys_wraddr,             -- address for reads/writes
      sys_wrdata           => sys_wrdata,             -- data/no. bytes
      sys_wr_cmd           => sys_wr_cmd,             -- write strobe

      sys_rdaddr           => sys_rdaddr,             -- address for reads/writes
      sys_rddata           => sys_rddata,             -- input data port for read operation
      sys_rd_cmd           => sys_rd_cmd,             -- read strobe
      sys_rd_endcmd        => sys_rd_endcmd,          -- input read strobe

      -- led output
      gpio_led             => gpio_led
   );
   
end RTL;
