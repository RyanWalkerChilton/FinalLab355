entity tank_control is
port(
clk : in std_logic;
speedinput : in std_logic_vector(1 downto 0);
);
end entity tank_control;


architecture tank_control is
signal state : std_logic_vector(1 downto 0);
signal speed : integer;
signal direction : std_logic := '0';
begin
state <= speedinput;
tankspeed: process (state)
case state is
	when "00" => 
		speed <= 1;
	when "01" =>
		speed <= 2;
	when "10" =>
		speed <= 3;
end case;
end process tankspeed;

update: process (clk)
	if (direction = '0')
	


end tank_control

