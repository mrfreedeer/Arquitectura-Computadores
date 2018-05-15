-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--					John Sebastián Luján Figueroa
-- 
-- Create Date: 		17:06:01 04/10/2018
-- Design Name: 		ALU File Design
-- Module Name:    	ALU - Behavioral 
-- Project Name: 		Third Processor

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           C : in  STD_LOGIC;
           DWR : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

signal carry : std_logic_vector(31 downto 0) := (others => '0'); --32 bits para evitar problemas en operaciones

begin

carry(0) <= C;

process(CRS1, RMUX, ALUOP) begin
case ALUOP is
	when "000000" | "010000"=> -- ADD or ADDcc
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) + SIGNED(RMUX));
    when "001000" | "011000"=> -- ADDX or ADDXcc
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) + SIGNED(RMUX) + SIGNED(carry));
    when "000001" | "010001" => --AND or ANDcc
		DWR <= CRS1 and RMUX;
	when "000100" | "010100"=> --SUB or SUBcc
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) - SIGNED(RMUX));
    when "001100" | "011100"=> --SUBX or SUBXcc
		DWR <= STD_LOGIC_VECTOR(SIGNED(CRS1) - SIGNED(RMUX) - SIGNED(carry));
	when "000010" | "010010" => --OR or ORcc
		DWR <= CRS1 or RMUX;
	when "000011" | "010011"=> --XOR or XORcc
		DWR <= CRS1 xor RMUX;
	when "000111" | "010111"=> --XNOR or XNORcc
		DWR <= CRS1 xnor RMUX;
	when "000101" | "010101"=> --ANDN or ANDNcc
		DWR <= CRS1 and (not RMUX);
	when "000110" | "010110" => --ORN or ORNcc
		DWR <= CRS1 or (not RMUX);
	when others =>
		DWR <= (others => '0');
        
end case;
end process;

end Behavioral;
