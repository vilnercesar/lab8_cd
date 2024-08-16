library ieee;
use ieee.std_logic_1164.all;

entity incrementa is
    port(clk , ld: in std_logic;
		q : out integer range 0 to 15);
end incrementa;

architecture behav of incrementa is
    begin
        process(clk)
		  variable a: integer range 0 to 15;
        begin
            if (clk ' event AND clk = '1' AND ld = '1') then
					a := a+1;
					q <= a;
        end if;
    end process;
end architecture behav;