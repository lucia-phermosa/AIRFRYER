library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNTER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;     
           TEMP_TIME : in STD_LOGIC_VECTOR (3 downto 0); --cuatro botones
           TIEMPO : out STD_LOGIC_VECTOR (5 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
           TEMPERATURA : out STD_LOGIC_VECTOR (7 downto 0); --MAXIMA TEMP 255 GRADOS "11111111"
           
end COUNTER;

architecture Behavioral of COUNTER is
   signal q1: STD_LOGIC_VECTOR range'TIEMPO; -- Rango de temperatura 0-300
   signal q2: STD_LOGIC_VECTOR range'TEMPERATURA; -- Rango de tiempo 0-30
begin
    
    process(CLK,RESET)
    begin  
       if RESET = '1' then 
          q1 <=(OTHERS = > '0');
          q2 <= (OTHERS = > '0');
       elsif CLK'event and CLK = '1' then 
          if(TEMP_TIME(0) = '1') then
             q1 <= q1 + "000101"; -- Incrementa la temperatura en 20 grados
          elsif (TEMP_TIME(1) = '1') then
                q1 <= q1 - "001010"; -- Decrementa la temperatura en 10 grados
          elsif (TEMP_TIME(2) = '1') then
                q2 <= q2 + 5; -- Incrementa el tiempo en 5 segundos
          elsif (TEMP_TIME(3) = '1') then
                q2 <= q2 - 1; -- Decrementa el tiempo en 1 segundo
          end if;
       end if;
    end process;
    
    CODE(0) <= INTEGER (q1); -- Salida temperatura
    CODE(1) <= INTEGER (q2); -- Salida tiempo

end Behavioral;
