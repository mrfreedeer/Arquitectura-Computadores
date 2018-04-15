----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	pc File Design
-- Module Name:    	pc - Behavioral 
-- Project Name: 	First Processor
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pc is
    Port ( PCAddr : in  STD_LOGIC_VECTOR(31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR(31 downto 0));
			  
end pc;

architecture pc_arq of pc is

begin
process (clk) is
begin
	 	if rst = '1' then
			PCout <= (others => '0'); 
		elsif rising_edge(clk) then 
			PCout <= PCAddr;
		end if;

end process;

end pc_arq;

