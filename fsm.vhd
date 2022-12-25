LIBRARY ieee;
USE ieee.std_logic_1164.all;
--
Entity fsm is 
  Port( reset, clk, ok: in std_logic;
       switches: in std_logic_vector(0 to 5);
       led: out std_logic
       TIEMPO : in STD_LOGIC_VECTOR (5 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
       TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); --MAXIMA TEMP 255 GRADOS "11111111");
       display_time:out STD_LOGIC_VECTOR (5 downto 0);
       display_temp: in STD_LOGIC_VECTOR (7 downto 0));
  end fsm;
  
  Architecture descripcion of fsm is
       TYPE estado is
       (comienzo, manual, automatico, ejecucion, listo);
       signal presente:estado:=comienzo;
       signal rescont: boolean:=false;
       
  
 
  
