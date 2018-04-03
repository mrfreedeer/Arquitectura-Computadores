
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
    Port ( PCAddr : in  STD_LOGIC_VECTOR(31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR(31 downto 0));
			  
end pc;

architecture pc_arq of pc is

begin
process (clk) is
begin
	 	if rst = '1' then
		PCout <= (others => '0'); 
		 elsif rising_edge(clk) then 
		 PCout <= PCAddr;
		  end if;

end process;

end pc_arq;

