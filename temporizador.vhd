LIBRARY ieee;
USE ieee.std_logic_1164.all;
--
Entity temporizador is 
  Port( reset, clk, ok,ready: in std_logic;
       finish: out std_logic;
       display_time:in STD_LOGIC_VECTOR (5 downto 0));
  end temporizador;
  
  Architecture descripcion of temporizador is
       TYPE estado is
       (mode_cont, mode_done);
       signal presente:estado:=mode_done;
       signal rescont: boolean:=false;
       signal cuenta, asig_time: STD_LOGIC_VECTOR (5 downto 0); -- Rango de temperatura 0-300
       signal fin_cuenta:boolean;
       signal clk_1hz: std_logic;

       Component clk1Hz 
         Port (
           CLK: in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           CLK_1hz : out STD_LOGIC
         );
       End component;
         
   Begin   
       Inst_clk1Hz: clk1Hz Port Map (
         CLK => clk,
         reset => reset,
         CLK_1hz => clk_1hz
       );
         
         
       maquina:
       process(clk_1hz, reset)
       begin
       if reset='1' then
         presente<=mode_done;
       else if rising_edge(clk_1hz)  then
         case presente is
           when mode_done=>
            if ready='1' then
              presente<=mode_cont;
            end if;
          when mode_cont=>
            if fin_cuenta then 
                presente<=mode_done;
            end if;
        end case;
        end if;
       end process maquina;
          
 salida:
  process(presente)
  begin
    case presente is
      when mode_done=>
        finish<='1';
        asig_time<=display_time;
        rescont<=true;
      when mode_cont=>
        finish<='0';
        asig_time<=display_time;
        rescont<=false;
   end case;
   end process salida;
     
 contador:
 process(clk_1hz):
 begin
   if rising_edge(clk_1hz) then 
     if rescont then cuenta<='00000';
     else cuenta<=cuenta+'00001';
     end if;
   end if;
 end process contador;   
     
     
   fin_cuenta<=true when cuenta=asig_time else false;  
     
   end descripcion;
