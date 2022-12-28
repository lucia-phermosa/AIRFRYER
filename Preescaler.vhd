library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk_1Hz is
    Port (
        CLK: in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        CLK_1hz : out STD_LOGIC
    );
end clk_1Hz;
 
architecture Behavioral of clk_1Hz is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 49999999 := 0;
begin
    divisor_frecuencia: process (reset, CLK) begin
        if (reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(CLK) then
            if (contador = 49999999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador+1;
            end if;
        end if;
    end process;
     
    CLK_1hz <= temporal;
    
end Behavioral;
