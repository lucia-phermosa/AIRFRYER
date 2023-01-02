-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 2.1.2023 17:39:05 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_COUNTER is
end tb_COUNTER;

architecture tb of tb_COUNTER is

    component COUNTER
        port (CLK         : in std_logic;
              RESET       : in std_logic;
              MANUAL      : in std_logic;
              TEMP_TIME   : in std_logic_vector (3 downto 0);
              TIEMPO      : out std_logic_vector (5 downto 0);
              TEMPERATURA : out std_logic_vector (7 downto 0));
    end component;

    signal CLK         : std_logic;
    signal RESET       : std_logic;
    signal MANUAL      : std_logic;
    signal TEMP_TIME   : std_logic_vector (3 downto 0);
    signal TIEMPO      : std_logic_vector (5 downto 0);
    signal TEMPERATURA : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : COUNTER
    port map (CLK         => CLK,
              RESET       => RESET,
              MANUAL      => MANUAL,
              TEMP_TIME   => TEMP_TIME,
              TIEMPO      => TIEMPO,
              TEMPERATURA => TEMPERATURA);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        MANUAL <= '0';
        TEMP_TIME <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        
        TEMP_TIME <= "0100";
        wait for 100 * TbPeriod;
        MANUAL<='1';
        wait for 100 * TbPeriod;
        TEMP_TIME <= "0001";
        wait for 100 * TbPeriod;
        TEMP_TIME <= "0010";
        wait for 100 * TbPeriod;
        TEMP_TIME <= "0101";
        wait for 100 * TbPeriod;
        TEMP_TIME <= "1000";

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_COUNTER of tb_COUNTER is
    for tb
    end for;
end cfg_tb_COUNTER;
