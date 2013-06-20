--DISPLAY FUNCTION--DISPLAY FUNCTION--DISPLAY FUNCTION--DISPLAY FUNCTION-
_G.weather_script = function()--#### DO NOT EDIT THIS LINE ##############
--#######################################################################
--these tables hold the coordinates for each repeat do not edit #########
top_left_x_coordinate={}--###############################################
top_left_y_coordinate={}--###############################################
--#######################################################################
--SET DEFAULTS ##########################################################
--set defaults do not localise these defaults if you use a seperate display script
default_font="mono"--font must be in quotes
default_font_size=10
default_color=0xffffff--white
default_alpha=1--fully opaque
default_image_width=50
default_image_height=50
--END OF DEFAULTS #######################################################
--START OF WEATHER CODE -- START OF WEATHER CODE -- START OF WEATHER CODE
--now weather first column
starty=10
gap=12
ypos=0
ypos=starty+ypos
out({x=15,y=ypos,txt=weather_location})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day_lc"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day_short"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["day_short_lc"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month_caps"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month_lc"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month_short"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["month_short_lc"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["date"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["year"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["time"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["time_lc"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["temp"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["feels_like"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["conditions"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["conditions_lc"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["conditions_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["conditions_short"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["conditions_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["conditions_short_lc"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["wind_chill"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["heat_index"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["dew_point"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["humidity"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["wind_mph"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["wind_mph_caps"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["wind_gusts"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["wind_gusts_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["ceiling"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["ceiling_lc"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["ceiling_caps"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["pressure"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["visibility"]})
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["visibility_caps"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["weather_font"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["wind_deg"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["wind_nesw"]})
ypos=gap+ypos
out({x=15,y=ypos,txt=now["wind_font"] })
ypos=gap+ypos
out({x=15,y=ypos,txt=now["time_num"] })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["time_ampm"]  })
ypos=gap+ypos
out({c=0x00ffff,x=15,y=ypos,txt=now["time_ampm_lc"] })
--now weather second column
ypos=10
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_gusts_km"] })
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_gusts_km_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_gusts_kts"] })
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_km"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_km_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_kts"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["wind_kts_caps"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["pressure_mb"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_time"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour1_ampm"] })
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour1_ampm_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_cond"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_cond_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_cond_caps"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_wfont"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour1_temp"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour1_cond_short"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour1_cond_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour1_cond_short_lc"]})
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_time"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour2_ampm"] })
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour2_ampm_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_cond"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_cond_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_cond_caps"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_wfont"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour2_temp"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour2_cond_short"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour2_cond_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour2_cond_short_lc"]})
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_time"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour3_ampm"] })
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour3_ampm_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_cond"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_cond_lc"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_cond_caps"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_wfont"] })
ypos=gap+ypos
out({x=160,y=ypos,txt=now["fc_hour3_temp"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour3_cond_short"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour3_cond_short_caps"]})
ypos=gap+ypos
out({c=0x00ffff,x=160,y=ypos,txt=now["fc_hour3_cond_short_lc"]})
--END OF ALL NOW
--ALL FORECAST STUFF
--first column
ypos=10
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day_caps[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day_lc[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day_short[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day_short_caps[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_day_short_lc[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_month[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_month_caps[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_month_lc[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= forecast_month_short[1]})
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= forecast_month_short_caps[1]})
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=forecast_month_short_lc[1]  })
ypos=gap+ypos
out({x=305,y=ypos,txt=forecast_date[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt= weather_font[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= high_temp[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt=low_temp[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt=conditions[1]  })
ypos=gap+ypos
out({x=305,y=ypos,txt= conditions_caps[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt=conditions_lc[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=conditions_short[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= conditions_short_caps[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=conditions_short_lc[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=sun_rise[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= sun_rise_lc[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt= sun_rise_time[1]})
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_rise[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_rise_lc[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt= moon_rise_time[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_rise_ampm[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_rise_ampm_lc[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= sun_set[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= sun_set_lc[1] })
ypos=gap+ypos
out({x=305,y=ypos,txt= sun_set_time[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_set[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_set_lc[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= moon_set_time[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=moon_set_ampm[1]  })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt= moon_set_ampm_lc[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= humidity[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= precipitation[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= snow[1]})
ypos=gap+ypos
out({x=305,y=ypos,txt= cloud_cover[1]})
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=moon_phase[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=moon_phase_caps[1] })
ypos=gap+ypos
out({c=0x00ffff,x=305,y=ypos,txt=moon_phase_lc[1]  })
--forecast second column
ypos=10
out({x=465,y=ypos,txt=moon_font[1]  })
ypos=gap+ypos
out({x=465,y=ypos,txt= wind_mph[1] })
ypos=gap+ypos
out({x=465,y=ypos,txt= wind_km[1] })
ypos=gap+ypos
out({x=465,y=ypos,txt= wind_kts[1]})
ypos=gap+ypos
out({x=465,y=ypos,txt= wind_font[1] })
ypos=gap+ypos
out({x=465,y=ypos,txt= wind_deg[1]})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt= wind_nesw[1]})
ypos=gap+ypos
out({x=465,y=ypos,txt= uv_index_num[1]})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt= uv_index_txt[1] })
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt= uv_index_txt_caps[1]})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt= uv_index_txt_lc[1] })
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt=alert_number})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt=alert_type[1]})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos,txt=alert_issued[1]})
ypos=gap+ypos
out({c=0x00ffff,x=465,y=ypos})
--images
ypos=180
gap=40
ypos=ypos
image({x=420,y=ypos,w=40,h=40,file=now["weather_icon"]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=now["wind_icon"]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=now["fc_hour1_wicon"]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=now["fc_hour2_wicon"]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=now["fc_hour3_wicon"]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=weather_icon[1]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=moon_icon[1]})
ypos=gap+ypos
image({x=420,y=ypos,w=40,h=40,file=wind_icon[1]})
ypos=gap+ypos
image({x=420,y=ypos,w=30,h=30,file=alert_icon})
--weather fonts
ypos=220
gap=40
ypos=ypos
xout({f="ConkyWeather",fs=32,x=480,y=ypos,w=50,h=50,txt=now["weather_font"]})
ypos=gap+ypos
out({f="ConkyWindNESW",fs=32,x=480,y=ypos,w=50,h=50,txt=now["wind_font"]})
ypos=gap+ypos
out({f="ConkyWeather",fs=32,x=480,y=ypos,w=50,h=50,txt=now["fc_hour1_wfont"]})
ypos=gap+ypos
out({f="ConkyWeather",fs=32,x=480,y=ypos,w=50,h=50,txt=now["fc_hour2_wfont"]})
ypos=gap+ypos
out({f="ConkyWeather",fs=32,x=480,y=ypos,w=50,h=50,txt=now["fc_hour3_wfont"]})
ypos=gap+ypos
out({f="ConkyWeather",fs=32,x=480,y=ypos,w=50,h=50,txt=weather_font[1]})
ypos=gap+ypos
out({f="Moon Phases",fs=32,x=480,y=ypos,w=50,h=50,txt=moon_font[1]})
ypos=gap+ypos
out({f="ConkyWindNESW",fs=32,x=480,y=ypos,w=50,h=50,txt=wind_font[1]})

ypos=30
out({x=550,y=ypos,w=50,h=50,txt=sun_rise_24[1]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=sun_set_24[1]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=moon_rise_24[1]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=moon_set_24[1]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=now["time_24"]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=now["fc_hour1_time_24"]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=now["fc_hour2_time_24"]})
ypos=gap+ypos
out({x=550,y=ypos,w=50,h=50,txt=now["fc_hour3_time_24"]})



--24hour clock
--[[
sun_rise_24[n]
sun_set_24[n]
moon_rise_24[n]
moon_set_24[n]
now["time_24"]
now["fc_hour1_time_24"]
now["fc_hour2_time_24"]
now["fc_hour3_time_24"]
--]]
--########################################################################################
--END OF WEATHER CODE ----END OF WEATHER CODE ----END OF WEATHER CODE ---
--#######################################################################
end--of weather_display function do not edit this line ##################
--#######################################################################
