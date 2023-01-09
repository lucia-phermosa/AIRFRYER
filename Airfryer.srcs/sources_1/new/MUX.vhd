----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 12:43:29
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity MUX is
    Port (
        refrescar_anodo : in std_logic_vector(7 downto 0);
        
        time_u : in std_logic_vector(3 downto 0);
        time_d : in std_logic_vector(3 downto 0);
        time_c : in std_logic_vector(3 downto 0);
        temp_u : in std_logic_vector(3 downto 0);
        temp_d : in std_logic_vector(3 downto 0);
        temp_c : in std_logic_vector(3 downto 0);
        
        code : out std_logic_vector(3 downto 0)
        
    );
end MUX;

architecture Behavioral of MUX is
    
with refrescar_anodo select
    code <= time_u when  "11111110",
            time_d when  "11111101",
            time_c when  "11111011",
            temp_u when  "11101111",
            temp_d when  "11011111",
            time_c when  "10111111",
            "11111111" when others;
   
end Behavioral;
