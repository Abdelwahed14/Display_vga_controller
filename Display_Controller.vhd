library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Display_Controller is
	port( CLK_12MHz : in std_logic;
		  RESET : in std_logic;
		  hsync, vsync : out std_logic;
		  red, green, blue : out std_logic_vector(3 downto 0));
		  
end entity Display_Controller;

architecture arch of Display_Controller is
	signal  counter_x: integer range 0 to 799;
	signal  counter_y: integer range 0 to 524;
	
begin
	Proc : process(RESET,CLK_12MHz)
	begin
		if(RESET = '1') then
			counter_x <= 0;
			counter_y <= 0;
			hsync <= '0';
			vsync <= '0';
			red <= "0000";
			green <= "0000";
			blue <= "0000";
	   elsif( CLK_12MHz'event and CLK_12MHz = '1') then
		 	
			if(counter_x = 799) then
					counter_x <= 0;
				if(counter_y = 524) then
			      counter_y <= 0;
			   else 
					counter_y <= counter_y + 1;
				end if;
			else 	  
			      counter_x <= counter_x + 1;
		   end if;
			
			if(counter_x >= 0 and counter_x <= 96) then	--Synchronize hsync and vsync signals
					 hsync <= '1';
					 vsync <= '0';
			end if;
			
			if(counter_y >= 0 and counter_y <= 2) then
					 hsync <= '0';
					 vsync <= '1';
			end if;
		 
			 if(counter_y < 135) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
			 elsif(counter_y >= 135 and counter_y < 205) then
					if(counter_x < 324) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					elsif(counter_x >= 324 and counter_x < 604) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 604) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					end if;
			elsif(counter_y >= 205 and counter_y < 300) then
					if(counter_x < 324) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					elsif(counter_x >= 324 and counter_x < 371) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 371 and counter_x < 381) then
						red <= "0000";   --black
						green <= "0000";
						blue <= "0000";
					elsif(counter_x >= 381 and counter_x < 604) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 604) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					end if;
				
				elsif(counter_y >= 300 and counter_y < 310) then
					if(counter_x < 324) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					elsif(counter_x >= 324 and counter_x < 371) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 371 and counter_x < 557) then
						red <= "0000";   --black
						green <= "0000";
						blue <= "0000";
					elsif(counter_x >= 557 and counter_x < 604) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 604) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					end if;
		
				elsif(counter_y >= 310 and counter_y < 414) then
					if(counter_x < 324) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					elsif(counter_x >= 324 and counter_x < 604) then
						red <= "1111";   --purple
						green <= "0000";
						blue <= "1111";
					elsif(counter_x >= 604) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
					end if;
					
				elsif(counter_y >= 415) then
						red <= "1111";   --white
						green <= "1111";
						blue <= "1111";
				end if;
				
		end if;		
	end process Proc;
end architecture arch;

