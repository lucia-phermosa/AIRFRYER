library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
   signal boton_sync2: std_logic;
   signal boton_edge2: std_logic;
   signal sel_temp: std_logic_vector(7 downto 0); -- Salida del counter
   signal sel_tiempo: std_logic_vector(5 downto 0); -- Salida del counter
   signal temp: std_logic_vector(7 downto 0); -- Salida de la fsm
   signal tiempo: std_logic_vector(5 downto 0); -- Salida de la fsm
   signal time: std_logic_vector(5 downto 0); -- Salida del temporizador

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
             led: out std_logic;
             TIEMPO : in STD_LOGIC_VECTOR (5 downto 0); 
             TEMPERATURA : in STD_LOGIC_VECTOR (7 downto 0); 
             display_time:out STD_LOGIC_VECTOR (5 downto 0);
             display_temp: out STD_LOGIC_VECTOR (7 downto 0)
      );
   End component;
     
   Component temporizador
      Port ( reset, clk, ok,ready: in std_logic;
             finish: out std_logic;
             display_time:in STD_LOGIC_VECTOR (5 downto 0)
      );
   End component;
   
   Component decoder1
      Port ( code : in std_logic_vector(3 DOWNTO 0);
             led : out std_logic_vector(6 DOWNTO 0)
      );
   End component; 
   
begin


end Behavioral;
