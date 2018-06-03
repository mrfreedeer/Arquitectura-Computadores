----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:16:31 05/14/2018
-- Design Name: 		SEU_22 File Design
-- Module Name:    	SEU_22 - Behavioral 
-- Project Name: 		Segmented Processor

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU_22 is
    Port ( 	disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
		exto : out STD_LOGIC_VECTOR (31 downto 0));

end SEU_22;


architecture Behavioral of SEU_22 is

begin
exto <= "1111111111" & disp22 when disp22(21)='1' else
"0000000000" & disp22 when disp22(21)='0';

end Behavioral;

