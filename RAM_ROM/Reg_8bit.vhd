library ieee;
use ieee.std_logic_1164.all;

entity Reg_8bit is
    port(clk , ld: in std_logic;
	i : in std_logic_vector(7 downto 0);
    q : out std_logic_vector(7 downto 0));
end Reg_8bit;

architecture behav of Reg_8bit is
    begin
        process(clk)
        begin
            if (clk ' event AND clk = '1' AND ld = '1') then
					q <= i;
					
        end if;
    end process;
end architecture behav;