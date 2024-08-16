library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity controle IS
    port(
        clk, rst, s_rd: in STD_LOGIC;
		  RAM_rw, RAM_enO, ROM_enO: out STD_LOGIC;
		  state: out STD_LOGIC_VECTOR(2 DOWNTO 0);
        addr_RAM, addr_ROM: out STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_RAM, out_ROM: out STD_LOGIC_VECTOR(7 DOWNTO 0);
		  addr: out integer range 15 downto 0
    );
end controle;

architecture behav of controle is
    component RAM is
        PORT(
            clock, rw_enable, mem_enable : IN STD_LOGIC;
            address    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            data_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    component ROM is
	    PORT(
	        clock      : IN STD_LOGIC; 
	        rom_enable : IN STD_LOGIC;
	        address    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	        data_output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	    );
    end component;
	 
	component controlador is
		port(
			data: in std_logic_vector(7 downto 0);
			clk, rst, rd: in std_logic;
	
			state: out std_logic_vector(2 downto 0);
			data_out: out std_logic_vector(7 downto 0);
			ram_addr, rom_addr: out std_logic_vector(3 downto 0);
			oaddr: out integer range 0 to 15;
			ram_en, rom_en, ram_rw: out std_logic
		);
	end component;
    
   signal rw, RAM_en, ROM_en: std_logic;
   signal dataROM, dataRAM  : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal addr_RAMs: STD_LOGIC_VECTOR(3 DOWNTO 0);
   signal addr_ROMs: STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
	 cont: controlador port map(data => dataROM, clk => not clk, rst => rst, rd => s_rd, state => state, data_out => dataRAM,
	 ram_addr => addr_RAMs, rom_addr => addr_ROMs, oaddr => addr, ram_en => RAM_en, rom_en => ROM_en, ram_rw => rw);
	 perm: ROM port map(clock => clk, rom_enable => ROM_en, address => addr_ROMs, data_output => dataROM);
    dat: RAM port map(clock => clk, rw_enable => rw, mem_enable => RAM_en, address => addr_RAMs,
                      data_input => dataRAM, data_output => out_RAM);
							 
	 out_ROM <= dataROM;
    addr_RAM <= addr_RAMs;
	 addr_ROM <= addr_ROMs;
	 RAM_rw <= rw;
	 RAM_enO <= RAM_en;
	 ROM_enO <= ROM_en;
end architecture behav;