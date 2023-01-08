----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:16:30
-- Design Name: 
-- Module Name: synchronzr - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRONZR is
    Port ( CLK : in STD_LOGIC;
           ASYNC_IN : in STD_LOGIC;
           SYNC_OUT : out STD_LOGIC);
end SYNCHRONZR;

architecture Behavioral of SYNCHRONZR is
   signal sreg : std_logic_vector(1 downto 0);
begin
   process (CLK)
   begin
     if rising_edge(CLK) then
        sync_out <= sreg(1);
        sreg <= sreg(0) & async_in;
     end if;
   end process;
end Behavioral;