LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity fsm is 
  Port( reset, clk, ok: in std_logic;
       switches: in std_logic_vector(0 to 5);
       led: out std_logic );
  end fsm;
  
  
  
 
  
