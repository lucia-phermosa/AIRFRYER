----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:19:09
-- Design Name: 
-- Module Name: FSM - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--
Entity fsm is 
  Port( reset, clk, ok,fin_cuenta: in std_logic;
       switches: in std_logic_vector(0 to 5);
       led,ready: out std_logic;
       TIEMPO : in STD_LOGIC_VECTOR (7 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
       TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); --MAXIMA TEMP 255 GRADOS "11111111");
       display_time:out STD_LOGIC_VECTOR (7 downto 0);
       display_temp: out STD_LOGIC_VECTOR (7 downto 0));
  end fsm;
  
  Architecture behavioral of fsm is
       TYPE estado is
       (comienzo, manual, automatico, ejecucion, listo);
       signal presente: estado;
       signal siguiente: estado;
       signal asig_time: STD_LOGIC_VECTOR (7 downto 0); -- Rango de temperatura 0-300
       signal asig_temp: STD_LOGIC_VECTOR (7 downto 0); -- Rango de tiempo 0-30

       Begin
         
         
   maquina: process(clk, reset)
       begin
       if reset = '1' then
         presente<=comienzo;
       elsif rising_edge(clk)  then
         presente <= siguiente;     
       end if;
  end process;
  
  nextstate_decod: process(ok, fin_cuenta, presente,switches,TIEMPO,TEMPERATURA)
    begin
        siguiente <= presente;
         case presente is
           when comienzo =>
            if switches="100000" then
              presente<=automatico;
            elsif switches="010000" then
              presente<=manual;
            end if;
            when automatico=>
            if switches="001000" then--pollo
              asig_time<="00110010";
              asig_temp<="01100100";
            elsif switches="000100" then--pescado
              asig_time<="00101101";
              asig_temp<="01101110";
            elsif switches="000010" then--patatas
              asig_time<="00101000";
              asig_temp<="01111000";
            elsif switches="000001" then--bollo
              asig_time<="00100011";
              asig_temp<="10000010";
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
       end process;
          
 salida: process(presente)
  begin
    case presente is
      when comienzo=>
        led<='0';
        display_time<="00000000";
        display_temp<="00000000";
         ready<='0';
      when manual =>
        led<='0';
        display_time<=asig_time;
        display_temp<=asig_temp;
        ready<='0';
        when automatico =>
        led<='0';
        display_time<=asig_time;
        display_temp<=asig_temp;
        ready<='0';
      when ejecucion=>
        led<='0';
        display_time<=asig_time;
        display_temp<=asig_temp;
        ready<='1';
      when listo=>
        led<='1';
        display_time<=asig_time;
        display_temp<=asig_temp;
        ready<='0';
   end case;
  end process salida;
end behavioral;
