----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 16:14:36
-- Design Name: 
-- Module Name: tb_VISUALIZER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_VISUALIZER is
end tb_VISUALIZER;

architecture tb of tb_VISUALIZER is

    component VISUALIZER
        port (clk     : in std_logic;
              time_u  : in std_logic_vector (3 downto 0);
              time_d  : in std_logic_vector (3 downto 0);
              time_c  : in std_logic_vector (3 downto 0);
              temp_u  : in std_logic_vector (3 downto 0);
              temp_d  : in std_logic_vector (3 downto 0);
              temp_c  : in std_logic_vector (3 downto 0);
              segment : out std_logic_vector (6 downto 0);
              AN      : out std_logic_vector (6 downto 0));
    end component;

    signal reset : std_logic;
    signal clk     : std_logic;
    signal time_u  : std_logic_vector (3 downto 0);
    signal time_d  : std_logic_vector (3 downto 0);
    signal time_c  : std_logic_vector (3 downto 0);
    signal temp_u  : std_logic_vector (3 downto 0);
    signal temp_d  : std_logic_vector (3 downto 0);
    signal temp_c  : std_logic_vector (3 downto 0);
    signal segment : std_logic_vector (6 downto 0);
    signal AN      : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : VISUALIZER
    port map (clk     => clk,
              time_u  => time_u,
              time_d  => time_d,
              time_c  => time_c,
              temp_u  => temp_u,
              temp_d  => temp_d,
              temp_c  => temp_c,
              segment => segment,
              AN      => AN);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        time_u <= (others => '0');
        time_d <= (others => '0');
        time_c <= (others => '0');
        temp_u <= (others => '0');
        temp_d <= (others => '0');
        temp_c <= (others => '0');

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_VISUALIZER of tb_VISUALIZER is
    for tb
    end for;
end cfg_tb_VISUALIZER;
