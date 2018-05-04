
----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	20:21:28 05/03/2018
-- Design Name: 		Tb_PSR File Design
-- Module Name:    	Tb_PSR - Behavioral 
-- Project Name: 		First Processor

--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_PSR IS
END Tb_PSR;
 
ARCHITECTURE behavior OF Tb_PSR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         icc : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         C : OUT  std_logic;
         CWP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal icc : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal C : std_logic;
   signal CWP : std_logic;

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          icc => icc,
          nCWP => nCWP,
          rst => rst,
          clk => clk,
          C => C,
          CWP => CWP
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
     rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '0';
		icc <= "0101";
		nCWP <= '1';
		
		wait for clk_period;
		
		icc <= "0011";
		nCWP <= '0';

      wait;
   end process;

END;
