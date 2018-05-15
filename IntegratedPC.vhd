----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: Juan Pablo Ospina Bustamante 
--	    		  John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 		IntegratedPC File Design
-- Module Name:      IntegratedPC - Behavioral 
-- Project Name: 		Second Processor

--
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

entity IntegratedPC is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR (5 downto 0));
end IntegratedPC;

architecture Behavioral of IntegratedPC is
component adder is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           C : out  STD_LOGIC_VECTOR(31 downto 0));
end component;


component pc is
    Port ( PCAddr : in  STD_LOGIC_VECTOR(31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR(31 downto 0));
			  
end component;
signal radder: std_logic_vector (31 downto 0);
signal rpc :  std_logic_vector (31 downto 0);
signal rnpc :  std_logic_vector (31 downto 0);

begin
PCout <= rpc(5 downto 0);

inst_adder: adder PORT MAP(
				A => X"00000001",
				B => rnpc,
				C => radder
				);

inst_npc: pc PORT MAP(
				PCAddr => radder,
				rst => rst,
				clk => clk,
				PCout => rnpc
			);
inst_pc: pc PORT MAP(
				PCAddr => rnpc,
				rst => rst,
				clk => clk,
				PCout => rpc
			);


end Behavioral;

