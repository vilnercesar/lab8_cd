LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux2x18bit is
    Port (
        A     : in  std_logic_vector(7 downto 0);     -- Entrada A
        B     : in  std_logic_vector(7 downto 0);     -- Entrada B
        Sel   : in  std_logic;     -- Sinal de seleção
        Y     : out std_logic_vector(7 downto 0)      -- Saída
    );
end mux2x1;

architecture Behavioral of mux2x1 is
begin
    process(A, B, Sel)
    begin
        if Sel = '0' then
            Y <= A;  -- Se Sel é 0, a saída é a entrada A
        else
            Y <= B;  -- Se Sel é 1, a saída é a entrada B
        end if;
    end process;
end Behavioral;
