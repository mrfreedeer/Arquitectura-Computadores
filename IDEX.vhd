----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	      		John Sebastián Luján Figueroa
-- 
-- Create Date:    	20:04:12 06/02/2018
-- Design Name: 		IDEX File Design
-- Module Name:      IDEX - Behavioral 
-- Project Name: 		Segmented Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IDEX is
    Port ( disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           IFIDPCout : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           IFIDPCadderout : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
           RFSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : in  STD_LOGIC;
           RDENMEM : in  STD_LOGIC;
           CRD : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SIMM32 : in  STD_LOGIC_VECTOR (31 downto 0);
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
           IDEXdisp22 : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXPCout : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXi : out  STD_LOGIC;
           IDEXdisp30 : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXPCadderout : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXPCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           IDEXRFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           IDEXwrEnMem : out  STD_LOGIC;
           IDEXrdEnMem : out  STD_LOGIC;
           IDEXCRD : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXCRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           IDEXCRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  IDEXSIMM32 : out  STD_LOGIC_VECTOR (31 downto 0));
end IDEX;

architecture Behavioral of IDEX is

begin
process (clk, disp22, IFIDPCout, i, disp30, IFIDPCadderout, PCSOURCE,
			RFSOURCE, WRENMEM, RDENMEM, CRD, CRS1, CRS2, SIMM32) is
begin
		if rst = '1' then
			IDEXPCadderout <= (others =>'0');
			IDEXCRD <= (others =>'0');
			IDEXCRS1 <= (others =>'0');
			IDEXCRS2 <= (others =>'0');
			IDEXPCout <= (others =>'0');
			IDEXdisp22 <= (others => '0');
			IDEXdisp30 <= (others => '0');
			IDEXPCSOURCE <= (others => '0');
		elsif rising_edge(clk) then 
			IDEXdisp22 <= disp22;
         IDEXPCout <= IFIDPCout;
         IDEXi <= i;
         IDEXdisp30 <= disp30;
         IDEXPCadderout <= IFIDPCadderout;
         IDEXPCSOURCE <= PCSOURCE;
         IDEXRFSOURCE <= RFSOURCE;
         IDEXWRENMEM <= WRENMEM;
         IDEXRDENMEM <= RDENMEM;
         IDEXCRD <= CRD;
         IDEXCRS1 <= CRS1;
         IDEXCRS2 <= CRS2;
			IDEXSIMM32 <= SIMM32;
		end if;

end process;

end Behavioral;