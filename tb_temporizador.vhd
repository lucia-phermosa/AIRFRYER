
library ieee;
use ieee.std_logic_1164.all;

entity tb_temporizador is
end tb_temporizador;

architecture tb of tb_temporizador is

    component temporizador
        port (reset        : in std_logic;
              clk          : in std_logic;
              ok           : in std_logic;
              ready        : in std_logic;
              finish       : out std_logic;
              salida_time  : out std_logic_vector (7 downto 0);
              display_time : in std_logic_vector (7 downto 0));
    end component;

    signal reset        : std_logic;
    signal clk          : std_logic;
    signal ok           : std_logic;
    signal ready        : std_logic;
    signal finish       : std_logic;
    signal salida_time  : std_logic_vector (7 downto 0);
    signal display_time : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : temporizador
    port map (reset        => reset,
              clk          => clk,
              ok           => ok,
              ready        => ready,
              finish       => finish,
              salida_time  => salida_time,
              display_time => display_time);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ok <= '0';
        ready <= '0';
        display_time <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- EDIT Add stimuli here
        wait for TbPeriod;
        ok <= '0';
        ready <= '1';
        display_time <= (others => '0');
        wait for TbPeriod;
        ok <= '0';
        ready <= '1';
        display_time <= "00011111";
        wait for TbPeriod;
        ok <= '0';
        ready <= '1';
        display_time <= "00011111";
        wait for TbPeriod;
        ok <= '0';
        ready <= '1';
        display_time <= "00011111";
        wait for 100*TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_temporizador of tb_temporizador is
    for tb
    end for;
end cfg_tb_temporizador;
