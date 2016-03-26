--	LEGASPI, ALELI S.
--	2013-06797
--	CMSC132 T-2L
--	Buzzer Problem : Lecture Programming Assignment


-- Test Bench for Buzzer Problem
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Test Bench has no ports
entity buzzer_tb is
end entity buzzer_tb;


architecture buzzer_tb of buzzer_tb is
	-- initialize signals to connect to UUT (Unit Under Test)
	signal in1,out1, in2,out2, in3,out3 ,alarm : std_logic;
	
	-- connect to main VHDL file
	component buzzer is 
		port( in1,out1, in2,out2 ,in3,out3 : in std_logic;	 alarm: out std_logic);
	end component buzzer;

	begin
		-- make connections to the UUT
		-- map variables or signals declared to ports of the entity
		uut:component buzzer port map(in1,out1, in2,out2, in3,out3 ,alarm);

		-- check test cases
		process
		
			-- initialize some variables
			variable error_count: integer := 0;
			variable test_in: unsigned(5 downto 0);	--6 bits input 
			variable expected: std_logic; --expected alarm 
			
			begin
			
			test_in :=B"000000";
			
			for count in 0 to 63 loop
				in1 <= test_in(5);
				out1 <= test_in(4);
				in2 <= test_in(3);
				out2 <= test_in(2);
				in3 <= test_in(1);
				out3 <= test_in(0);
				
				wait for 10 ns;
				
				--generate expected result
				expected:=(in1 and (not out1) and in2 and (not out2) and in3 and (not out3))
					or (in1 and out1 and (not in2) and (not out2) and (not in3) and (not out3))
					or (in1 and (not in2) and out2 and (not in3) and (not out3))
					or (in1 and (not in2) and (not in3) and out3)
					or (out1 and in2 and (not out2) and (not in3) and (not out3))
					or (out1 and (not out2) and in3 and (not out3))
					or (in2 and out2 and (not in3) and (not out3))
					or (in2 and (not in3) and out3)
					or (out2 and in3 and (not out3))
					or (in3 and out3);
				
				--check if expected is as same as the generate result
				assert(expected=alarm)
					report "yeaaaa!";
					
				if(expected/=alarm) then
					error_count:=error_count+1;
				end if;
				
				test_in:=test_in+1;	

			end loop;

			-- Summary of Test Bench
				report "Done with test. There were "& integer'image(error_count) & " errors.";
				wait; -- wait forever. This will finish the simulation

		end process;


end architecture buzzer_tb;
