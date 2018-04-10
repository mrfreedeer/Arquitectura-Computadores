library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           DWR : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process(CRS1, RMUX, ALUOP) begin
case ALUOP is
	when "000000" =>
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) + SIGNED(RMUX));
   when "000001" =>
		DWR <= CRS1 and RMUX;
	when "000100" =>
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) - SIGNED(RMUX));
	when "000010" =>
		DWR <= CRS1 or RMUX;
	when "000011" =>
		DWR <= CRS1 xor RMUX;
	when "000111" =>
		DWR <= CRS1 xnor RMUX;
	when "000101" =>
		DWR <= CRS1 and (not RMUX);
	when "000110" =>
		DWR <= CRS1 or (not RMUX);
	when others =>
		DWR <= (others => '0');
end case;
end process;

end Behavioral;