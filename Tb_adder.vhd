----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	16:13:07 04/10/2018 
-- Design Name: 	Tb_adder File Design
-- Module Name:    	Tb_adder - Behavioral 
-- Project Name: 	First Processor
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_adder IS
END Tb_adder;
 
ARCHITECTURE behavior OF Tb_adder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         C : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal C : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          A => A,
          B => B,
          C => C
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      A <=  X"00000009";
		B <=  X"0000000D";
		
      wait for 100 ns;	
		
		A <=  X"00000309";
		B <=  X"0000001D";
		wait for 100 ns;
		
		A <=  X"00000D09";
		B <=  X"00000C0D";
		wait for 100 ns;	
		
		A <=  X"0000A000";
		B <=  X"0000000D";
		wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
