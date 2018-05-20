----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	17:18:31 04/10/2018
-- Design Name: 		Processor File Design
-- Module Name:    	Processor - Behavioral 
-- Project Name: 		Third Processor

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
    Port (   icc : in  STD_LOGIC_VECTOR (3 downto 0); --NZVC
    OP : in  STD_LOGIC_VECTOR (1 downto 0);
    OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
    cond : in  STD_LOGIC_VECTOR (3 downto 0);
    --Out
    RFDEST : out  STD_LOGIC;
    RFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
    wrEnMem : out  STD_LOGIC;
    rdEnMem : out  STD_LOGIC;
    ALUOP : out  STD_LOGIC_VECTOR (5 downto 0);
    PCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
	 WE : out STD_LOGIC);
end component;

component adder is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           C : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

component MUX is
    Port ( 	i : in  STD_LOGIC;
	 CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
	 IMM : in  STD_LOGIC_VECTOR (31 downto 0);
	 RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX2x1_6bit is Port (
    i : in  STD_LOGIC;
    in0 : in  STD_LOGIC_VECTOR (5 downto 0);
    in1 : in  STD_LOGIC_VECTOR (5 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component MUX2x1 is Port (
    i : in  STD_LOGIC;
    in0 : in  STD_LOGIC_VECTOR (31 downto 0);
    in1 : in  STD_LOGIC_VECTOR (31 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (31 downto 0)); 
end component;

component MUX3x1 is Port (
    i : in  STD_LOGIC_VECTOR (1 downto 0);
    in0 : in  STD_LOGIC_VECTOR (31 downto 0);
    in1 : in  STD_LOGIC_VECTOR (31 downto 0);
    in2 : in  STD_LOGIC_VECTOR (31 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX4x1 is Port (
    i : in  STD_LOGIC_VECTOR (1 downto 0);
    in0 : in  STD_LOGIC_VECTOR (31 downto 0);
    in1 : in  STD_LOGIC_VECTOR (31 downto 0);
    in2 : in  STD_LOGIC_VECTOR (31 downto 0);
    in3 : in  STD_LOGIC_VECTOR (31 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
			  WE : in STD_LOGIC;
           reset : in  STD_LOGIC;
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  CRD  : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SEU_13 is
    Port ( imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
	   exto : out STD_LOGIC_VECTOR (31 downto 0));

end component;

component IntegratedPC is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  PCin : in STD_LOGIC_VECTOR(31 downto 0);
			  PC32out: out STD_LOGIC_VECTOR(31 downto 0);
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
				rst : in STD_LOGIC;
				clk : in STD_LOGIC;
            C : out STD_LOGIC;
				iccO : out STD_LOGIC_VECTOR(3 downto 0);
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

component DataMemory is Port (
    dataIn : in  STD_LOGIC_VECTOR (31 downto 0);
    address : in  STD_LOGIC_VECTOR (31 downto 0);
    reset : in  STD_LOGIC;
    wrEnMem : in  STD_LOGIC;
    rdEnMem : in  STD_LOGIC;
    dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SEU_30 is
    Port ( 	disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
				exto : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component SEU_22 is
    Port ( 	disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
				exto : out STD_LOGIC_VECTOR (31 downto 0));
end component;



signal RS1 : STD_LOGIC_VECTOR(5 downto 0);
signal RS2 : STD_LOGIC_VECTOR(5 downto 0);
signal Rd : STD_LOGIC_VECTOR(5 downto 0);
signal nRd : STD_LOGIC_VECTOR(5 downto 0);
signal DWR : STD_LOGIC_VECTOR(31 downto 0);
signal OP : STD_LOGIC_VECTOR(1 downto 0);
signal OP3 : STD_LOGIC_VECTOR(5 downto 0);
signal i : STD_LOGIC;
signal CRS1 : STD_LOGIC_VECTOR(31 downto 0);
signal CRS2 : STD_LOGIC_VECTOR(31 downto 0);
signal CRD : STD_LOGIC_VECTOR(31 downto 0);
signal SIMM13 : STD_LOGIC_VECTOR(12 downto 0);
signal ALUOP : STD_LOGIC_VECTOR(5 downto 0);
signal SIMM32 : STD_LOGIC_VECTOR(31 downto 0);
signal IMIN : STD_LOGIC_VECTOR(5 downto 0);
signal IMOUT : STD_LOGIC_VECTOR(31 downto 0);
signal RMUX : STD_LOGIC_VECTOR(31 downto 0);
signal CWP : STD_LOGIC;
signal nCWP: STD_LOGIC;
signal iccin : STD_LOGIC_VECTOR(3 downto 0);
signal icc : STD_LOGIC_VECTOR (3 downto 0);
signal Carry : STD_LOGIC;
signal DATATOMEM : STD_LOGIC_VECTOR(31 downto 0);
signal DATATOREG : STD_LOGIC_VECTOR(31 downto 0);
signal wrEnMem : STD_LOGIC;
signal rdEnMem : STD_LOGIC;
signal RFSOURCE : STD_LOGIC_VECTOR(1 downto 0);
signal RFDEST : STD_LOGIC;
signal PCSOURCE : STD_LOGIC_VECTOR (1 downto 0);
signal WE : STD_LOGIC;
signal disp30 : STD_LOGIC_VECTOR (31 downto 0);
signal disp22 : STD_LOGIC_VECTOR (31 downto 0); 
signal pcplusdisp30 : STD_LOGIC_VECTOR (31 downto 0);
signal pcplusdisp22 : STD_LOGIC_VECTOR (31 downto 0);
signal nPCin : STD_LOGIC_VECTOR(31 downto 0);
signal PCout : STD_LOGIC_VECTOR(31 downto 0);

begin

inst_IP : IntegratedPC Port Map (
			rst => reset,
			clk => clk,
			PCin => nPCin,
			PC32out => PCout,
			PCout => IMIN
			);
inst_IM : instructionMemory Port Map(
			address => IMIN,
         reset => reset,
         outInstruction => IMOUT
			);

i <= IMOUT(13);
SIMM13 <= IMOUT(12 downto 0);
OP <= IMOUT(31 downto 30);
OP3 <= IMOUT(24 downto 19);

inst_SEU_30 : SEU_30 Port Map(
			disp30 => IMOUT(29 downto 0),
			exto => disp30);
			
inst_SEU_22 : SEU_22 Port Map ( 
			disp22 => IMOUT(21 downto 0),
			exto => disp22);
			
inst_adder_1 : adder Port Map ( 
			A => PCout,
         B => disp30,
         C => pcplusdisp30);

inst_adder_2 : adder Port Map ( 
			A => PCout,
         B => disp22,
         C => pcplusdisp22);
			
inst_WM : Windows_Manager Port Map( 
			RS1 => IMOUT(18 downto 14),
			RS2 => IMOUT(4 downto 0),
			RD => IMOUT(29 downto 25),
			OP => OP,
			OP3 => OP3,
			CWP => CWP,
			nRS1 => RS1,
			nRS2 => RS2,
			nRD =>  nRd,
			nCWP => nCWP);

inst_CU: CU   Port Map ( 
			icc => icc,
			OP => OP,
        	OP3 => OP3,
			cond => IMOUT(28 downto 25),
			RFDEST => RFDEST,
			RFSOURCE => RFSOURCE,
			wrEnMem => wrEnMem,
			rdEnMem => rdEnMem,
		   ALUOP => ALUOP,
			PCSOURCE => PCSOURCE,
			WE => WE);
				
inst_RF: RegisterFile  Port Map (
			rs1 => RS1,
         rs2 => RS2,
         rd => RD,
         DWR => DWR,
			WE => WE, 
         reset => reset,
         CRS1 => CRS1,
         CRS2 => CRS2,
			CRD  => CRD);

					
inst_SEU_13 : SEU_13 Port Map( 
			imm13 => SIMM13,
			exto => SIMM32);
			
inst_MUX2x1 : MUX2x1 Port Map ( 
			i => i,
			in0 => CRS2,
        	in1 => SIMM32,
         RMUX => RMUX);
			
inst_MUX2X1_6bit : MUX2x1_6bit Port Map(
			i => RFDEST,
			in0 => nRd, 
			in1 => "001111",
			RMUX => Rd); 
			
inst_PSR_Modifier : PSR_Modifier Port Map( 
			CRS1 => CRS1,
			RMUX => RMUX, 
			ALUOP => ALUOP, 
			DWR => DWR,
			icc => iccin); 



inst_PSR:  PSR Port Map(
			icc => iccin,
			nCWP => nCWP,
			rst => reset,
			clk => clk,
         C =>  Carry,
			iccO => icc,
         CWP => CWP);
					
inst_ALU: ALU Port Map(
			CRS1 => CRS1,
         RMUX => RMUX,
			ALUOP => ALUOP,
			C => Carry,
         DWR => DWR);
inst_DM: DataMemory Port Map (
		 dataIn => CRD,
		 address => DWR,
		 reset  => reset, 
		 wrEnMem => wrEnMem,
		 rdEnMem => rdEnMem,
		 dataOut => DATATOMEM);

inst_MUXDM: MUX3x1 Port Map(
			 i  => RFSOURCE ,
			 in0 => DWR,
			 in1 => DATATOMEM,
			 in2 => IMOUT,
			 RMUX => DATATOREG);
inst_MUX4x1 : MUX4x1 Port Map (
    i => PCSOURCE,
    in0 => pcplusdisp30,
    in1 => pcplusdisp22,
    in2 => PCout,
    in3 => DWR,
    RMUX => nPCin);

					
ALU_RESULT <= DATATOREG;

end Behavioral;

