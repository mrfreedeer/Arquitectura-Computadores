----------------------------------------------------------------------------------
-- Company: iMacLinDows 
-- Engineers: 	Juan Pablo Ospina Bustamante 
--	 	John Sebastián Luján Figueroa
-- 
-- Create Date:    	19:30:30 06/02/2018
-- Design Name: 		Tb_IFID File Design
-- Module Name:    	Tb_IFID - Behavioral 
-- Project Name: 	Segmented Processor

--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned vIFIDes
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_IFID IS
END Tb_IFID;
 
ARCHITECTURE behavior OF Tb_IFID IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFID
    PORT(
         PCadderout : IN  std_logic_vector(31 downto 0);
         PCout : IN  std_logic_vector(31 downto 0);
         IMOUT : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         IFIDPCadderout : OUT  std_logic_vector(31 downto 0);
         IFIDPCout : OUT  std_logic_vector(31 downto 0);
         IFIDIMOUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PCadderout : std_logic_vector(31 downto 0) := (others => '0');
   signal PCout : std_logic_vector(31 downto 0) := (others => '0');
   signal IMOUT : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal IFIDPCadderout : std_logic_vector(31 downto 0);
   signal IFIDPCout : std_logic_vector(31 downto 0);
   signal IFIDIMOUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFID PORT MAP (
          PCadderout => PCadderout,
          PCout => PCout,
          IMOUT => IMOUT,
          clk => clk,
          IFIDPCadderout => IFIDPCadderout,
          IFIDPCout => IFIDPCout,
          IFIDIMOUT => IFIDIMOUT
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		PCadderout <= X"00000001";
		PCout <= X"00000000";
		IMOUT <= X"000D0F0A";
		wait for clk_period;
		
		PCadderout <= X"00000002";
		PCout <= X"00000001";
		IMOUT <= X"000DAFAA";
		wait for clk_period;
		
		PCadderout <= X"00000003";
		PCout <= X"00000002";
		IMOUT <= X"0FFD0F0A";
		wait for clk_period;


      -- insert stimulus here 

      wait;
   end process;

END;
