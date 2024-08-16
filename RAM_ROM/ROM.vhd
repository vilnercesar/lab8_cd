LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ROM IS
	PORT(
	    clock      : IN STD_LOGIC; 
	    rom_enable : IN STD_LOGIC;
	    address    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	    data_output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ROM;

ARCHITECTURE behav OF ROM IS
    TYPE rom_type IS ARRAY(0 to 15) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
		CONSTANT mem: rom_type :=(
			0  => "00000000",
			1  => "00000001",
			2  => "00000010",
			3  => "00000011",
			4  => "00000100",
			5  => "00000101",
			6  => "00000110",
			7  => "00000111",
			8  => "00001000",
			9  => "00001001",
			10 => "00001010",
			11 => "00001011",
			12 => "00001100",
			13 => "00001101",
			14 => "00001110",
			15 => "00001111",
			others => "00000000"
		);

	BEGIN
	PROCESS(clock) IS
		BEGIN
			IF (RISING_EDGE(clock) AND rom_enable = '1') THEN
				data_output <= mem(conv_integer(unsigned(address)));
			END IF;
	END PROCESS;
END behav;