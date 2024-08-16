LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity flip_flop is
    Port (
        D   : in  std_logic;     -- Entrada de dados
        CLK : in  std_logic;     -- Sinal de clock
        Q   : out std_logic     -- Saída
    );
end flip_flop;

architecture Behavioral of flip_flop is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;                    
	end if;

    end process;

end Behavioral;
