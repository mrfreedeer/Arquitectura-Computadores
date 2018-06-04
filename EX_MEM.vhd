----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	      		John Sebastián Luján Figueroa
-- 
-- Create Date:    	15:37:12 06/03/2018
-- Design Name: 		EX-MEM File Design
-- Module Name:      EX-MEM - Behavioral 
-- Project Name: 		Segmented Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_MEM is Port (
			clk : in STD_LOGIC;
			rst : in STD_LOGIC;
            
			pcplusdisp30 : in STD_LOGIC_VECTOR (31 downto 0);
			pcplusdisp22 : in STD_LOGIC_VECTOR (31 downto 0);
			IDEXPCadderout : in  STD_LOGIC_VECTOR (31 downto 0);
			IDEXRFSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
			IDEXwrEnMem : in  STD_LOGIC;
			IDEXrdEnMem : in  STD_LOGIC;
			IDEXALUOP : in STD_LOGIC_VECTOR(5 downto 0);
			IDEXPCSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
			IDEXCRD : in  STD_LOGIC_VECTOR (31 downto 0);
			DWR : in  STD_LOGIC_VECTOR (31 downto 0);
			IDEXPCout : in  STD_LOGIC_VECTOR (31 downto 0);

			EX_MEMpcplusdisp30 : out STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMpcplusdisp22 : out STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMPCadderout : out  STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMRFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
			EX_MEMwrEnMem : out  STD_LOGIC;
			EX_MEMrdEnMem : out  STD_LOGIC;
			EX_MEMALUOP : out STD_LOGIC_VECTOR(5 downto 0);
			EX_MEMPCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
			EX_MEMCRD : out  STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMDWR : out  STD_LOGIC_VECTOR (31 downto 0);
			EX_MEMPCout : out  STD_LOGIC_VECTOR (31 downto 0));
end EX_MEM;

architecture Behavioral of EX_MEM is

begin
process (clk, rst) is
begin
		if rst = '1' then
			EX_MEMpcplusdisp30 <= (others =>'0');
			EX_MEMpcplusdisp22 <= (others =>'0');
			EX_MEMPCadderout <= (others =>'0');
			EX_MEMRFSOURCE <= (others =>'0');
			EX_MEMwrEnMem <= (others =>'0');
			EX_MEMrdEnMem <= (others => '0');
			EX_MEMALUOP <= (others => '0');
			EX_MEMPCSOURCE <= (others => '0');
			EX_EX_MEMCRD <= (others => '0');
			EX_EX_MEMDWR  <= (others => '0');
			EX_MEMPCout  <= (others => '0');
		elsif rising_edge(clk) then 
			EX_MEMpcplusdisp30 <= pcplusdisp30;
			EX_MEMpcplusdisp22 <= pcplusdisp22;
			EX_MEMPCadderout <= IDEXPCadderout;
			EX_MEMRFSOURCE <= IDEXRFSOURCE;
			EX_MEMwrEnMem <= IDEXwrEnMem;
			EX_MEMrdEnMem <= IDEXrdEnMem;
			EX_MEMALUOP <= IDEXALUOP;
			EX_MEMPCSOURCE <= IDEXPCSOURCE;
			EX_EX_MEMCRD <= IDEXCRD;
			EX_EX_MEMDWR  <= DWR;
			EX_MEMPCout  <= IDEXPCout;
		end if;

end process;

end Behavioral;