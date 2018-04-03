
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Tb_pc IS
END Tb_pc;
 
ARCHITECTURE behavior OF Tb_pc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pc
    PORT(
         PCAddr : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         clk : IN  std_logic;
         PCout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PCAddr : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal PCout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc PORT MAP (
          PCAddr => PCAddr,
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
      PCAddr <= (others => '1');
		rst <= '0';		
		wait for 40 ns;
		rst <= '1';
		wait for 40 ns;
		
		PCAddr <= "10101010101010101010101010101010";
		rst <= '0';
		wait for 40 ns;
		
		rst <= '1';
		
		

      wait;
   end process;

END;
