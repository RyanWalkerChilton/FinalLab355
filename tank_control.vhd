library IEEE;
use IEEE.std_logic_1164.all;
use WORK.tankparameters.all;

entity tank_control is
port(
		clk			:in std_logic;
		reset			:in std_logic;
		start			:in std_logic;
		direction		:in std_logic;
		speed_one_code		:in std_logic_vector(23 downto 0);
		speed_two_code		:in std_logic_vector(23 downto 0);
		speed_three_code	:in std_logic_vector(23 downto 0);
		keyboard_input		:in std_logic_vector(23 downto 0);
		tank_position		:out integer;
		tank_y			:out integer
);
end entity tank_control;


architecture fsm of tank_control is
signal state : std_logic_vector(1 downto 0);
signal next_state : std_logic_vector(1 downto 0);
signal speed : integer;
signal xdirection : std_logic := '0';
signal next_xdirection : std_logic;
signal tank_current_pos : integer := 300;
signal tank_next_pos : integer;


begin
--Process to Update tank's speed!
tankspeed: process (state)
begin
case state is
	when "00" => 
		speed <= 1;
	when "01" =>
		speed <= 2;
	when "10" =>
		speed <= 3;
	when others =>
		speed <= 1;
end case;
end process tankspeed;

update: process (clk)
begin
--Reset Process!
if (reset = '0') then
	state <= "00";
	tank_position <= 300;
	tank_current_pos <= 300;
	xdirection <= '0';
	if (direction = '0') then
	tank_y <= 0 + (tank_height/2);
	else
	tank_y <= 480 - (tank_height/2);
	end if;
elsif (rising_edge(clk)) then
	--Update tank's upcoming position, checking for boundary violations
	if (xdirection = '0') then
		tank_next_pos <= tank_current_pos + speed;
		if (tank_next_pos + (tank_width/2)>= 640) then
			tank_next_pos <= 570;
			next_xdirection <= '1';
		end if; 
	elsif (xdirection = '1') then
		tank_next_pos <= tank_current_pos - speed;
		if (tank_next_pos - (tank_width/2)<= 0) then
			tank_next_pos <= 30;
			next_xdirection <= '0';
		end if; 
	end if;
	--Update tank's next speed state.
	if  (keyboard_input=speed_one_code) then
		next_state <= "00";
	elsif  (keyboard_input=speed_two_code) then
		next_state <= "01";
	elsif  (keyboard_input=speed_three_code) then
		next_state <= "10";
	end if;


	--Apply the updates!
	state <= next_state;
	xdirection <= next_xdirection;
	tank_current_pos <= tank_next_pos;
	tank_position <= tank_current_pos;
end if;
end process update;
end architecture fsm;

