----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:12:20
-- Design Name: 
-- Module Name: CONV_BIN_BCD - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Conv_Bin_BCD is
    Port ( Bin : in   STD_LOGIC_VECTOR (7 downto 0);
           Cen : out  STD_LOGIC_VECTOR (3 downto 0);
           Dec : out  STD_LOGIC_VECTOR (3 downto 0);
           Uni : out  STD_LOGIC_VECTOR (3 downto 0));
end Conv_Bin_BCD;

architecture Behavioral of Conv_Bin_BCD is

begin

Process(Bin)
variable Z: STD_LOGIC_VECTOR (19 downto 0);
begin

 for i in 0 to 19 loop
 Z(i) := '0';
 end loop;

 Z(10 downto 3) := Bin;


 for i in 0 to 4 loop

    if Z(11 downto 8) > 4 then
  Z(11 downto 8) := Z(11 downto 8) + 3;
  end if;
 
  if Z(15 downto 12) > 4 then
  Z(15 downto 12) := Z(15 downto 12) + 3;
    end if;
 
  Z(17 downto 1) := Z(16 downto 0);
  end  loop;
   
 
  
  Cen <= Z(19 downto 16);
  Dec <= Z(15 downto 12);
  Uni <= Z(11 downto 8);
end Process;
end Behavioral;