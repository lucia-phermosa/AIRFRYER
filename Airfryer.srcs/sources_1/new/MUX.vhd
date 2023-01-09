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
        
        tiempo_u : out std_logic_vector(3 downto 0);
        tiempo_d : out std_logic_vector(3 downto 0);
        tiempo_c : out std_logic_vector(3 downto 0);
        temperatura_u : out std_logic_vector(3 downto 0);
        temperatura_d : out std_logic_vector(3 downto 0);
        temperatura_c : out std_logic_vector(3 downto 0)
        
    );
end MUX;

architecture Behavioral of MUX is
    
begin
    process(refrescar_anodo)
    begin
        if refrescar_anodo(0)='0' then 
            tiempo_u <= time_u;
        elsif refrescar_anodo(1)='0' then 
            tiempo_d <= time_d;
        elsif refrescar_anodo(2)='0' then 
            tiempo_c <= time_c;
        elsif refrescar_anodo(3)='0' then 
            tiempo_u <= time_u;
            tiempo_d <= time_d;
            tiempo_c <= time_c;
        elsif refrescar_anodo(4)='0' then 
            temperatura_u <= temp_u;
        elsif refrescar_anodo(5)='0' then 
            temperatura_d <= temp_d;
        elsif refrescar_anodo(6)='0' then 
            temperatura_c <= temp_c;
        elsif refrescar_anodo(7)='0' then 
            tiempo_u <= time_u;
            tiempo_d <= time_d;
            tiempo_c <= time_c;
            temperatura_u <= temp_u;
            temperatura_d <= temp_d;
            temperatura_c <= temp_c;
        end if;
    end process;
end Behavioral;
