----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:14:25
-- Design Name: 
-- Module Name: DECODER - Behavioral
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
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY decoder IS
    PORT (
        code : IN std_logic_vector(3 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0)
     );
END ENTITY decoder;

ARCHITECTURE dataflow OF decoder IS
    BEGIN
    WITH code SELECT
        led <=  "0000001" WHEN "0000",--0
                "1001111" WHEN "0001",--1
                "0010010" WHEN "0010",--2
                "0000110" WHEN "0011",--3
                "1001100" WHEN "0100",--4
                "0100100" WHEN "0101",--5
                "0100000" WHEN "0110",--6
                "0001111" WHEN "0111",--7
                "0000000" WHEN "1000",--8
                "0000100" WHEN "1001";--9
               
END ARCHITECTURE dataflow;