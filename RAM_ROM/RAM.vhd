LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RAM IS
    PORT(
        clock, rw_enable, mem_enable : IN STD_LOGIC;
        address    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        data_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END RAM;

ARCHITECTURE behav OF RAM IS
        TYPE ram_type IS ARRAY(0 to 15) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
        SIGNAL ram: ram_type;
        SIGNAL temp_address: STD_LOGIC_VECTOR(3 DOWNTO 0);
        
    BEGIN
    PROCESS(clock) IS
        BEGIN
            IF (RISING_EDGE(clock) AND mem_enable = '1') THEN
                IF (rw_enable = '0') THEN
                    temp_address <= address;
                ELSIF (rw_enable = '1') THEN
                    ram(conv_integer(unsigned(address))) <= data_input;
                END IF;
            data_output <= ram(conv_integer(unsigned(temp_address)));
        END IF;
    END PROCESS;
END behav;