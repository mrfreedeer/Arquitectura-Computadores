----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 		Juan Pablo Ospina Bustamante 
--	 					John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 		Tb_IntegratedPC File Design
-- Module Name:    	Tb_IntegratedPC - Behavioral 
-- Project Name: 		Second Processor

--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_IntegratedPC IS
END tb_IntegratedPC;
 
ARCHITECTURE behavior OF tb_IntegratedPC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IntegratedPC
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         PCout : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal PCout : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IntegratedPC PORT MAP (
          rst => rst,
          clk => clk,
          PCout => PCout
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
      wait for 100 ns;	
      rst <= '0';
		



      -- insert stimulus here 

      wait;
   end process;

END;
