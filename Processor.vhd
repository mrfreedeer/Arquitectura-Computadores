----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	17:18:31 04/10/2018
-- Design Name: 	Processor File Design
-- Module Name:    	Processor - Behavioral 
-- Project Name: 	First Processor

--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;


entity Processor is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           ALU_RESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end Processor;

architecture Behavioral of Processor is

component ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
			  C : in  STD_LOGIC;
           DWR : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component CU is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
	   ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component MUX is
    Port ( i : in  STD_LOGIC;
	   CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           IMM : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SEU is
    Port ( imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
	   exto : out STD_LOGIC_VECTOR (31 downto 0));

end component;

component IntegratedPC is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component instructionMemory is
    Port ( --clk : in STD_LOGIC;
	   address : in  STD_LOGIC_VECTOR (5 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PSR_Modifier is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RMUX : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           icc : out STD_LOGIC_VECTOR (3 downto 0)); -- NZVC
end component;

component PSR is
    Port (  icc : in STD_LOGIC_VECTOR (3 downto 0); -- NZVC
            nCWP : in STD_LOGIC;
            C : out STD_LOGIC;
            CWP : out STD_LOGIC -- Current Window Pointer
            );
end component;

component Windows_Manager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC;
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0);
			  nCWP : out STD_LOGIC);
end component;


signal RS1 : STD_LOGIC_VECTOR(5 downto 0);
signal RS2 : STD_LOGIC_VECTOR(5 downto 0);
signal Rd : STD_LOGIC_VECTOR(5 downto 0);
signal DWR : STD_LOGIC_VECTOR(31 downto 0);
signal OP : STD_LOGIC_VECTOR(1 downto 0);
signal OP3 : STD_LOGIC_VECTOR(5 downto 0);
signal i : STD_LOGIC;
signal CRS1 : STD_LOGIC_VECTOR(31 downto 0);
signal CRS2 : STD_LOGIC_VECTOR(31 downto 0);
signal SIMM13 : STD_LOGIC_VECTOR(12 downto 0);
signal ALUOP : STD_LOGIC_VECTOR(5 downto 0);
signal SIMM32 : STD_LOGIC_VECTOR(31 downto 0);
signal IMIN : STD_LOGIC_VECTOR(5 downto 0);
signal IMOUT : STD_LOGIC_VECTOR(31 downto 0);
signal RMUX : STD_LOGIC_VECTOR(31 downto 0);
signal CWP : STD_LOGIC;
signal nCWP: STD_LOGIC;
signal icc : STD_LOGIC_VECTOR(3 downto 0);
signal Carry : STD_LOGIC;


begin
inst_IP : IntegratedPC Port Map (
			rst => reset,
			clk => clk,
			PCout => IMIN
			);
inst_IM : instructionMemory Port Map(
			address => IMIN,
         		reset => reset,
         		outInstruction => IMOUT
			);

i <= IMOUT(13);
SIMM13 <= IMOUT(12 downto 0);

inst_WM : Windows_Manager Port Map( 
				RS1 => IMOUT(18 downto 14),
				RS2 => IMOUT(4 downto 0),
				RD => IMOUT(29 downto 25),
				OP => IMOUT(31 downto 30),
				OP3 => IMOUT(24 downto 19),
				CWP => CWP,
				nRS1 => RS1,
				nRS2 => RS2,
				nRD =>  Rd,
				nCWP => nCWP);

inst_CU: CU   Port Map ( 
			OP => OP,
        		OP3 => OP3,
		   	ALUOP => ALUOP);
				
inst_RF: RegisterFile  Port Map (
			rs1 => RS1,
         		rs2 => RS2,
         		rd => RD,
         		DWR => DWR,
         		reset => reset,
         		CRS1 => CRS1,
         		CRS2 => CRS2);

					
inst_SEU : SEU Port Map( 
			imm13 => SIMM13,
			exto => SIMM32);
			
inst_MUX : MUX Port Map ( 
			i => i,
			CRS2 => CRS2,
         IMM => SIMM32,
         RMUX => RMUX);
			
inst_PSR_Modifier : PSR_Modifier Port Map( 
				CRS1 => CRS1,
				RMUX => RMUX, 
				ALUOP => ALUOP, 
				DWR => DWR,
				icc => icc); 
				
inst_PSR:  PSR Port Map(
				icc => icc,
            nCWP => nCWP,
            C =>  Carry,
            CWP => CWP);
					
inst_ALU: ALU Port Map(
					CRS1 => CRS1,
         		RMUX => RMUX,
					ALUOP => ALUOP,
					C => Carry,
         		DWR => DWR);
					
ALU_RESULT <= DWR;

end Behavioral;

