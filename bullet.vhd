library IEEE;
use IEEE.std_logic_1164.all;
use WORK.tankparameters.all;

entity bullet is			 
	port
	(
		clk					:in std_logic;
		reset					:in std_logic;
		start					:in std_logic;
		direction			:in std_logic;
		trigger_code		:in std_logic_vector(23 downto 0);
		keyboard_input		:in std_logic_vector(23 downto 0);
		tank_position		:in integer;
		collision			:in std_logic;
		x_position			:out integer;
		y_position			:buffer integer
	 );
end entity bullet;


architecture fsm of bullet is

signal state					:std_logic_vector (1 downto 0):="00";
signal next_state				:std_logic_vector (1 downto 0);

begin

clocked_process: process (reset, clk)
begin
	if (reset='0') then
		state <="00";
	elsif (rising_edge(clk)) then
		state <= next_state;
	end if;
end process clocked_process;


bullet_process: process (state,start,collision)
begin
case (state) is
	when "00" =>						--initial state
		x_position<=1000;
		y_position<=1000;
		if (start='1') then
			next_state <= "01";
		else
			next_state <= "00";
		end if;
		
	when "01" =>						--enable to shoot
		if (start='0') then
			next_state <= "00";
		elsif (keyboard_input=trigger_code) then
			x_position<=tank_position;		
			if (direction='0') then
				y_position<=tank_height+((bullet_height-1)/2);
			else 
				y_position<=480-tank_height-((bullet_height-1)/2);
			end if;
			next_state<="10";
		else 
			next_state<="00";
		end if;
		
	when "10" =>						--bullet travelling state
		if (start='0' or collision='1') then
			next_state <= "00";
		elsif (direction='0' and y_position>480) or (direction='1' and y_position<0) then
			next_state <="00";
		elsif (direction='0') then
			y_position<=y_position+bullet_speed;
			next_state <="11";
		else
			y_position<=y_position-bullet_speed;
			next_state <="11";
		end if;
		
	when "11" =>						--pause state
		if (start='0' or collision='1') then
			next_state <= "00";
		else
			next_state <= "10";
		end if;
			
	when others =>
end case;
		
end process;



end architecture fsm;