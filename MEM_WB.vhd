----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	      		John Sebastián Luján Figueroa
-- 
-- Create Date:    	18:08:12 06/03/2018
-- Design Name: 		MEM-WB File Design
-- Module Name:      MEM-WB - Behavioral 
-- Project Name: 		Segmented Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB is Port (
			clk : in STD_LOGIC;
			rst : in STD_LOGIC;
            
			EX_MEMRFSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
            DATATOMEM : in  STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMDWR : in  STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMPCout : in  STD_LOGIC_VECTOR (31 downto 0);

			MEM_WBRFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
            MEM_WBDATATOMEM : out  STD_LOGIC_VECTOR (31 downto 0);
			MEM_WBDWR : out STD_LOGIC_VECTOR (31 downto 0);
			MEM_WBPCout : out STD_LOGIC_VECTOR (31 downto 0));
end MEM_WB;

architecture Behavioral of MEM_WB is

begin
process (clk, rst) is
begin
		if rst = '1' then
			MEM_WBRFSOURCE <= (others =>'0');
			MEM_WBDATATOMEM <= (others =>'0');
			MEM_WBDWR <= (others =>'0');
			MEM_WBPCout <= (others =>'0');

		elsif rising_edge(clk) then 
			MEM_WBRFSOURCE <= EX_MEMRFSOURCE;
			MEM_WBDATATOMEM <= DATATOMEM;
			MEM_WBDWR <= EX_MEMDWR;
			MEM_WBPCout <= EX_MEMPCout;
		end if;

end process;

end Behavioral;