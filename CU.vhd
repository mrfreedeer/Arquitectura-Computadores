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
    PCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0)
	 WE : out STD_LOGIC);
    end CU;

architecture Behavioral of CU is

signal branchEn : STD_LOGIC := '0';
signal N : STD_LOGIC := icc(3);
signal Z : STD_LOGIC := icc(2);
signal V : STD_LOGIC := icc(1);
signal C : STD_LOGIC := icc(0);

begin

process(icc, OP, OP3, cond) begin
	case OP is
		when "10" =>
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
				when "111100" =>
					ALUOP <= "000000";
				when "111101" =>
					ALUOP <= "000000";
				when others =>
					ALUOP <= OP3;
			end case;
        when "00" => --Branch
            case cond is
                when "0000" => --BN
                    branchEn <= '0';
                when "0001" => --BE
                    branchEn <= Z;
                when "0010" => --BLE
                    branchEn <= Z or (N xor V);
                when "0011" => --BL
                    branchEn <= N xor V;
                when "0100" => --BLEU
                    branchEn <= (C or Z);
                when "0101" => --BCS
                    branchEn <= C;
                when "0110" => --BNEG
                    branchEn <= N;
                when "0111" => --BVS
                    branchEn <= V;
                when "1000" => --BA
                    branchEn <= '1';
                when "1001" => --BNE
                    branchEn <= not Z;
                when "1010" => --BG
                    branchEn <= not (Z or (N xor V));
                when "1011" => --BGE
                    branchEn <= not (N xor V);
                when "1100" => --BGU
                    branchEn <= not (C or Z);
                when "1101" => --BCC
                    branchEn <= not C;
                when "1110" => --BPOS
                    branchEn <= not N;
                when "1111" => --BVC
                    branchEn <= not V;
                when others =>
                    branchEn <= '0';
				end case;
		when others =>
            ALUOP <= "111111";
	end case;
end process;
PCSOURCE <= "01" when branchEn='1' else "10" when branchEn='0';
end Behavioral;
