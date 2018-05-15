----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--		John Sebastián Luján Figueroa
-- 
-- Create Date:   	16:13:07 04/10/2018 
-- Design Name: 		MUX File Design
-- Module Name:    	MUX - Behavioral 
-- Project Name: 		Second Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( 	i : in  STD_LOGIC;
		CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           	IMM : in  STD_LOGIC_VECTOR (31 downto 0);
           	RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
RMUX <= CRS2 when i='0' else
			IMM when i='1';

end Behavioral;

