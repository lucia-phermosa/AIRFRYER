LIBRARY ieee;
USE ieee.std_logic_1164.all;
--
Entity fsm is 
  Port( reset, clk, ok: in std_logic;
       switches: in std_logic_vector(0 to 5);
       led: out std_logic
       TIEMPO : out STD_LOGIC_VECTOR (5 downto 0); --MAXIMO TIEMPO 63 SEGUNDOS "111111"
       TEMPERATURA : out STD_LOGIC_VECTOR (7 downto 0); --MAXIMA TEMP 255 GRADOS "11111111");
  end fsm;
  
  
  
 
  
