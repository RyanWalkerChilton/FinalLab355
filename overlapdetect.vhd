library IEEE;
use IEEE.std_logic_1164.all;
use work.tankparameters.all;

entity overlapdetect is 
port 
(
bullet_x_left, bullet_x_right, bullet_y_top, bullet_y_bottom, 
enemy_x_left, enemy_x_right, enemy_y_top, enemy_y_bottom: in integer; 
collision: out std_logic 
);
end entity; 

architecture behav of overlapdetect is

signal overlap_left, overlap_right, overlap_top, overlap_bottom: std_logic; 
begin 

p1: process (bullet_x_left, bullet_x_right, bullet_y_top, bullet_y_bottom, 
enemy_x_left, enemy_x_right, enemy_y_top, enemy_y_bottom,
overlap_left, overlap_right, overlap_top, overlap_bottom)

begin 
overlap_left <= '0';
overlap_right <= '0';
overlap_top <= '0';
overlap_bottom <= '0';
collision <= '0';
-- X COORDINATE: check if bullet left is between enemy tank left and enemy tank right
if ( (bullet_x_left >= enemy_x_left) and (bullet_x_left<=enemy_x_right) ) then 
overlap_left <= '1';
end if;

-- X COORDINATE: check if bullet right is between enemy tank left and  enemy tank right 
if ( (bullet_x_right >= enemy_x_left) and (bullet_x_right<=enemy_x_right) ) then 
overlap_right <= '1';
end if;

-- Y COORDINATE: check if bullet top is between enemy tank top and enemy tank bottom 
if ( (bullet_y_top >= enemy_y_top) and (bullet_y_top<=enemy_y_bottom) ) then 
overlap_top <= '1';
end if;

-- Y COORDINATE: check if bullet bottom is between enemy tank top and enemy tank bottom 
if ( (bullet_y_bottom >= enemy_y_top) and (bullet_y_bottom<=enemy_y_bottom) ) then 
overlap_bottom <= '1';
end if;

-- check for collision
if (((overlap_left or overlap_right) and (overlap_top or overlap_bottom)) = '1') then
collision <= '1';
end if;

end process;
end architecture; 


