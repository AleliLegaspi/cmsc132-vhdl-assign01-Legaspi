--	LEGASPI, ALELI S.
--	2013-06797
--	CMSC132 T-2L
--	Buzzer Problem : Lecture Programming Assignment

library IEEE; use IEEE.std_logic_1164.all;
--------------------------------------------
entity buzzer is
	port( in1,out1, in2,out2 ,in3,out3 : in std_logic;	 alarm: out std_logic);
end buzzer;
architecture buzzer of buzzer is
begin
	alarm <= (in1 and (not out1) and in2 and (not out2) and in3 and (not out3))
		or (in1 and out1 and (not in2) and (not out2) and (not in3) and (not out3))
		or (in1 and (not in2) and out2 and (not in3) and (not out3))
		or (in1 and (not in2) and (not in3) and out3)
		or (out1 and in2 and (not out2) and (not in3) and (not out3))
		or (out1 and (not out2) and in3 and (not out3))
		or (in2 and out2 and (not in3) and (not out3))
		or (in2 and (not in3) and out3)
		or (out2 and in3 and (not out3))
		or (in3 and out3);
end architecture buzzer;
