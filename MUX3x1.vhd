library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX3x1 is Port (
    i : in  STD_LOGIC_VECTOR (1 downto 0);
    in0 : in  STD_LOGIC_VECTOR (31 downto 0);
    in1 : in  STD_LOGIC_VECTOR (31 downto 0);
    in2 : in  STD_LOGIC_VECTOR (31 downto 0);
    RMUX : out  STD_LOGIC_VECTOR (31 downto 0)
); end MUX3x1;

architecture Behavioral of MUX3x1 is

begin
RMUX <= in0 when i= "00" else
        in1 when i= "01" else
        in2 when i= "10";

end Behavioral;

