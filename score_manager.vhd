library IEEE;
use IEEE.std_logic_1164.all;
use WORK.tankparameters.all;

entity score_manager is
port(		clk			:in std_logic;
		reset			:in std_logic;
		start			:in std_logic;
		collision		:in std_logic;
		score			:out integer;
		win			:out std_logic
);
end entity score_manager;

architecture fsm of score_manager is
signal next_score : integer :=0;
signal next_win : std_logic :='0';
begin
update : process (clk, reset)
begin 
if (reset = '1') then
	score <= 0;
	win <= '0';
elsif (rising_edge(clk)) then
	score <= next_score;
	win <= next_win;
end if;
end process update;

manager : process (collision)
begin
if (rising_edge(collision)) then
	next_score <= next_score + 1;
	if (next_score >= 3) then
		next_win <= '1';
	else
		next_win <= '0';
	end if;
end if;
end process manager;
end architecture fsm;