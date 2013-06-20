--DISPLAY FUNCTION--DISPLAY FUNCTION--DISPLAY FUNCTION--DISPLAY FUNCTION-
_G.weather_script = function()--#### DO NOT EDIT THIS LINE ##############
--#######################################################################
--these tables hold the coordinates for each repeat do not edit #########
top_left_x_coordinate={}--###############################################
top_left_y_coordinate={}--###############################################
--#######################################################################
--SET DEFAULTS ##########################################################
--set defaults do not localise these defaults if you use a seperate display script
--default_font="DejaVu Sans"--font must be in quotes
default_font="DejaVu Sans"--font must be in quotes
default_font_size=13
default_color=0xffffff--white
default_alpha=1--fully opaque
default_image_width=50
default_image_height=50
--END OF DEFAULTS #######################################################
--START OF WEATHER CODE -- START OF WEATHER CODE -- START OF WEATHER CODE
starty=15
gap=15
ypos=0
ypos=starty+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=15,y=ypos,txt=weather_location})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=15,y=ypos,txt="Current Weather for "..now["time"]})
image({x=20,y=55,h=40,w=40,file=now["weather_icon"]})
image({x=204,y=30,h=50,w=50,file=now["wind_icon"]})
--data titles
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=15,y=ypos,txt="Conditions:"})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=70,y=ypos,txt="Temperature:"})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=70,y=ypos,txt="Feels Like:"})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=70,y=ypos,txt="      Wind:"})
--output of data options
ypos=0
ypos=starty+gap+gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=105,y=ypos,txt=now["conditions_short"]})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=170,y=ypos,txt=now["temp"].."°"})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=170,y=ypos,txt=now["feels_like"].."°"})
ypos=gap+ypos
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=170,y=ypos,txt=now["wind_mph"]})

out({x=15,y=115,txt="NEXT 3 HOURS"})
image({w=30,h=30,x=20,y=125,file=now["fc_hour1_wicon"]})--good
out({x=80,y=135,txt=now["fc_hour1_time"].." "..now["fc_hour1_ampm"]..".  TEMP: "..now["fc_hour1_temp"].."°"})
out({x=80,y=150,txt=now["fc_hour1_cond"]})

image({w=30,h=30,x=20,y=160,file=now["fc_hour2_wicon"]})--good
out({x=80,y=170,txt=now["fc_hour2_time"].." "..now["fc_hour2_ampm"]..".  TEMP: "..now["fc_hour2_temp"].."°"})
out({x=80,y=185,txt=now["fc_hour2_cond"]})

image({w=30,h=30,x=20,y=195,file=now["fc_hour3_wicon"]})--good
out({x=80,y=205,txt=now["fc_hour3_time"].." "..now["fc_hour3_ampm"]..".  TEMP: "..now["fc_hour3_temp"].."°"})
out({x=80,y=220,txt=now["fc_hour3_cond"]})
--########################################################################################
--start or weather forecast repeat section
--set start forecast day
start_day=1
--set total forecast days you want to display
number_of_days=4
topy=240
ygap=80
--set coordinates for top lef corners for each repeat
top_left_x_coordinate[1],top_left_y_coordinate[1]=15,topy
top_left_x_coordinate[2],top_left_y_coordinate[2]=120,topy
ady=topy+ygap
top_left_x_coordinate[3],top_left_y_coordinate[3]=15,ady
top_left_x_coordinate[4],top_left_y_coordinate[4]=120,ady
--########################################################################################
for i=start_day,number_of_days-(start_day-1) do--start of day repeat, do not edit ########
local tlx=top_left_x_coordinate[i]--sets top left x position for each repeat ###################
local tly=top_left_y_coordinate[i]--sets top left y position for each repeat ###################
--########################################################################################
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=tlx,y=tly,txt=forecast_day[i].." "..forecast_date[i]})
image({x=tlx,y=tly+5,h=30,w=30,file=weather_icon[i]})
out({c=0xffffff,a=1,f="DejaVu Sans",fs=12,x=tlx+35,y=tly+15,txt=high_temp[i].."°/"..low_temp[i].."°"})
--out({c=0xffffff,a=1,f="DejaVu Sans",fs=13,x=tlx,y=tly+50,txt=conditions_short[i]})
--########################################################################################
end--of forecast repeat section ##########################################################
--########################################################################################
--ALERTS SECTION
--show alert icon
--[[image({x=0,y=390,h=20,w=20,file=alert_icon})
--show number of alerts
out({x=24,y=408,fs=20,txt=alert_number})
--display alert information
display_alerts=2--set number of alerts to show,set 0 to show all
top_left_alert_x=50--set top left coordinates for entire alerts section
top_left_alert_y=400--^alerts will display in a single column
alert_gap=40--sets the gap between the TOP of one alert and the Top of the next alert
--#######################################################################################################################################
if alert_number==0 then noal=1 elseif alert_number~=0 and display_alerts>alert_number then noal=alert_number else noal=display_alerts end
for i=1,noal do--start of alerts display section. do not edit ###########################################################################
local tlx=top_left_alert_x--write output relative to tlx #################################
local tly=top_left_alert_y+((i-1)*alert_gap)--write output relative to tlx ###############
--########################################################################################
out({c=0xffffff,a=1,f="DejaVu Sans",fs=8,x=tlx,y=tly,   txt=alert_type[i]})
out({c=0xffffff,a=1,f="DejaVu Sans",fs=8,x=tlx,y=tly+15,txt=alert_issued[i]})
--########################################################################################
end--of alert display section ############################################################
--########################################################################################
--]]
--########################################################################################
--END OF WEATHER CODE ----END OF WEATHER CODE ----END OF WEATHER CODE ---
--#######################################################################
end--of weather_display function do not edit this line ##################
--#######################################################################
