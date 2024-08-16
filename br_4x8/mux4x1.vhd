library ieee;
use ieee.std_logic_1164.all;

package bus_array_pkg is
        type bus_array is array(3 downto 0) of std_logic_vector(7 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.bus_array_pkg.all;

entity mux4x1 is
	port(
		A		: bus_array;
		S		: in std_logic_vector(1 downto 0);
		Z		: out std_logic_vector(7 downto 0));
end mux4x1;

architecture main of mux4x1 is
	type tmp_array is array(0 to 3) of std_logic_vector(7 downto 0);
begin
	
	Z <= A(conv_integer(unsigned(S)));

end architecture main;