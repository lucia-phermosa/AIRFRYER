----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:18:18
-- Design Name: 
-- Module Name: CLK1KHZ - Behavioral
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
 
entity clk1kHz is
    Port (
        CLK: in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        CLK_1khz : out STD_LOGIC
    );
end clk1kHz;
 
architecture Behavioral of clk1kHz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 49999 := 0;
begin
    divisor_frecuencia: process (reset, CLK) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(CLK) then
            if (contador = 49999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador+1;
            end if;
        end if;
    end process;
     
    CLK_1khz <= temporal;
    
end Behavioral;
