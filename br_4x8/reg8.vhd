LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity reg8 is
    port(
        clk : in std_logic;
        ld  : in std_logic;
        D   : in std_logic_vector(7 downto 0);
        Q   : out std_logic_vector(7 downto 0)
    );
end reg8;

architecture main of reg8 is
    signal aux_outMUX  : std_logic_vector(7 downto 0);
    signal aux_outFLIP : std_logic_vector(7 downto 0);

    component flip_flop is
        port (
            D   : in  std_logic;     -- Entrada de dados
            CLK : in  std_logic;     -- Sinal de clock
            Q   : out std_logic      -- Saída
        );
    end component;

    component mux2x1 is
        Port (
            A     : in  std_logic;     -- Entrada A
            B     : in  std_logic;     -- Entrada B
            Sel   : in  std_logic;     -- Sinal de seleção
            Y     : out std_logic      -- Saída
        );
    end component;

begin
    -- Instância dos multiplexadores
    mux0 : mux2x1 port map(A => aux_outFLIP(0), B => D(0), Sel => ld, Y => aux_outMUX(0));
    mux1 : mux2x1 port map(A => aux_outFLIP(1), B => D(1), Sel => ld, Y => aux_outMUX(1));
    mux2 : mux2x1 port map(A => aux_outFLIP(2), B => D(2), Sel => ld, Y => aux_outMUX(2));
    mux3 : mux2x1 port map(A => aux_outFLIP(3), B => D(3), Sel => ld, Y => aux_outMUX(3));
    mux4 : mux2x1 port map(A => aux_outFLIP(4), B => D(4), Sel => ld, Y => aux_outMUX(4));
    mux5 : mux2x1 port map(A => aux_outFLIP(5), B => D(5), Sel => ld, Y => aux_outMUX(5));
    mux6 : mux2x1 port map(A => aux_outFLIP(6), B => D(6), Sel => ld, Y => aux_outMUX(6));
    mux7 : mux2x1 port map(A => aux_outFLIP(7), B => D(7), Sel => ld, Y => aux_outMUX(7));

    -- Instância dos flip-flops
    flip0 : flip_flop port map(D => aux_outMUX(0), CLK => clk, Q => aux_outFLIP(0));
    flip1 : flip_flop port map(D => aux_outMUX(1), CLK => clk, Q => aux_outFLIP(1));
    flip2 : flip_flop port map(D => aux_outMUX(2), CLK => clk, Q => aux_outFLIP(2));
    flip3 : flip_flop port map(D => aux_outMUX(3), CLK => clk, Q => aux_outFLIP(3));
    flip4 : flip_flop port map(D => aux_outMUX(4), CLK => clk, Q => aux_outFLIP(4));
    flip5 : flip_flop port map(D => aux_outMUX(5), CLK => clk, Q => aux_outFLIP(5));
    flip6 : flip_flop port map(D => aux_outMUX(6), CLK => clk, Q => aux_outFLIP(6));
    flip7 : flip_flop port map(D => aux_outMUX(7), CLK => clk, Q => aux_outFLIP(7));

    -- Atribuindo a saída final
    Q <= aux_outFLIP;

end main;
