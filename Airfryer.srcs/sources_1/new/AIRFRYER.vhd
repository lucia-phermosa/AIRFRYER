----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2023 13:10:55
-- Design Name: 
-- Module Name: AIRFRYER - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity AIRFRYER is
   Port (
      RESET : in std_logic;
      CLK : in std_logic;
      OK : in std_logic;
      Switches : in std_logic_vector(5 downto 0); 
      Temp_time : in std_logic_vector(3 downto 0);
      Led : out std_logic;
      Segment : out std_logic_vector(6 downto 0);
      AN : out std_logic_vector(7 downto 0)
   );     
end AIRFRYER;

architecture Behavioral of AIRFRYER is
   signal boton_sync1: std_logic;
   signal boton_edge1: std_logic;
   signal boton_sync2: std_logic_vector(temp_time'range);
   signal boton_edge2: std_logic_vector (temp_time'range);
   signal sel_temp: std_logic_vector(7 downto 0); -- Salida del counter
   signal sel_tiempo: std_logic_vector(7 downto 0); -- Salida del counter
   signal temp: std_logic_vector(7 downto 0); -- Salida de la fsm
   signal tiempo: std_logic_vector(7 downto 0); -- Salida de la fsm
   signal tiempo1: std_logic_vector(7 downto 0); -- Salida del temporizador
-------------------------------------------------------------------------------
   signal tiempo_u: std_logic_vector(3 downto 0); -- unidades
   signal tiempo_d: std_logic_vector(3 downto 0); -- decenas
   signal tiempo_c: std_logic_vector(3 downto 0); -- centenas
   signal temp_u: std_logic_vector(3 downto 0); -- unidades
   signal temp_d: std_logic_vector(3 downto 0); -- decenas
   signal temp_c: std_logic_vector(3 downto 0); -- centenas

   signal fin_de_cuenta:std_logic;
   signal read_y:std_logic;
   
   Component SYNCHRONZR
      Port ( CLK : in STD_LOGIC;
             ASYNC_IN : in STD_LOGIC;
             SYNC_OUT : out STD_LOGIC
      );
   End component;
   
   Component EDGEDTCTR
      Port ( CLK : in STD_LOGIC;
             SYNC_IN : in STD_LOGIC;
             EDGE : out STD_LOGIC
      );
   End component;
   
   Component COUNTER
      Port ( CLK : in STD_LOGIC;
             RESET : in STD_LOGIC;     
             TEMP_TIME : in STD_LOGIC_VECTOR (3 downto 0);
             TIEMPO : out STD_LOGIC_VECTOR (7 downto 0); 
             TEMPERATURA : out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
   
   Component fsm
      Port ( reset, clk,fin_cuenta: in std_logic;
             switches: in std_logic_vector(0 to 5);
             led,ready: out std_logic;
             TIEMPO : in STD_LOGIC_VECTOR (7 downto 0); 
             TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); 
             display_time:out STD_LOGIC_VECTOR (7 downto 0);
             display_temp: out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
     
   Component temporizador
      Port ( reset, clk,ready: in std_logic;
             finish: out std_logic;
             display_time:in STD_LOGIC_VECTOR (7 downto 0);
            salida_time: out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
   
   Component decoder
      Port ( code : in std_logic_vector(3 DOWNTO 0);
             led : out std_logic_vector(6 DOWNTO 0)
      );
   End component; 
   
   Component Conv_Bin_BCD
      Port ( Bin : in std_logic_vector(7 DOWNTO 0);
             Cen: out std_logic_vector(3 DOWNTO 0);
             Dec: out std_logic_vector(3 DOWNTO 0);
             Uni: out std_logic_vector(3 DOWNTO 0)
      );
   End component; 
   
   Component VISUALIZER
      Port ( clk : in std_logic;
        time_u : in std_logic_vector(3 downto 0);
        time_d : in std_logic_vector(3 downto 0);
        time_c : in std_logic_vector(3 downto 0);
        temp_u : in std_logic_vector(3 downto 0);
        temp_d : in std_logic_vector(3 downto 0);
        temp_c : in std_logic_vector(3 downto 0);
        segment : out std_logic_vector(6 downto 0);
        AN : out std_logic_vector(7 downto 0)
      );
   End component; 
   
begin
     
   Inst_SYNCHRONZR: SYNCHRONZR Port Map (
      CLK => CLK,
      ASYNC_IN => OK,
      SYNC_OUT => boton_sync1
   );
   
   Inst_EDGEDTCTR: EDGEDTCTR Port Map (
      CLK => CLK,
      SYNC_IN => boton_sync1,
      EDGE => boton_edge1
   );
   
   sincronizadores_buttons: for i in temp_time'range generate
     Inst_SYNCHRONZR_i: SYNCHRONZR Port Map (
       CLK => CLK,
       ASYNC_IN => Temp_time(i),
       SYNC_OUT => boton_sync2(i)
     );
     Inst_EDGEDTCTR_i: EDGEDTCTR Port Map (
       CLK => CLK,
       SYNC_IN => boton_sync2(i),
       EDGE => boton_edge2(i)
    );
  end generate;
  
  Inst_COUNTER: COUNTER Port Map (
      CLK => CLK,
      RESET => RESET,    
      TEMP_TIME => boton_edge2,
      TIEMPO => sel_tiempo ,
      TEMPERATURA => sel_temp
   );
   
  Inst_fsm: fsm Port Map (
      reset=>RESET,
      clk=>CLK,
      ready=>read_y,
      fin_cuenta=>fin_de_cuenta,
      switches=>Switches,
      led=>Led,
      TIEMPO=>sel_tiempo,
      TEMPERATURA =>sel_temp,
      display_time=>tiempo,
      display_temp=>temp
  );
     
  Inst_temporizador: temporizador Port Map(
     reset=>RESET,
     clk=>CLK,
     ready=>read_y,
     finish=>fin_de_cuenta,
     display_time=>tiempo,
     salida_time =>tiempo1
     
  );
  Inst_Conv_Bin_BCD_time: Conv_Bin_BCD Port Map (
         Bin=>tiempo1,
         Cen=>tiempo_c,
         Dec=>tiempo_d,
         Uni=>tiempo_u
      
   );
   Inst_Conv_Bin_BCD_temp: Conv_Bin_BCD Port Map (
         Bin=>temp,
         Cen=>temp_c,
         Dec=>temp_d,
         Uni=>temp_u
   );
       
   Inst_visualizer: VISUALIZER Port Map(
        clk => CLK,
        time_u => tiempo_u,
        time_d  => tiempo_d,
        time_c => tiempo_c,
        temp_u => temp_u,
        temp_d => temp_d,
        temp_c => temp_c, 
        segment => Segment,
        AN => AN
     );

end Behavioral;
