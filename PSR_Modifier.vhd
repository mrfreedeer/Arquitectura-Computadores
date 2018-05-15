-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--					John Sebastián Luján Figueroa
-- 
-- Create Date: 		17:06:01 04/10/2018
-- Design Name: 		PSR_Modifier File Design
-- Module Name:   	PSR_Modifier - Behavioral 
-- Project Name: 		Second Processor

--

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR_Modifier is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           icc : out STD_LOGIC_VECTOR (3 downto 0)); -- NZVC
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin

process(CRS1, RMUX, ALUOP, DWR) begin
case ALUOP is
	when "010001" | "010101" | "010010" | "010110" | "010011" | "010111"=> -- ANDcc or ANDNcc or ORcc or ORNcc or XORcc or XNORcc
		icc(3) <= DWR(31);
        if (DWR = x"00000000") then icc(2)<='1';
        else icc(2)<='0';
        end if;
        icc(1) <= '0';
        icc(0) <= '0';
    when "010000" | "011000" => -- ADDcc or ADDXcc
		icc(3) <= DWR(31);
        if (DWR = x"00000000") then icc(2)<='1';
        else icc(2)<='0';
        end if;
        icc(1) <= (CRS1(31) and RMUX(31) and (not DWR(31))) or ((not CRS1(31)) and (not RMUX(31)) and DWR(31));
        icc(0) <= (CRS1(31) and RMUX(31)) or ((not DWR(31)) and (CRS1(31) or RMUX(31)));
    when "010100" | "011100" => -- SUBcc or SUBXcc
		icc(3) <= DWR(31);
        if (DWR = x"00000000") then icc(2)<='1';
        else icc(2)<='0';
        end if;
        icc(1) <= (CRS1(31) and (not RMUX(31)) and (not DWR(31))) or ((not CRS1(31)) and RMUX(31) and DWR(31));
        icc(0) <= ((not CRS1(31)) and RMUX(31)) or (DWR(31) and ((not CRS1(31)) or RMUX(31)));
	when others =>
		icc <= (others => '0');
        
end case;
end process;

end Behavioral;
