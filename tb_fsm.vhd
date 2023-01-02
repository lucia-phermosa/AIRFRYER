library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 2.1.2023 21:50:31 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm is
end tb_fsm;

architecture tb of tb_fsm is

    component fsm
        port (reset        : in std_logic;
              clk          : in std_logic;
              ok           : in std_logic;
              fin_cuenta   : in std_logic;
              switches     : in std_logic_vector (0 to 5);
              led          : out std_logic;
              TIEMPO       : in std_logic_vector (5 downto 0);
              TEMPERATURA  : in std_logic_vector (7 downto 0);
              display_time : out std_logic_vector (5 downto 0);
              display_temp : out std_logic_vector (7 downto 0));
    end component;

    signal reset        : std_logic;
    signal clk          : std_logic;
    signal ok           : std_logic;
    signal fin_cuenta   : std_logic;
    signal switches     : std_logic_vector (0 to 5);
    signal led          : std_logic;
    signal TIEMPO       : std_logic_vector (5 downto 0);
    signal TEMPERATURA  : std_logic_vector (7 downto 0);
    signal display_time : std_logic_vector (5 downto 0);
    signal display_temp : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : fsm
    port map (reset        => reset,
              clk          => clk,
              ok           => ok,
              fin_cuenta   => fin_cuenta,
              switches     => switches,
              led          => led,
              TIEMPO       => TIEMPO,
              TEMPERATURA  => TEMPERATURA,
              display_time => display_time,
              display_temp => display_temp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ok <= '0';
        fin_cuenta <= '0';
        switches <= (others => '0');
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '0';
        switches <= "100000";
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '0';
        switches <= "001000";
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '1';
        switches <= (others => '0');
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');
        wait for  TbPeriod;
        ok <= '1';
        fin_cuenta <= '0';
        switches <= (others => '0');
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '0';
        switches <= "010000";
        TIEMPO <= (others => '0');
        TEMPERATURA <= (others => '0');
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '0';
        switches <= (others => '0');
        TIEMPO <= "100011";
        TEMPERATURA <= "10000010";
        wait for  TbPeriod;
        ok <= '1';
        fin_cuenta <= '0';
        switches <= (others => '0');
        TIEMPO <= "100011";
        TEMPERATURA <= "10000010";
        wait for  TbPeriod;
        ok <= '0';
        fin_cuenta <= '1';
        switches <= (others => '0');
        TIEMPO <= "100011";
        TEMPERATURA <= "10000010";
        wait for  TbPeriod;
        ok <= '1';
        fin_cuenta <= '0';
        switches <= (others => '0');
        TIEMPO <= "100011";
        TEMPERATURA <= "10000010";

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fsm of tb_fsm is
    for tb
    end for;
end cfg_tb_fsm;
