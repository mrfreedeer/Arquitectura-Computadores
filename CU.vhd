----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 				John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:11:43 05/14/2018
-- Design Name: 		CU File Design
-- Module Name:    	CU - Behavioral 
-- Project Name: 		Segmented Processor

----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is Port (
    --In
    icc : in  STD_LOGIC_VECTOR (3 downto 0); --NZVC
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
    WE : out  STD_LOGIC);
	 end CU;

architecture Behavioral of CU is

signal N : STD_LOGIC;
signal Z : STD_LOGIC;
signal V : STD_LOGIC ;
signal C : STD_LOGIC ;
signal branchbait : STD_LOGIC;
begin
N <= icc(3);
Z <= icc(2);
V <= icc(1);
C <= icc(0);
process(icc, OP, OP3, cond)
variable branchEn : std_logic;
 begin


	case OP is
		when "10" =>
            RFDEST <= '0';
            RFSOURCE <= "01";
            wrEnMem <= '0';
            rdEnMem <= '0';
            PCSOURCE <= "10";
            WE <= '1';
			case OP3 is
				when "000000" =>
					ALUOP <= OP3;
			  	when "000001" =>
					ALUOP <= OP3;
				when "000010" =>
					ALUOP <= OP3;
				when "000011" =>
					ALUOP <= OP3;
				when "000100" =>
					ALUOP <= OP3;
				when "000101" =>
					ALUOP <= OP3;
				when "000110" =>
					ALUOP <= OP3;
				when "000111" =>
					ALUOP <= OP3;
            when "111000" => --Jump and link
               RFSOURCE <= "10";
               ALUOP <= "000000";
               PCSOURCE <= "11";
				when "111100" =>
					ALUOP <= "000000";
				when "111101" =>
					ALUOP <= "000000";
				when others =>
					ALUOP <= OP3;
			end case;
        when "00" =>
			case OP3 is
				when "100000" =>	--NOP
					PCSOURCE <= "10";
					ALUOP <= "000010";
				when others =>		--Branch
					case cond is
						when "0000" => --BN
							branchEn := '0';
						when "0001" => --BE
							branchEn := Z;
						when "0010" => --BLE
							branchEn := Z or (N xor V);
						when "0011" => --BL
							branchEn := N xor V;
						when "0100" => --BLEU
							branchEn := (C or Z);
						when "0101" => --BCS
							branchEn := C;
						when "0110" => --BNEG
							branchEn := N;
						when "0111" => --BVS
							branchEn := V;
						when "1000" => --BA
							branchEn := '1';
						when "1001" => --BNE
							branchEn := not Z;
						when "1010" => --BG
							branchEn := not (Z or (N xor V));
						when "1011" => --BGE
							branchEn := not (N xor V);
						when "1100" => --BGU
							branchEn := not (C or Z);
						when "1101" => --BCC
							branchEn := not C;
						when "1110" => --BPOS
							branchEn := not N;
						when "1111" => --BVC
							branchEn := not V;
						when others =>
							branchEn := '0';
					end case;
					case branchEn is
						when '1' =>
						PCSOURCE <= "01";
						when '0' => 
						PCSOURCE <= "10";
						when others => null;
					end case;
					RFDEST <= '0';
					RFSOURCE <= "00";
					wrEnMem <= '0';
					rdEnMem <= '0';
					ALUOP <= "000000";
					WE <= '0';
			end case;
		when "11" => --Load/Store
            case OP3 is
                when "000000" => --LD
                    RFDEST <= '0';
                    RFSOURCE <= "00";
                    wrEnMem <= '0';
                    rdEnMem <= '1';
                    ALUOP <= "000000";
                    PCSOURCE <= "10";
                    WE <= '1';
                when "000100" => --ST
                    RFDEST <= '0';
                    RFSOURCE <= "00";
                    wrEnMem <= '1';
                    rdEnMem <= '0';
                    ALUOP <= "000000";
                    PCSOURCE <= "10";
                    WE <= '0';
                when others =>
                    RFDEST <= '0';
                    RFSOURCE <= "00";
                    wrEnMem <= '0';
                    rdEnMem <= '0';
                    ALUOP <= "000000";
                    PCSOURCE <= "10";
                    WE <= '0';
            end case;
        when "01" => --Call
            RFDEST <= '1';
            RFSOURCE <= "10";
            wrEnMem <= '0';
            rdEnMem <= '0';
            ALUOP <= "000000";
            PCSOURCE <= "00";
            WE <= '1';
        when others =>
            RFDEST <= '0';
            RFSOURCE <= "00";
            wrEnMem <= '0';
            rdEnMem <= '0';
            ALUOP <= "000000";
            PCSOURCE <= "10";
            WE <= '0';
	end case;

	branchbait <= branchEn;
end process;

end Behavioral;
