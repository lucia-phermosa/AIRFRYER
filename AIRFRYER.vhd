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
      Display1: out std_logic_vector(6 downto 0);
      Display2: out std_logic_vector(6 downto 0)
   );     
end AIRFRYER;

architecture Behavioral of AIRFRYER is
   signal boton_sync1: std_logic;
   signal boton_edge1: std_logic;
   signal boton_sync2: std_logic_vector range'Temp_time;
   signal boton_edge2: std_logic_vector range'Temp_time;
   signal sel_temp: std_logic_vector(7 downto 0); -- Salida del counter
   signal sel_tiempo: std_logic_vector(5 downto 0); -- Salida del counter
   signal temp: std_logic_vector(7 downto 0); -- Salida de la fsm
   signal tiempo: std_logic_vector(5 downto 0); -- Salida de la fsm
   signal time: std_logic_vector(5 downto 0); -- Salida del temporizador
   signal clk_1khz: std_logic;
   signal fin_de_cuenta:std_logic;
   signal ready_:std_logic;

  Component clk1kHz 
      Port (CLK: in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            CLK_1khz : out STD_LOGIC
      );
  Component clk1Hz 
      Port (CLK: in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            CLK_1hz : out STD_LOGIC
      );
  End component;
   
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
             TIEMPO : out STD_LOGIC_VECTOR (5 downto 0); 
             TEMPERATURA : out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
   
   Component fsm
      Port ( reset, clk, ok,fin_cuenta: in std_logic;
             switches: in std_logic_vector(0 to 5);
             led,ready: out std_logic;
             TIEMPO : in STD_LOGIC_VECTOR (5 downto 0); 
             TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); 
             display_time:out STD_LOGIC_VECTOR (5 downto 0);
             display_temp: out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
     
   Component temporizador
      Port ( reset, clk,ready: in std_logic;
             finish: out std_logic;
             display_time:in STD_LOGIC_VECTOR (5 downto 0)
      );
   End component;
   
   Component decoder
      Port ( code : in std_logic_vector(3 DOWNTO 0);
             led : out std_logic_vector(6 DOWNTO 0)
      );
   End component; 
   
begin
  
   Inst_clk1kHz: clk1kHz Port Map (
         CLK => CLK,
         reset => RESET,
         CLK_1khz => clk_1khz
   );
   Inst_clk1Hz: clk1Hz Port Map (
         CLK => CLK,
         reset => RESET,
         CLK_1hz => clk_1hz
   );
     
   Inst_SYNCHRONZR: SYNCHRONZR Port Map (
      CLK => clk_1khz,
      ASYNC_IN => OK,
      SYNC_OUT => boton_sync1
   );
   
   Inst_EDGEDTCTR: EDGEDTCTR Port Map (
      CLK => clk_1khz,
      SYNC_IN => boton_sync1,
      EDGE => boton_edge1
   );
   
   sincronizadores_buttons: for i in temp_time'range generate
     Inst_SYNCHRONZR_i: SYNCHRONZR Port Map (
       CLK => clk_1khz,
       ASYNC_IN => Temp_time(i),
       SYNC_OUT => boton_sync2(i)
     );
     Inst_EDGEDTCTR_i: EDGEDTCTR Port Map (
       CLK => clk_1khz,
       SYNC_IN => boton_sync2(i),
       EDGE => boton_edge2(i)
    );
  end generate;
  
  Inst_COUNTER: COUNTER Port Map (
      CLK => clk_1khz,
      RESET => RESET,    
      TEMP_TIME => boton_edge2,
      TIEMPO => sel_tiempo ,
      TEMPERATURA => sel_temp
   );
   
  Inst_fsm: fsm Port Map (
      reset=>RESET,
      clk=>clk_1khz,
      ready=>ready_,
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
     clk=>clk_1hz,
     ready=>ready_,
     finish=>fin_de_cuenta,
     display_time=>tiempo
     
  );
 

end Behavioral;
