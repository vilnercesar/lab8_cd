LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity decode4 is
  port(
	I : in std_logic_vector(1 downto 0);
	en : in std_logic;
	Q : out std_logic_vector(3 downto 0)

);

end decode4;
architecture main of decode4 is

begin
	Q(0) <= en and not(I(1)) and not(I(0));
	Q(1) <= en and not(I(1)) and I(0);
	Q(2) <= en and I(1) and not(I(0));
	Q(3) <= en and I(1) and I(0); 

end main;