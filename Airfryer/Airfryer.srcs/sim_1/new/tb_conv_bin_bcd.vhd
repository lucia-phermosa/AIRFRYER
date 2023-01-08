----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:25:35
-- Design Name: 
-- Module Name: tb_conv_bin_bcd - Behavioral
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

entity tb_Conv_Bin_BCD is
end tb_Conv_Bin_BCD;

architecture tb of tb_Conv_Bin_BCD is

    component Conv_Bin_BCD
        port (Bin : in std_logic_vector (7 downto 0);
              Cen : out std_logic_vector (3 downto 0);
              Dec : out std_logic_vector (3 downto 0);
              Uni : out std_logic_vector (3 downto 0));
    end component;

    signal Bin : std_logic_vector (7 downto 0);
    signal Cen : std_logic_vector (3 downto 0);
    signal Dec : std_logic_vector (3 downto 0);
    signal Uni : std_logic_vector (3 downto 0);

begin

    dut : Conv_Bin_BCD
    port map (Bin => Bin,
              Cen => Cen,
              Dec => Dec,
              Uni => Uni);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Bin <= (others => '0');

        -- EDIT Add stimuli here
Bin<= "11111111";
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Conv_Bin_BCD of tb_Conv_Bin_BCD is
    for tb
    end for;
end cfg_tb_Conv_Bin_BCD;