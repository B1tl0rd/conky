READ ME

extract the archive to your home folder:
NOTE 
use a program like Archive Manager to do this.  
DON'T use the right click "Extract Here" option in your file manager as this will get the path to the files wrong

If the extraction was successful then you will have a folder in your home directory like so:

/home/username/v9000

inside this folder you will find, amongst other things a file called

.v9000_config.lua

if you cant find .v9000_config.lua this is because the . at the beginning of the name makes it hidden
on most systems ctrl+h is the shortcut to see hidden files, otherwise go to "view" and select "show hidden files"
v9000_config.lua contains all the user settings v9000 requires

you will need to edit .v9000_config.lua initially to enter your personal settings and preferences.  Each setting is commented so just work your way through it.

IMPORTANT
You need to move the config file out of the v9000 folder and place it into your home directory so it is like this:

/home/username/.v9000_config.lua

other things in the v9000 folder :

1. v9000.lua
v9000.lua is the main script that gathers the weather data and processes it
there should be no need to edit the v9000.lua
v9000.lua should find .v9000_config.lua automatically but if for any reason you get a v9000.lua error specifying line 9 as the problem, then edit v9000.lua on line 8 and enter your username directly

2. weather_script.lua
weather_script.lua contains a sample weather display setup
	also "s11template.lua" which is an alternate weather display setup
	and "weather_testing.lua" which is a test configuration showing all the data options available through the script
		NOTE by default weather.testing will be displayed to check your settings for errors
		you will need to edit conky_weather and change the lua_load line to point to one of the other display setups

3. additional_files
the additional_files directory contains the fonts that can be used in the script and the folder weathericons which contain the icons
	there is also an alternative icons folder called weathericons_falldown
you will need to install the fonts in this folder before starting up conky if you want to use them

4.  this readme!

5. an example conkyrc set up with the information needed to run the scripts
to launch the conkyrc type in a terminal

conky -c ~/v9000/conky_weather

if you already have a conkyrc that works with yur system you will have to setup a conkyrc to run the scripts
in conkyrc you need, in addition to all your regular conky settings, these lines to setup the scripts:
-------------------------------------------------
lua_load /path_to_your_file/v9000.lua
lua_draw_hook_pre weather
lua_load /path_to your_file/weather_script.lua

TEXT

------------------------------------------------
the second lua_load to load weather_script.lua is necessary so that changes entered into this script take effect as soon as the script is saved
there is no additional lua_load line for weather_settings.lua as this script need only be read at startup
due to this, any changes made to weather_settings.lua will not take effect untill conky is killed and restarted

you can save different weather scripts as different names as long as they end in the .lua suffix
then edit the conky rc to call the display script you want to use

HOW TO write a weather display
http://crunchbanglinux.org/forums/post/162437/#p162437

mrpeachy
