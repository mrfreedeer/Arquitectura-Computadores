----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: Juan Pablo Ospina Bustamante 
--				  John Sebasti�n Luj�n Figueroa
-- 
-- Create Date:    16:13:07 04/10/2018 
-- Design Name: 	 Register File Design
-- Module Name:    RegisterFile - Behavioral 
-- Project Name: 	 First Processor

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array(0 to 31) of std_logic_vector (31 downto 0);

signal RF: ram_type := (others => x"00000000");
begin
	process(reset, rs1, rs2, rd, DWR)
		begin
		if (reset = '1') then
			RF <= (others => X"00000000");
			CRS1 <=  (others => '0');
			CRS2 <=  (others => '0');		
		else
			CRS1 <= RF(conv_integer(rs1));
			CRS2 <= RF(conv_integer(rs2));
			if (rd /= "00000") then
				RF(conv_integer(rd)) <= DWR;
			end if;
		end if;
		
	end process;

end Behavioral;

