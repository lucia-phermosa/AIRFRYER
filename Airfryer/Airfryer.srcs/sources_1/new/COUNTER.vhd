----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:13:14
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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
use IEEE.numeric_std.ALL;

entity COUNTER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;     
           MANUAL : in STD_LOGIC; -- interruptor para indicar que haremos cuenta manual
           TEMP_TIME : in STD_LOGIC_VECTOR (3 downto 0); --cuatro botones
           TIEMPO : out STD_LOGIC_VECTOR (7 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
           TEMPERATURA : out STD_LOGIC_VECTOR (7 downto 0) --MAXIMA TEMP 255 GRADOS "11111111"
    );       
end COUNTER;

architecture Behavioral of COUNTER is
   --signal q1: STD_LOGIC_VECTOR range'TEMPERATURA; -- Rango de temperatura 0-300
   --signal q2: STD_LOGIC_VECTOR range'TIEMPO; -- Rango de tiempo 0-30
    signal q1: unsigned (TEMPERATURA'range);
    signal q2: unsigned (TIEMPO'range);
begin
    
    process(CLK,RESET)
    begin  
       if RESET = '1' then 
          q1 <=(OTHERS => '0');
          q2 <= (OTHERS => '0');
       elsif CLK'event and CLK = '1' then 
          if MANUAL = '0' then
               q1 <=(OTHERS => '0');
               q2 <= (OTHERS => '0');
           elsif MANUAL = '1' then   
             if(TEMP_TIME(0) = '1') then
                   --q1 <= q1 + "00010100"; -- Incrementa la temperatura en 20 grados
                 q1 <= q1 + 20;
             elsif (TEMP_TIME(1) = '1') then
                   -- q1 <= q1 - "00001010"; -- Decrementa la temperatura en 10 grados
                  q1 <= q1 - 10;
             elsif (TEMP_TIME(2) = '1') then
                  -- q2 <= q2 + "000101"; -- Incrementa el tiempo en 5 segundos
                 q2 <= q2 + 5;
             elsif (TEMP_TIME(3) = '1') then
                   --q2 <= q2 - "000001"; -- Decrementa el tiempo en 1 segundo
                 q2 <= q2 - 1;
             end if;
          end if;
       end if;
    end process;
    
    TEMPERATURA <= std_logic_vector(q1); -- Salida temperatura
    TIEMPO <= std_logic_vector(q2); -- Salida tiempo

end Behavioral;