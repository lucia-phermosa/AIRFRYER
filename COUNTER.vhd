library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNTER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;     
           TEMP_TIME : in STD_LOGIC_VECTOR (3 downto 0);
           CODE : out INTEGER_VECTOR (1 downto 0));
end COUNTER;

architecture Behavioral of COUNTER is
   signal q1: integer RANGE 0 to 300; -- Rango de temperatura 0-300
   signal q2: integer RANGE 0 to 30; -- Rango de tiempo 0-30
begin
    
    process(CLK,RESET)
    begin  
       if RESET = '1' then 
          q1 <= 0;
          q2 <= 0;
       elsif CLK'event and CLK = '1' then 
          if(TEMP_TIME(0) = '1') then
             q1 <= q1 + 20; -- Incrementa la temperatura en 20 grados
          elsif (TEMP_TIME(1) = '1') then
                q1 <= q1 - 10; -- Decrementa la temperatura en 10 grados
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
