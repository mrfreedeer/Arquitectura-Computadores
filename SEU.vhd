----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers:	Juan Pablo Ospina Bustamante 
--	   	John Sebastián Luján Figueroa
-- 
-- Create Date:    16:13:07 04/10/2018 
-- Design Name: 	 SEU File Design
-- Module Name:    SEU - Behavioral 
-- Project Name: 	 First Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU is
    Port ( 	imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
		exto : out STD_LOGIC_VECTOR (31 downto 0));

end SEU;

architecture Behavioral of SEU is

begin
exto <= "1111111111111111111" & imm13 when imm13(12)='1' else
"0000000000000000000" & imm13 when imm13(12)='0';

end Behavioral;

