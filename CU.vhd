----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: Juan Pablo Ospina Bustamante 
--				  John Sebastián Luján Figueroa
-- 
-- Create Date:    17:06:01 04/10/2018
-- Design Name: 	 CU File Design
-- Module Name:    CU - Behavioral 
-- Project Name: 	 First Processor

--

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
		   ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin

process(OP, OP3) begin
	case OP is
		when "10" =>
			case OP3 is
				when "000000" =>
					ALUOP <= OP3;
			   when "000001" =>
					ALUOP <= OP3;
				when "000100" =>
					ALUOP <= OP3;
				when "000010" =>
					ALUOP <= OP3;
				when "000011" =>
					ALUOP <= OP3;
				when "000111" =>
					ALUOP <= OP3;
				when "000101" =>
					ALUOP <= OP3;
				when "000110" =>
					ALUOP <= OP3;
				when others =>
					ALUOP <= OP3;
		end case;
		when others =>
		ALUOP <= "111111";
	end case;
end process;

end Behavioral;