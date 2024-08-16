LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.bus_array_pkg.all;

entity regfile is
   port(
	clk : in std_logic;
	W : in std_logic_vector(7 downto 0);
	W_addr: in std_logic_vector(1 downto 0);
	W_en : in std_logic;
	
	R_data: out std_logic_vector(7 downto 0);
	R_addr: in std_logic_vector(1 downto 0)
	

	);

end regfile;

architecture main of regfile is

signal aux_decode: std_logic_vector(3 downto 0);
signal out_regs: bus_array;



component decode4 is
 port(
	I : in std_logic_vector(1 downto 0);
	en : in std_logic;
	Q : out std_logic_vector(3 downto 0)

);
end component;

component reg8 is
 port(
        clk : in std_logic;
        ld  : in std_logic;
        D   : in std_logic_vector(7 downto 0);
        Q   : out std_logic_vector(7 downto 0)
    );
end component;

component mux4x1 is
port(
		A		: bus_array;
		S		: in std_logic_vector(1 downto 0);
		Z		: out std_logic_vector(7 downto 0)
	);
end component;

component mux2x18bit is 
	Port (
        A     : in  std_logic_vector(7 downto 0);     -- Entrada A
        B     : in  std_logic_vector(7 downto 0);     -- Entrada B
        Sel   : in  std_logic;     -- Sinal de seleção
        Y     : out std_logic_vector(7 downto 0)      -- Saída
    );
end component;
	 
begin
      deco0 : decode4 port map(I=> W_addr, en => W_en, Q => aux_decode);
      reg0 : reg8 port map( clk => clk, ld=> aux_decode(0), D => W, Q => out_regs(0));
      reg1 : reg8 port map( clk => clk, ld=> aux_decode(1), D => W, Q => out_regs(1));
      reg2 : reg8 port map( clk => clk, ld=> aux_decode(2), D => W, Q => out_regs(2));
      reg3 : reg8 port map( clk => clk, ld=> aux_decode(3), D => W, Q => out_regs(3));


      muxRead : mux4x1 port map( A => out_regs , S => R_addr, Z => R_data);
		
		




end main;
