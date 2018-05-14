library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU_13 is
    Port ( 	imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
		exto : out STD_LOGIC_VECTOR (31 downto 0));

end SEU_13;

architecture Behavioral of SEU_13 is

begin
exto <= "1111111111111111111" & imm13 when imm13(12)='1' else
"0000000000000000000" & imm13 when imm13(12)='0';

end Behavioral;

