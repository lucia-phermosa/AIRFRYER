LIBRARY ieee;
USE ieee.std_logic_1164.all;
--
Entity fsm is 
  Port( reset, clk, ok,fin_cuenta: in std_logic;
       switches: in std_logic_vector(0 to 5);
       led: out std_logic;
       TIEMPO : in STD_LOGIC_VECTOR (5 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
       TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); --MAXIMA TEMP 255 GRADOS "11111111");
       display_time:out STD_LOGIC_VECTOR (5 downto 0);
       display_temp: out STD_LOGIC_VECTOR (7 downto 0));
  end fsm;
  
  Architecture descripcion of fsm is
       TYPE estado is
       (comienzo, manual, automatico, ejecucion, listo);
       signal presente:estado:=comienzo;
       signal asig_time: STD_LOGIC_VECTOR (5 downto 0); -- Rango de temperatura 0-300
       signal asig_temp: STD_LOGIC_VECTOR (7 downto 0); -- Rango de tiempo 0-30

       Begin
         
         
       maquina:
       process(clk, reset)
       begin
       if reset='1' then
         presente<=comienzo;
       else if rising_edge(clk)  then
         case presente is
           when comienzo=>
            if switches='100000' then
              presente<=automatico;
            else if switches='010000' then
              presente<=manual;
            end if;
          when automatico=>
            if switches='001000' then--pollo
              asig_time:=110010;
              asig_temp:=1100100;
            else if switches='000100' then--pescado
              asig_time:=101101;
              asig_temp:=1101110;
            else if switches='000010' then--patatas
              asig_time:=101000;
              asig_temp:=1111000;
            else if switches='000001' then--bollo
              asig_time:=100011;
              asig_temp:=10000010;
            end if;
              presente<=ejecucion;
         when manual=>
              asig_time<=TIEMPO;
              asig_temp<=TEMPERATURA;
            if ok='1' then 
              presente<=ejecucion;
            end if;
         when ejecucion=>
            if fin_cuenta='1' then 
              presente<=listo;
            end if;
        when listo=>
            if ok='1' then
              presente<=comienzo;
            end if;
        end case;
        end if;
       end process maquina;
          
 salida:
  process(presente)
  begin
    case presente is
      when comienzo=>
        led<='0';
        display_time<='00000';
        display_temp<='0000000';
      when manual or automatico=>
        led<='0';
        display_time<=asig_time;
        display_temp<=asig_temp;
      when ejecucion=>
        led<='0';
        display_time<=asig_time;
        display_temp<=asig_temp;
      when listo=>
        led<='1';
        display_time<=asig_time;
        display_temp<=asig_temp;
   end case;
   end process salida;
     

     
     
   
     
   end descripcion;
  
 
  
