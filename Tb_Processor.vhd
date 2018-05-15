----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 		Juan Pablo Ospina Bustamante 
--	 					John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:04:44 04/12/2018
-- Design Name: 		Tb_IntegratedPC File Design
-- Module Name:    	Tb_IntegratedPC - Behavioral 
-- Project Name: 		Second Processor

--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_Processor IS
END Tb_Processor;
 
ARCHITECTURE behavior OF Tb_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         ALU_RESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal ALU_RESULT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          reset => reset,
          clk => clk,
          ALU_RESULT => ALU_RESULT
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
      reset <= '1';
      wait for 40 ns;	
      reset <= '0';
      wait for clk_period * 96;
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
