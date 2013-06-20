--[[
 The latest script is a lua only weather script. aka: v9000
 http://crunchbanglinux.org/forums/topic/16100/weather-in-conky/

 the file:
http://dl.dropbox.com/u/19008369/v9000.tar.gz

 mrppeachys LUA Tutorial
 http://crunchbanglinux.org/forums/topic/17246/how-to-using-lua-scripts-in-conky/
]]
_G.weather_script = function()--#### DO NOT EDIT THIS LINE ##############
--these tables hold the coordinates for each repeat do not edit #########
top_left_x_coordinate={}--###############################################
top_left_y_coordinate={}--###############################################
--#######################################################################
--SET DEFAULTS ##########################################################
--set defaults do not localise these defaults if you use a seperate display script
default_font="Anonymous Pro:bold"--font must be in quotes
default_font_size=11
default_color=0xffffff--white
default_alpha=1--fully opaque
default_image_width=50
default_image_height=50
--END OF DEFAULTS #######################################################
--START OF WEATHER CODE -- START OF WEATHER CODE -- START OF WEATHER CODE
out({c=0x00BFFF,a=1,x=10,y=15,txt=now["date"].." "..now["month_short"].." "..now["year"]..": Fetched @ "..now["time"]})
image({x=20,y=20,h=40,w=40,file=now["weather_icon"]})
-- Temp / FeelsLike & CONDITIONS TEXT
out({c=0x48D1CC,a=1,f="Digital-7",fs=50,x=80,y=60,txt=now["temp"]})
out({c=0x00BFFF,a=1,f="Digital-7",fs=50,x=140,y=60,txt=now["feels_like"]})
out({c=0xA4FFA4,a=1,x=81,y=72,txt="Temp          WC · HI"})

out({c=0x48D1CC,a=1,f="Zekton",fs=18,x=10,y=94,txt=now["conditions"]})

-- data titles
--    data output 
datay=110   -- y=datay or
datayy=15   -- y=datay+(datayy*1) use 1 or more

out({c=0xFAFAEC,a=1,x=10,y=datay,txt="Wind Chill:"})
   out({c=0x48D1CC,a=1,x=70,y=datay,txt=now["wind_chill"].."°"})
out({c=0xFAFAEC,a=1,x=100,y=datay,txt="Heat Index:"})
   out({c=0xFF8C00,a=1,x=165,y=datay,txt=now["heat_index"].."°"})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*1),txt="Today's Hi·Lo:"})
   out({c=0xFF8C00,a=1,x=100,y=datay+(datayy*1),txt=high_temp[1].."°"})
   out({c=0x48D1CC,a=1,x=140,y=datay+(datayy*1),txt=low_temp[1].."°"})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*2),txt="Wind:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*2),txt=now["wind_km"]})
   out({c=0x48D1CC,a=1,x=110,y=datay+(datayy*2),txt=now["wind_nesw"]})
   out({c=0xFAFAEC,a=1,x=140,y=datay+(datayy*2),txt="@"})
   out({c=0x48D1CC,a=1,x=165,y=datay+(datayy*2),txt=now["wind_deg"]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*3),txt="Hum:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*3),txt=now["humidity"].."%"})
out({c=0xFAFAEC,a=1,x=110,y=datay+(datayy*3),txt="DP:"})
   out({c=0x48D1CC,a=1,x=145,y=datay+(datayy*3),txt=now["dew_point"].."°"})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*4),txt="Bar:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*4),txt=now["pressure_mb"]})
out({c=0xFAFAEC,a=1,x=110,y=datay+(datayy*4),txt="Vis:"})
   out({c=0x48D1CC,a=1,x=145,y=datay+(datayy*4),txt=now["visibility"]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*5),txt="Ceil:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*5),txt=now["ceiling"]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*6),txt="Precip:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*6),txt=precipitation[1].."%"})
out({c=0xFAFAEC,a=1,x=110,y=datay+(datayy*6),txt="Cloud:"})
   out({c=0x48D1CC,a=1,x=150,y=datay+(datayy*6),txt=cloud_cover[1].."%"})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*7),txt="UV:"})
   out({c=0x48D1CC,a=1,x=60,y=datay+(datayy*7),txt=uv_index_num[1]})
   out({c=0x48D1CC,a=1,x=110,y=datay+(datayy*7),txt=uv_index_txt[1]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*8),txt="Sun:"})
   out({c=0xFAFAEC,a=1,x=60,y=datay+(datayy*8),txt=sun_rise_lc[1]})
   out({c=0x48D1CC,a=1,x=120,y=datay+(datayy*8),txt=sun_set_lc[1]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*9),txt="Moon:"})
   out({c=0xFAFAEC,a=1,x=60,y=datay+(datayy*9),txt=moon_rise_lc[1]})
   out({c=0x48D1CC,a=1,x=120,y=datay+(datayy*9),txt=moon_set_lc[1]})
out({c=0xFAFAEC,a=1,x=10,y=datay+(datayy*10),txt="Phase:"})
   out({c=0x48D1CC,a=1,x=55,y=datay+(datayy*10),txt=moon_phase[1]})

-- line
image({x=205,y=5,w=1,h=260,file="/home/sector11/Conky/images/cyan-1.png"})
-- 3 hour output
out({c=0x48D1CC,a=1,f="Anonymous Pro:bold",fs=12,x=220,y=15,txt="Next 3"})
out({c=0x48D1CC,a=1,f="Anonymous Pro:bold",fs=12,x=220,y=30,txt="Hours"})
-- 1st hour
out({c=0xA4FFA4,x=220,y=50,txt=now["fc_hour1_time"].."  "..now["fc_hour1_ampm"]})
image({w=30,h=30,x=223,y=55,file=now["fc_hour1_wicon"]}) -- image({w=30,h=30,x=223,y=55,file="/home/sector11/Conky/images/red-1.png"})
out({x=228,y=100,txt=now["fc_hour1_temp"] .."°"})
-- 2nd hour
out({c=0xA4FFA4,x=220,y=datay+(datayy*1),txt=now["fc_hour2_time"].."  "..now["fc_hour2_ampm"]})
image({w=30,h=30,x=223,y=130,file=now["fc_hour2_wicon"]}) -- image({w=30,h=30,x=223,y=130,file="/home/sector11/Conky/images/red-1.png"})
out({x=228,y=180,txt=now["fc_hour2_temp"] .."°"})
-- 3rd hour
out({c=0xA4FFA4,x=220,y=210,txt=now["fc_hour3_time"].."  "..now["fc_hour3_ampm"]})
image({w=30,h=30,x=223,y=215,file=now["fc_hour3_wicon"]}) -- image({w=30,h=30,x=223,y=215,file="/home/sector11/Conky/images/red-1.png"})
out({x=228,y=datay+(datayy*10),txt=now["fc_hour3_temp"] .."°"})
-- line
image({x=275,y=5,w=1,h=260,file="/home/sector11/Conky/images/cyan-1.png"})

--start or weather forecast table section
--set start forecast day
start_day=1
--set total forecast days you want to display
number_of_days=5
topy=15
topyy=135 -- topy+(topyy*1)
topx=285
topxx=137.5
--set coordinates for top lef corners for each repeat
top_left_x_coordinate[1],top_left_y_coordinate[1]        =topx            ,topy
   top_left_x_coordinate[2],top_left_y_coordinate[2]     =topx ,150
top_left_x_coordinate[3],top_left_y_coordinate[3]        =10  ,290
   top_left_x_coordinate[4],top_left_y_coordinate[4]     =10+(topxx*1) ,290
top_left_x_coordinate[5],top_left_y_coordinate[5]        =10+(topxx*2)  ,290
--########################################################################################
for i=start_day,number_of_days-(start_day-1) do --start of day repeat, do not edit #######
tlx=top_left_x_coordinate[i] --sets top left x position for each repeat ##################
tly=top_left_y_coordinate[i] --sets top left y position for each repeat ##################
--########################################################################################
out({c=0xA4FFA4,a=1,x=tlx,y=tly,txt=forecast_day_short[i].."  "..forecast_date[i].."  "..forecast_month_short[i]})
image({x=tlx,y=tly+5,h=30,w=30,file=weather_icon[i]})
out({c=0xFF8C00,a=1,x=tlx+35,y=tly+15,txt=high_temp[i].."°"})
out({c=0x48D1CC,a=1,x=tlx+35,y=tly+30,txt=low_temp[i].."°"})
out({c=0x48D1CC,a=1,x=tlx,y=tly+50,txt=conditions_short[i]})

out({c=0xFAFAEC,a=1,x=tlx,y=tly+65,txt="P: "..precipitation[i].."%"})
   out({c=0xFAFAEC,a=1,x=tlx+50,y=tly+65,txt="UV: "..uv_index_num[i]})
out({c=0xFAFAEC,a=1,x=tlx,y=tly+80,txt="H: "..humidity[i].."%"})
out({c=0xFAFAEC,a=1,x=tlx,y=tly+95,txt="S: "..sun_rise_lc[i]})
   out({c=0x48D1CC,a=1,x=tlx+73,y=tly+95,txt=sun_set_lc[i]})
out({c=0xFAFAEC,a=1,x=tlx,y=tly+110,txt="M: "..moon_rise_lc[i]})
   out({c=0x48D1CC,a=1,x=tlx+73,y=tly+110,txt=moon_set_lc[i]})
--########################################################################################
end--of forecast repeat section ##########################################################
--########################################################################################
--END OF WEATHER CODE ----END OF WEATHER CODE ----END OF WEATHER CODE ---
--#######################################################################
end--of weather_display function do not edit this line ##################
--#######################################################################AAA
