----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:19:23 06/02/2018 
-- Design Name: 		IFID File Design
-- Module Name:    	IFID - Behavioral 
-- Project Name: 		Segmented Processor

--

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFID is
    Port ( PCadderout : in  STD_LOGIC_VECTOR (31 downto 0);
           PCout : in  STD_LOGIC_VECTOR (31 downto 0);
           IMOUT : in  STD_LOGIC_VECTOR (31 downto 0);
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
           IFIDPCadderout : out  STD_LOGIC_VECTOR (31 downto 0);
           IFIDPCout : out  STD_LOGIC_VECTOR (31 downto 0);
           IFIDIMOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end IFID;

architecture Behavioral of IFID is

begin
process (clk,PCadderout, PCout, IMOUT) is
begin
		if rst = '1' then
			IFIDPCout <= X"00000000"; 
			IFIDPCadderout <= X"00000000"; 
			IFIDIMOUT <= (others=>'0');
		elsif rising_edge(clk) then 
			IFIDPCadderout <= PCadderout;
         IFIDPCout <= PCout;
         IFIDIMOUT <= IMOUT;
		end if;

end process;


end Behavioral;

