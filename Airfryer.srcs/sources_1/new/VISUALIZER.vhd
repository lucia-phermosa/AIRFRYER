----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 12:55:04
-- Design Name: 
-- Module Name: VISUALIZER - Behavioral
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

entity VISUALIZER is
    Port (
        clk : in std_logic;
        time_u : in std_logic_vector(3 downto 0);
        time_d : in std_logic_vector(3 downto 0);
        time_c : in std_logic_vector(3 downto 0);
        temp_u : in std_logic_vector(3 downto 0);
        temp_d : in std_logic_vector(3 downto 0);
        temp_c : in std_logic_vector(3 downto 0);
        segment : out std_logic_vector(6 downto 0);
        AN : out std_logic_vector(6 downto 0)
    );
end VISUALIZER;

architecture Behavioral of VISUALIZER is
   signal code1 : std_logic_vector(3 downto 0);
   signal code2 : std_logic_vector(3 downto 0);     
   signal code3 : std_logic_vector(3 downto 0);
   signal code4 : std_logic_vector(3 downto 0);
   signal code5 : std_logic_vector(3 downto 0);
   signal code6 : std_logic_vector(3 downto 0);
   signal code7 : std_logic_vector(3 downto 0);
   signal code8 : std_logic_vector(3 downto 0);
   
   signal code : std_logic_vector(3 downto 0);
   
   Component Control_Anodo
      Port ( CLK : in std_logic;
        code1 : in std_logic_vector(3 downto 0);
        code2 : in std_logic_vector(3 downto 0);
        code3 : in std_logic_vector(3 downto 0);
        code4 : in std_logic_vector(3 downto 0);
        code5 : in std_logic_vector(3 downto 0);
        code6 : in std_logic_vector(3 downto 0);
        code7 : in std_logic_vector(3 downto 0);
        code8 : in std_logic_vector(3 downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0); 
      );
   End component;
   
   Component MUX
      Port ( refrescar_anodo : in std_logic_vector(7 downto 0);
        
        time_u : in std_logic_vector(3 downto 0);
        time_d : in std_logic_vector(3 downto 0);
        time_c : in std_logic_vector(3 downto 0);
        temp_u : in std_logic_vector(3 downto 0);
        temp_d : in std_logic_vector(3 downto 0);
        temp_c : in std_logic_vector(3 downto 0);
        
        code : out std_logic_vector(3 downto 0);
      );
   End component;
   
   Component decoder
      Port ( code : in std_logic_vector(3 DOWNTO 0);
             led : out std_logic_vector(6 DOWNTO 0)
      );
   End component;
   
begin
   
   Inst_ControlAnodo: Control_Anodo Port Map (
        CLK => clk,
        code1 => code1,
        code2 => code2, 
        code3 => code3, 
        code4 => code4,
        code5 => code5,
        code6 => code6,
        code7 => code7,
        code8 => code8,      
        refrescar_anodo => AN
   );
   
   Inst_MUX: MUX Port Map (
        refrescar_anodo => AN,
        
        time_u => time_u,
        time_d => time_d,
        time_c => time_c,
        temp_u => temp_u,
        temp_d => temp_d,
        temp_c => temp_c,
        
        code => code
   );
   
  Inst_deco: decoder Port Map (
        code => code,
        led => segment
  );

end Behavioral;
