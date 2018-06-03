----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:13:31 05/14/2018
-- Design Name: 		MUX2x1_6bit File Design
-- Module Name:    	MUX2x1_6bit - Behavioral 
-- Project Name: 		Segmented Processor

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x1_6bit is Port (
    i : in  STD_LOGIC;
    in0 : in  STD_LOGIC_VECTOR (5 downto 0);
    in1 : in  STD_LOGIC_VECTOR (5 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (5 downto 0));
 end MUX2x1_6bit;

architecture Behavioral of MUX2x1_6bit is

begin
RMUX <= in0 when i='0' else
        in1 when i='1';

end Behavioral;


