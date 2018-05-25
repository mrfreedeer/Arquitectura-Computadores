----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	      		John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 		IntegratedPC File Design
-- Module Name:      IntegratedPC - Behavioral 
-- Project Name: 		Third Processor

--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IntegratedPC is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  PCin : in STD_LOGIC_VECTOR(31 downto 0);
			  PCadderout: out STD_LOGIC_VECTOR(31 downto 0);
           PCout : out  STD_LOGIC_VECTOR (31 downto 0));
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
PCout <= rpc;
inst_adder: adder PORT MAP(
				A => X"00000001",
				B => rnpc,
				C => radder
				);
inst_npc: pc PORT MAP(
				PCAddr => PCin,
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
PCadderout <= radder;

end Behavioral;

