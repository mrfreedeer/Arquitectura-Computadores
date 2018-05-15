----------------------------------------------------------------------------------

-- Company: iMacLinDows 
-- Engineers: 		Juan Pablo Ospina Bustamante 
--	 					John Sebastián Luján Figueroa
-- 
-- Create Date:    	15:58:29 04/28/2018
-- Design Name: 		Windows Manager Testbench File Design
-- Module Name:    	Tb_Windows_Manager - Behavioral 
-- Project Name: 		Second Processor

--

----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_Windows_Manager IS
END Tb_Windows_Manager;
 
ARCHITECTURE behavior OF Tb_Windows_Manager IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Windows_Manager
    PORT(
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         CWP : IN  std_logic;
         nRS1 : OUT  std_logic_vector(5 downto 0);
         nRS2 : OUT  std_logic_vector(5 downto 0);
         nRD : OUT  std_logic_vector(5 downto 0);
         nCWP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RS1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RD : std_logic_vector(4 downto 0) := (others => '0');
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');
   signal CWP : std_logic := '0';

 	--Outputs
   signal nRS1 : std_logic_vector(5 downto 0);
   signal nRS2 : std_logic_vector(5 downto 0);
   signal nRD : std_logic_vector(5 downto 0);
   signal nCWP : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Windows_Manager PORT MAP (
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          OP => OP,
          OP3 => OP3,
          CWP => CWP,
          nRS1 => nRS1,
          nRS2 => nRS2,
          nRD => nRD,
          nCWP => nCWP
        );

   -- Stimulus process
   stim_proc: process
   begin		
      CWP <= '0';
		RS1 <= "00000";
		RS2 <= "01000";
		RD <= "10000";
		OP <= "10";
		OP3 <= "000000";
      wait for 40 ns;
		
		CWP <= '0';
		RS1 <= "11100";
		RS2 <= "01101";
		RD <= "10101";
		OP <= "10";
		OP3 <= "111101";
		
		wait for 40 ns;
		
		CWP <= '0';
		RS1 <= "11100";
		RS2 <= "01101";
		RD <= "10101";
		OP <= "10";
		OP3 <= "111100";
				
		wait for 40 ns;
		
		CWP <= '1';
		RS1 <= "00000";
		RS2 <= "01000";
		RD <= "10000";
		OP <= "10";
		OP3 <= "000000";
		
		wait for 40 ns;
		CWP <= '1';
		RS1 <= "11100";
		RS2 <= "01101";
		RD <= "10101";
		OP <= "10";
		OP3 <= "111101";
		
		wait for 40 ns;
		
		CWP <= '1';
		RS1 <= "11100";
		RS2 <= "01101";
		RD <= "10101";
		OP <= "10";
		OP3 <= "111100";
		
		wait for 40 ns;
			

      -- insert stimulus here 

      wait;
   end process;

END;
