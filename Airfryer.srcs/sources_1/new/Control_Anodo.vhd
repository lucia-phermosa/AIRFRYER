----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 12:40:24
-- Design Name: 
-- Module Name: Control_Anodo - Behavioral
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


entity Control_Anodo is
   
    port(
        CLK : in std_logic;
        code1 : in std_logic_vector(3 downto 0);
        code2 : in std_logic_vector(3 downto 0);
        code3 : in std_logic_vector(3 downto 0);
        code4 : in std_logic_vector(3 downto 0);
        code5 : in std_logic_vector(3 downto 0);
        code6 : in std_logic_vector(3 downto 0);
        code7 : in std_logic_vector(3 downto 0);
        code8 : in std_logic_vector(3 downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0)
    );
end Control_Anodo;

architecture Behavioral of Control_Anodo is
    signal flag : integer := 1;
   
begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if flag=1 then
                refrescar_anodo(0) <=  '0';
                refrescar_anodo(7 downto 1) <=  "1111111";
                flag<=2;
            end if;
            if flag=2 then
                refrescar_anodo(1) <=  '0';
                refrescar_anodo(0) <=  '1';
                refrescar_anodo(7 downto 2) <=  "111111";
                flag<=3;
            end if;
            if flag=3 then
                refrescar_anodo(2) <=  '0';
                refrescar_anodo(1 downto 0) <=  "11";
                refrescar_anodo(7 downto 3) <=  "11111";
                flag<=4;
            end if;
            if flag=4 then
                refrescar_anodo(3) <=  '0';
                refrescar_anodo(2 downto 0) <=  "111";
                refrescar_anodo(7 downto 4) <=  "1111";
                flag<=5;
            end if;
            if flag=5 then
                refrescar_anodo(4) <=  '0';
                refrescar_anodo(3 downto 0) <=  "1111";
                refrescar_anodo(7 downto 5) <=  "111";
                flag<=6;
            end if;
            if flag=6 then
                refrescar_anodo(5) <=  '0';
                refrescar_anodo(4 downto 0) <=  "11111";
                refrescar_anodo(7 downto 6) <=  "11";
                flag<=7;
            end if;
            if flag=7 then
                refrescar_anodo(6) <=  '0';
                refrescar_anodo(5 downto 0) <=  "111111";
                refrescar_anodo(7) <=  '1';
                flag<=8;
            end if;
            if flag=8 then
                refrescar_anodo(7) <=  '0';
                refrescar_anodo(6 downto 0) <=  "1111111";
                flag<=1;
            end if;
        end if;

    end process;

end Behavioral;
