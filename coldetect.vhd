library IEEE;
use IEEE.std_logic_1164.all;
use work.tankparameters.all; 

entity coldetect is
port (

bullet_x : in integer; 
bullet_y : in integer; 
enemy_x: in integer;
enemy_y: in integer; 

collision : out std_logic
);
end entity; 

architecture behav of coldetect is 
component overlapdetect is 
port 
(
bullet_x_left, bullet_x_right, bullet_y_top, bullet_y_bottom, 
enemy_x_left, enemy_x_right, enemy_y_top, enemy_y_bottom: in integer; 
collision: out std_logic 
);
end component;

signal bullet_x_left, bullet_x_right, bullet_y_top, bullet_y_bottom: integer; 
signal enemy_x_left, enemy_x_right, enemy_y_top, enemy_y_bottom: integer;

begin 
 P1: process( bullet_x,bullet_y,enemy_x,enemy_y )

begin 
bullet_x_left <= bullet_x - (bullet_width/2);
bullet_x_right <= bullet_x + (bullet_width/2);
bullet_y_top <=bullet_y - (bullet_height/2); 
bullet_y_bottom <= bullet_y + (bullet_height/2); 

enemy_x_left <= enemy_x - (tank_width/2);
enemy_x_right <= enemy_x + (tank_width/2);
enemy_y_top <= enemy_y - (tank_height/2); 
enemy_y_bottom <= enemy_y + (tank_height/2); 
end process; 

d1: overlapdetect port map
(
bullet_x_left, bullet_x_right, bullet_y_top, bullet_y_bottom, 
enemy_x_left, enemy_x_right, enemy_y_top, enemy_y_bottom, 
collision 
);



end architecture; 





