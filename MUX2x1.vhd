----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:09:31 05/14/2018
-- Design Name: 		MUX2x1 File Design
-- Module Name:    	MUX2x1 - Behavioral 
-- Project Name: 		Segmented Processor

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x1 is Port (
    i : in  STD_LOGIC;
    in0 : in  STD_LOGIC_VECTOR (31 downto 0);
    in1 : in  STD_LOGIC_VECTOR (31 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2x1;

architecture Behavioral of MUX2x1 is

begin
RMUX <= in0 when i='0' else
        in1 when i='1';

end Behavioral;

