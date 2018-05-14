library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU_30 is
    Port ( 	disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
		exto : out STD_LOGIC_VECTOR (31 downto 0));

end SEU_30;

architecture Behavioral of SEU_30 is

begin
exto <= "11" & disp30 when disp30(29)='1' else
"00" & disp30 when disp30(29)='0';

end Behavioral;

