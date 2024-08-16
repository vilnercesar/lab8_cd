library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity controlador is
port(
	data: in std_logic_vector(7 downto 0);
	clk, rst, rd: in std_logic;
	
	state: out std_logic_vector(2 downto 0);
	data_out: out std_logic_vector(7 downto 0);
	ram_addr, rom_addr: out std_logic_vector(3 downto 0);
	oaddr: out integer range 0 to 15;
	ram_en, rom_en, ram_rw: out std_logic
);
end controlador;

architecture main of controlador is

component Reg_8bit is
    port(clk , ld: in std_logic;
			i : in std_logic_vector(7 downto 0);
			q : out std_logic_vector(7 downto 0));
end component;

component incrementa is
    port(clk , ld: in std_logic;
		q : out integer range 15 downto 0);
end component;

	type statetype is
		(ini, rd_rom, wt, inc, wr_ram, wt2);
	signal currentstate, nextstate: statetype;
	signal st: std_logic_vector(2 downto 0);
	signal s_data: std_logic_vector(7 downto 0);
	signal reg_data_ld, addr_inc: std_logic;
	signal addr: integer range 0 to 15;
	
begin
	 regdata: Reg_8bit port map(clk => clk, ld => reg_data_ld, i => data, q => s_data);
	 regaddr: incrementa port map(clk => clk, ld => addr_inc, q => addr);
	 
	 statereg: process(clk, rst)
		begin
			if (rst='1') then -- estado inicial
				currentstate <= ini;
			elsif (clk='1' and clk ' event) then
				currentstate <= nextstate;
			end if;
	 end process;
	 
	 comblogic: process (currentstate)
		begin
			case currentstate is
			when ini =>
				addr_inc <= '0';
				st <= "000";
				rom_en <= '0';
				ram_en <= '0';
				ram_rw <= '0';
				nextstate <= rd_rom;
			when rd_rom =>
				rom_en <= '1';
				reg_data_ld <= '1';
				addr_inc <= '0';
				st <= "001";
				ram_en <= '0';
				ram_rw <= '0';
				nextstate <= wt;
			when wt =>
				reg_data_ld <= '1';
				addr_inc <= '0';
				st <= "010";
				rom_en <= '0';
				ram_en <= '0';
				ram_rw <= '0';
				nextstate <= wr_ram;
			when wr_ram =>
				reg_data_ld <= '0';
				addr_inc <= '0';
				st <= "011";
				rom_en <= '0';
				ram_en <= '1';
				ram_rw <= not rd;
				nextstate <= wt2;
			when wt2 =>
				reg_data_ld <= '0';
				addr_inc <= '0';
				st <= "100";
				rom_en <= '0';
				ram_en <= '1';
				ram_rw <= not rd;
				nextstate <= inc;
			when inc =>
				reg_data_ld <= '0';
				addr_inc <= '1';
				rom_en <= '0';
				ram_en <= '0';
				ram_rw <= '0';
				st <= "101";
				nextstate <= rd_rom;
		end case;
	 end process;
	 ram_addr <= NOT std_logic_vector(to_unsigned(addr, 4));
	 rom_addr <= std_logic_vector(to_unsigned(addr, 4));
	 oaddr <= addr;
	 data_out <= s_data;
	 state <= st;
end architecture;