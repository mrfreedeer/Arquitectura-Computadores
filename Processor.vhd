----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	John Sebastián Luján Figueroa
-- 
-- Create Date:    	18:53:31 06/03/2018
-- Design Name: 	Processor File Design
-- Module Name:    	Processor - Behavioral 
-- Project Name: 	Segmented Processor

--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;


entity Processor is Port (
	reset : in  STD_LOGIC;
	clk : in  STD_LOGIC;
	RESULT : out  STD_LOGIC_VECTOR (31 downto 0));
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
	PCadderout: out STD_LOGIC_VECTOR(31 downto 0);
	PCout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component instructionMemory is
    Port (
	address : in  STD_LOGIC_VECTOR (31 downto 0);
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
	o7 : out  STD_LOGIC_VECTOR (5 downto 0);
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

component IFID is
    Port ( PCadderout : in  STD_LOGIC_VECTOR (31 downto 0);
	PCout : in  STD_LOGIC_VECTOR (31 downto 0);
	IMOUT : in  STD_LOGIC_VECTOR (31 downto 0);
	clk : in STD_LOGIC;
	rst : in STD_LOGIC;
	IFIDPCadderout : out  STD_LOGIC_VECTOR (31 downto 0);
	IFIDPCout : out  STD_LOGIC_VECTOR (31 downto 0);
	IFIDIMOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IDEX is
    Port (
	clk : in STD_LOGIC;
	rst : in STD_LOGIC;
	
	disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
	IFIDPCout : in  STD_LOGIC_VECTOR (31 downto 0);
	i : in  STD_LOGIC;
	disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
	IFIDPCadderout : in  STD_LOGIC_VECTOR (31 downto 0);
	PCSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
	RFSOURCE : in  STD_LOGIC_VECTOR (1 downto 0);
	wrEnMem : in  STD_LOGIC;
	RDENMEM : in  STD_LOGIC;
	ALUOP : in STD_LOGIC_VECTOR(5 downto 0);
	CRD : in  STD_LOGIC_VECTOR (31 downto 0);
	CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
	CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
	SIMM32 : in  STD_LOGIC_VECTOR (31 downto 0);
	   
	IDEXdisp22 : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXPCout : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXi : out  STD_LOGIC;
	IDEXdisp30 : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXPCadderout : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXPCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
	IDEXRFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
	IDEXALUOP : out STD_LOGIC_VECTOR(5 downto 0);
	IDEXwrEnMem : out  STD_LOGIC;
	IDEXrdEnMem : out  STD_LOGIC;
	IDEXCRD : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXCRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXCRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
	IDEXSIMM32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EX_MEM is Port (
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
end component;

component MEM_WB is Port (
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
end component;

signal RS1 : STD_LOGIC_VECTOR(5 downto 0);
signal RS2 : STD_LOGIC_VECTOR(5 downto 0);
signal Rd : STD_LOGIC_VECTOR(5 downto 0);
signal nRd : STD_LOGIC_VECTOR(5 downto 0);
signal o7 : STD_LOGIC_VECTOR(5 downto 0);
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
signal PCadderout : STD_LOGIC_VECTOR(31 downto 0);
signal PCout : STD_LOGIC_VECTOR(31 downto 0);

signal IFIDPCadderout : STD_LOGIC_VECTOR(31 downto 0);
signal IFIDPCout : STD_LOGIC_VECTOR(31 downto 0);
signal IFIDIMOUT : STD_LOGIC_VECTOR(31 downto 0);

signal IDEXdisp22 : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXPCout : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXi : STD_LOGIC;
signal IDEXdisp30 : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXPCadderout : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXPCSOURCE : STD_LOGIC_VECTOR(1 downto 0);
signal IDEXRFSOURCE : STD_LOGIC_VECTOR (1 downto 0);
signal IDEXwrEnMem : STD_LOGIC;
signal IDEXrdEnMem : STD_LOGIC;
signal IDEXCRD : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXCRS1 : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXCRS2 : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXSIMM32 : STD_LOGIC_VECTOR(31 downto 0);
signal IDEXALUOP : STD_LOGIC_VECTOR(5 downto 0);

signal EX_MEMpcplusdisp30 :  STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMpcplusdisp22 :  STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMPCadder :   STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMPCadderout: STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMRFSOURCE :   STD_LOGIC_VECTOR (1 downto 0);
signal EX_MEMwrEnMem :   STD_LOGIC;
signal EX_MEMrdEnMem :   STD_LOGIC;
signal EX_MEMALUOP :  STD_LOGIC_VECTOR(5 downto 0);
signal EX_MEMPCSOURCE :   STD_LOGIC_VECTOR (1 downto 0);
signal EX_MEMCRD :   STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMDWR :   STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMPC :   STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMPCout :   STD_LOGIC_VECTOR (31 downto 0);
signal EX_MEMIDEXPCadderout :   STD_LOGIC_VECTOR (31 downto 0);

signal MEM_WBRFSOURCE :   STD_LOGIC_VECTOR (1 downto 0);
signal MEM_WBDATATOMEM :   STD_LOGIC_VECTOR (31 downto 0);
signal MEM_WBDWR :  STD_LOGIC_VECTOR (31 downto 0);
signal MEM_WBPC :  STD_LOGIC_VECTOR (31 downto 0);
signal MEM_WBPCout :  STD_LOGIC_VECTOR (31 downto 0);
begin


inst_IP : IntegratedPC Port Map (
	rst => reset,
	clk => clk,
	PCin => nPCin,
	PCadderout => PCadderout,
	PCout => PCout
	);
	
	
inst_IM : instructionMemory Port Map(
	address => PCout,
	reset => reset,
	outInstruction => IMOUT
	);
inst_IFID: IFID Port Map(
	PCadderout => PCadderout,
	PCout => PCout,
	IMOUT => IMOUT,
	clk => clk,
	rst => reset,
	IFIDPCadderout => IFIDPCadderout,
	IFIDPCout => IFIDPCout,
	IFIDIMOUT => IFIDIMOUT);

i <= IFIDIMOUT(13);
SIMM13 <= IFIDIMOUT(12 downto 0);
OP <= IFIDIMOUT(31 downto 30);
OP3 <= IFIDIMOUT(24 downto 19);

inst_SEU_30 : SEU_30 Port Map(
	disp30 => IFIDIMOUT(29 downto 0),
	exto => disp30);
	
inst_SEU_22 : SEU_22 Port Map ( 
	disp22 => IFIDIMOUT(21 downto 0),
	exto => disp22);
	
inst_adder_1 : adder Port Map ( 
	A => IDEXPCout,
	B => IDEXdisp30,
	C => pcplusdisp30);

inst_adder_2 : adder Port Map ( 
	A => IDEXPCout,
	B => IDEXdisp22 ,
	C => pcplusdisp22);
	
inst_WM : Windows_Manager Port Map( 
	RS1 => IFIDIMOUT(18 downto 14),
	RS2 => IFIDIMOUT(4 downto 0),
	RD => IFIDIMOUT(29 downto 25),
	OP => OP,
	OP3 => OP3,
	CWP => CWP,
	nRS1 => RS1,
	nRS2 => RS2,
	nRD =>  nRd,
	o7 =>  o7,
	nCWP => nCWP);

inst_CU: CU   Port Map ( 
	icc => icc,
	OP => OP,
        	OP3 => OP3,
	cond => IFIDIMOUT(28 downto 25),
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
	DWR => DATATOREG,
	WE => WE, 
	reset => reset,
	CRS1 => CRS1,
	CRS2 => CRS2,
	CRD  => CRD);

		
inst_SEU_13 : SEU_13 Port Map( 
	imm13 => SIMM13,
	exto => SIMM32);
	
inst_IDEX : IDEX Port  Map(
	clk => clk,
	rst => reset,
	
	disp22 => disp22,
	IFIDPCout => IFIDPCout,
	i => i,
	disp30 => disp30,
	IFIDPCadderout => IFIDPCadderout,
	PCSOURCE => PCSOURCE,
	RFSOURCE => RFSOURCE,
	wrEnMem => wrEnMem,
	rdEnMem => rdEnMem,
	ALUOP => ALUOP,
	CRD => CRD,
	CRS1 => CRS1,
	CRS2 => CRS2,
	SIMM32 => SIMM32,
	
	IDEXdisp22 =>  IDEXdisp22 ,
	IDEXPCout => IDEXPCout,
	IDEXi => IDEXi,
	IDEXdisp30 => IDEXdisp30,
	IDEXPCadderout => IDEXPCadderout,
	IDEXPCSOURCE => IDEXPCSOURCE,
	IDEXRFSOURCE => IDEXRFSOURCE,
	IDEXALUOP => IDEXALUOP,
	IDEXwrEnMem => IDEXwrEnMem,
	IDEXrdEnMem => IDEXrdEnMem,
	IDEXCRD => IDEXCRD,
	IDEXCRS1 => IDEXCRS1,
	IDEXCRS2 => IDEXCRS2,
	IDEXSIMM32 => IDEXSIMM32);
	
	
inst_MUX2x1 : MUX2x1 Port Map ( 
	i => IDEXi,
	in0 => IDEXCRS2,
        	in1 => IDEXSIMM32,
	RMUX => RMUX);
	
inst_MUX2X1_6bit : MUX2x1_6bit Port Map(
	i => RFDEST,
	in0 => nRd, 
	in1 => o7,
	RMUX => Rd); 
	
inst_PSR_Modifier : PSR_Modifier Port Map( 
	CRS1 => IDEXCRS1,
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
	CRS1 => IDEXCRS1,
	RMUX => RMUX,
	ALUOP => ALUOP,
	C => Carry,
	DWR => DWR);
	
inst_EX_MEM: EX_MEM Port Map(
	clk => clk,
	rst => reset,
	
	pcplusdisp30 =>pcplusdisp30,
	pcplusdisp22 =>pcplusdisp22 ,
	IDEXPCadderout => IDEXPCadderout ,
	IDEXRFSOURCE => IDEXRFSOURCE ,
	IDEXwrEnMem => IDEXwrEnMem ,
	IDEXrdEnMem => IDEXrdEnMem ,
	IDEXALUOP => IDEXALUOP ,
	IDEXPCSOURCE => IDEXPCSOURCE ,
	IDEXCRD => IDEXCRD ,
	DWR => DWR ,
	IDEXPCout => IDEXPCout ,

	EX_MEMpcplusdisp30 =>EX_MEMpcplusdisp30 ,
	EX_MEMpcplusdisp22 =>EX_MEMpcplusdisp22 ,
	EX_MEMPCadderout => EX_MEMPCadderout ,
	EX_MEMRFSOURCE =>EX_MEMRFSOURCE ,
	EX_MEMwrEnMem =>EX_MEMwrEnMem ,
	EX_MEMrdEnMem =>EX_MEMrdEnMem ,
	EX_MEMALUOP =>EX_MEMALUOP  ,
	EX_MEMPCSOURCE =>EX_MEMPCSOURCE ,
	EX_MEMCRD =>EX_MEMCRD  ,
	EX_MEMDWR => EX_MEMDWR ,
	EX_MEMPCout => EX_MEMPCout );
	
inst_DM: DataMemory Port Map (
	dataIn => EX_MEMCRD,
	address => EX_MEMDWR,
	reset  => reset, 
	wrEnMem => EX_MEMwrEnMem,
	rdEnMem => EX_MEMrdEnMem,
	dataOut => DATATOMEM);


inst_MUX4x1 : MUX4x1 Port Map (
    i => EX_MEMPCSOURCE,
    in0 => EX_MEMpcplusdisp30,
    in1 => EX_MEMpcplusdisp22,
    in2 => EX_MEMIDEXPCadderout,
    in3 => EX_MEMDWR,
    RMUX => nPCin);

inst_MEM_WB: MEM_WB Port Map (
	clk => clk,
	rst => reset,
	
	EX_MEMRFSOURCE =>EX_MEMRFSOURCE ,
	DATATOMEM => DATATOMEM ,
	EX_MEMDWR => EX_MEMDWR ,
	EX_MEMPCout => EX_MEMPCout ,

	MEM_WBRFSOURCE => MEM_WBRFSOURCE ,
	MEM_WBDATATOMEM => MEM_WBDATATOMEM ,
	MEM_WBDWR => MEM_WBDWR ,
	MEM_WBPCout => MEM_WBPCout);

inst_MUXDM: MUX3x1 Port Map(
	i  => MEM_WBRFSOURCE ,
	in0 => MEM_WBDATATOMEM,
	in1 => MEM_WBDWR,
	in2 => MEM_WBPCout,
	RMUX => DATATOREG);
		
RESULT <= DATATOREG;

end Behavioral;