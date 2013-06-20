--weather v9000 by mrpeachy 01/10/12; released: Feb 29, 2012
require 'cairo'
require 'imlib2'
local username = 'chris' -- os.getenv("USERNAME")
--you can enter your username here in case of errors, 
--enter username in quotes like this username = "yourname"
local username = username  
package.path = '/home/'..username..'/.conky/v9000/.v9000_config.lua'
require '.v9000_config'
start=1
--INITIALIZE SETTINGS-- need only be run once
settings_table=weather_settings()
--##################################
--######## main function ########### 
function conky_weather()--##########
--##################################
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
--###UNCOMMENT THE BELOW LINE TO ENABLE CPU DELAY##########################################################
--if updates>5 then--###### YOU WILL ALSO HAVE TO UNCOMMENT THE MATCHING end ON LINE 923 ####################
--#########################################################################################################
local testing=0--this setting is for script testing, if not in testing set to 0
--#########################################################################################################
--############start of timed section#######################################################################
--#########################################################################################################
local timer=(updates %tonumber(settings_table[1]))
--################################################
if timer==0 or start==1 then--######
start=nil--#######################################
local web=settings_table[2]
local alert_check=settings_table[13]
--################################################
print ("gathering data with curl")
local f=io.popen("curl --max-time 60 '"..web.."' | sed 's/%//g'")
allweatherdata=f:read("*a")
f:close()
allweatherdata=string.gsub(allweatherdata,"[\n\r]","")
testall=string.find(allweatherdata,">10 Day Forecast&nbsp")
--CHECK FOR WEATHER ALERTS
if testall~=nil and alert_check==1 then
local alert=string.find(allweatherdata,"Severe Weather Alert!")
	if alert~=nil then
	print ("getting weather alerts")
	--get alert web
	local a,b,alertchunk=string.find(allweatherdata,">Local Information</div>(.*)>Severe Weather Alert!<")
	local a,b,alertsite=string.find(alertchunk,"><a href=%p(.*)%p><img src=")
	local f=io.popen("curl --max-time 60 'http://www.intellicast.com"..alertsite.."' | sed 's/%//g'")
	alertdata=f:read("*a")
	f:close()
	alertdata=string.gsub(alertdata,"[\n\r]","")
	alerttest=string.find(alertdata,"%a")
	else
	print ("you have no weather alerts")
	alerttest=0
	end--if alert~=nil
else
print ("not checking for alerts")
alerttest=1
end--if testall and alert check
processall=1
end--of timed data gathering section
--#########################################################################

--#########################################################################
--in case curl craps up it should retry until it works
if testall==nil or  alerttest==nil then
print ("curl attempt timed out, trying again")
local web=settings_table[2]
local alert_check=settings_table[13]
local f=io.popen("curl --max-time 60 '"..web.."' | sed 's/%//g'")
allweatherdata=f:read("*a")
f:close()
allweatherdata=string.gsub(allweatherdata,"[\n\r]","")
testall=string.find(allweatherdata,">10 Day Forecast&nbsp")
--CHECK FOR WEATHER ALERTS
if testall~=nil and alert_check==1 then
local alert=string.find(allweatherdata,"Severe Weather Alert!")
	if alert~=nil then
	print ("getting weather alerts")
	--get alert web
	local a,b,alertchunk=string.find(allweatherdata,">Local Information</div>(.*)>Severe Weather Alert!<")
	local a,b,alertsite=string.find(alertchunk,"><a href=%p(.*)%p><img src=")
	local f=io.popen("curl --max-time 60 'http://www.intellicast.com"..alertsite.."' | sed 's/%//g'")
	alertdata=f:read("*a")
	f:close()
	alertdata=string.gsub(alertdata,"[\n\r]","")
	alerttest=string.find(alertdata,"%a")
	else
	print ("you have no weather alerts")
	alerttest=0
	end--if alert~=nil
else
print ("not checking for alerts")
alerttest=1
end--if testall and alert_check
processall=1
end--if testall==nil
--end or curl reruns ######################################################

--START PROCESSING ###########################################################################
if testall~=nil and alerttest~=nil and processall==1 then
local weathericons=settings_table[3]
local con_short=settings_table[4]
local visibility_unit=settings_table[6]
local wind_mph_unit=settings_table[7]
local wind_km_unit=settings_table[8]
local wind_kts_unit=settings_table[9]
local ceiling_unit=settings_table[10]
local wind_degrees_unit=settings_table[11]
local translate=settings_table[12]
local alert_check=settings_table[13]
--#########################################################################
--LOAD TRANSLATE TABLES IF TRANSLATE SETTING = 1
	if translate==1 then
	monthshort=settings_table[21]
	monthnames=settings_table[20]
	dayhort=settings_table[19]
	daynames=settings_table[18]
	neswtext=settings_table[14]
	tsuffix=settings_table[15]
	uvindextext=settings_table[16]
	moonphases=settings_table[17]
	additional=settings_table[22]
	else--neswtext,tsuffix,uvindextext,moonphases,daynames,dayshort,monthnames,monthshort
	dayshort={Monday="Mon",Tuesday="Tue",Wednesday="Wed",Thursday="Thu",Friday="Fri",Saturday="Sat",Sunday="Sun"}
	monthshort={January="Jan",February="Feb",March="Mar",April="Apr",May="May",June="Jun",July="Jul",August="Aug",September="Sep",October="Oct",November="Nov",December="Dec"}
	end--end if translate =1
--#########################################################################
--process data tables
--intellicast to conky weather icon conversion
wimage={
wx_65="32",  -- Clear
wx_66="30",  -- Partly Cloudy
wx_67="26",  -- Cloudy
wx_68="32",  -- Clear
wx_69="28",  -- Mostly Cloudy
wx_70="20",  -- Fog
wx_71="32",  -- Clear
wx_72="21",  -- Haze
wx_73="36",  -- Hot
wx_74="14",  -- Light Snow Showers
wx_75="28",  -- Mostly Cloudy
wx_76="18",  -- Sleet
wx_77="14",  -- Light Snow Showers
wx_78="23",  -- Blustery
wx_79="05",  -- Mixed Rain and Snow
wx_80="15",  -- Drifting Snow
wx_81="15",  -- Drifting Snow
wx_82="11",  -- Light Rain
wx_83="16",  -- Snow
wx_84="00",  -- Tornado
wx_85="32",  -- Clear
wx_86="25",  -- N/A
wx_87="09",  -- Drizzle
wx_88="05",  -- Mixed Rain and Snow
wx_89="18",  -- Sleet
wx_90="18",  -- Sleet
wx_91="39",  -- Scattered Showers
wx_92="39",  -- Scattered Showers
wx_93="39",  -- Scattered Showers
wx_94="39",  -- Scattered Showers
wx_95="37",  -- Isolated Thunderstorms
wx_96="37",  -- Isolated Thunderstorms
wx_97="31",  -- Clear
wx_98="29",  -- Partly Cloudy
wx_99="27",  -- Mostly Cloudy
wx_100="47",  -- Isolated Thunderstorms
wx_101="47",  -- Isolated Thunderstorms
wx_102="33",  -- Fair
wx_103="26",  -- Cloudy
wx_104="20",  -- Fog
wx_105="45",  -- Scattered Showers
wx_106="45",  -- Scattered Showers
wx_107="11",  -- Light Rain
wx_108="46",  -- Snow Showers
wx_109="46",  -- Snow Showers
wx_110="06",  -- Mixed Rain and Sleet
wx_111="18",  -- Sleet
wx_112="06",  -- Mixed Rain and Sleet
wx_113="46",  -- Snow Showers
wx_114="46",  -- Snow Showers
wx_115="31",  -- Clear
wx_116="47",  -- Isolated Thunderstorms
}--end w image table
--convert intellicast icons to weather font
wfont={
wx_65="a",
wx_66="c",
wx_67="f",
wx_68="a",
wx_69="d",
wx_70="0",
wx_71="a",
wx_72="9",
wx_73="5",
wx_74="p",
wx_75="d",
wx_76="w",
wx_77="p",
wx_78="6",
wx_79="x",
wx_80="8",
wx_81="8",
wx_82="h",
wx_83="q",
wx_84="m",
wx_85="a",
wx_86="-",
wx_87="h",
wx_88="x",
wx_89="w",
wx_90="w",
wx_91="g",
wx_92="g",
wx_93="g",
wx_94="g",
wx_95="k",
wx_96="k",
wx_97="A",
wx_98="C",
wx_99="D",
wx_100="K",
wx_101="K",
wx_102="B",
wx_103="f",
wx_104="0",
wx_105="G",
wx_106="G",
wx_107="h",
wx_108="O",
wx_109="O",
wx_110="x",
wx_111="w",
wx_112="x",
wx_113="O",
wx_114="O",
wx_115="A",
wx_116="K",
}--end w font table
--conversion day and month tables
moonfontt={
["New"]="@",
["Full"]="=",
["First Quarter"]="T",
["Last Quarter"]="G",
["Waning Gibbous"]="D",
["Waning Crescent"]="J",
["Waxing Crescent"]="Q",
["Waxing Gibbous"]="W",
}--end of moon font table
moonicont={
["New"]=weathericons.."moon_new.png",
["Full"]=weathericons.."moon_full.png",
["First Quarter"]=weathericons.."moon_first_quarter.png",
["Last Quarter"]=weathericons.."moon_last_quarter.png",
["Waning Gibbous"]=weathericons.."moon_waning_gibbous.png",
["Waning Crescent"]=weathericons.."moon_waning_crescent.png",
["Waxing Crescent"]=weathericons.."moon_waxing_crescent.png",
["Waxing Gibbous"]=weathericons.."moon_waxing_gibbous.png",
}--end of moon icon table
windfontt={
S="9",
SSW=":",
SW=";",
WSW="<",
W="=",
WNW=">",
NW="?",
NNW="@",
N="1",
NNE="2",
NE="3",
ENE="4",
E="5",
ESE="6",
SE="7",
SSE="8"
}--end of wind direction font table
--#########################################################################

--#########################################################################
--setup tables for forecast weather
forecast_day={}
forecast_day_caps={}
forecast_day_lc={}
forecast_day_short={}
forecast_day_short_caps={}
forecast_day_short_lc={}
forecast_month={}
forecast_month_caps={}
forecast_month_lc={}
forecast_month_short={}
forecast_month_short_caps={}
forecast_month_short_lc={}
forecast_date={}
weather_icon={}
weather_font={}
high_temp={}
low_temp={}
conditions={}
conditions_caps={}
conditions_lc={}
conditions_short={}
conditions_short_caps={}
conditions_short_lc={}
sun_rise={}
sun_rise_lc={}
sun_rise_time={}
sun_rise_24={}
moon_rise={}
moon_rise_lc={}
moon_rise_time={}
moon_rise_24={}
moon_rise_ampm={}
moon_rise_ampm_lc={}
sun_set={}
sun_set_lc={}
sun_set_time={}
sun_set_24={}
moon_set={}
moon_set_lc={}
moon_set_time={}
moon_set_24={}
moon_set_ampm={}
moon_set_ampm_lc={}
humidity={}
precipitation={}
snow={}
cloud_cover={}
moon_phase={}
moon_phase_caps={}
moon_phase_lc={}
moon_font={}
moon_icon={}
wind_mph={}
wind_km={}
wind_kts={}
wind_font={}
wind_icon={}
wind_deg={}
wind_nesw={}
uv_index_num={}
uv_index_txt={}
uv_index_txt_caps={}
uv_index_txt_lc={}
--#########################################################################

--#########################################################################
--get forecast chunk
local a,b,allweather=string.find(allweatherdata,">10 Day Forecast&nbsp(.*)>More from Intellicast</div>")
--extract information into tables
local start=0
local f=1
while f~=nil do
--match forecast day name and date
local s,f,t=string.find(allweather,"<td colspan=\"2\"><strong>([%a,%s%d]*)</strong></td>",start)
	if t~=nil then
	--split name from month and date
	local a,b,day=string.find(t,"(%a*),%s")
	local a,b,month=string.find(t,",%s(%a*)%s")
	local a,b,date=string.find(t,"(%d*)$")
	--ser day names, regular, caps, lowercase and short
	table.insert(forecast_day_short,dayshort[day])
	table.insert(forecast_day_short_caps,string.upper(dayshort[day]))
	table.insert(forecast_day_short_lc,string.lower(dayshort[day]))
		if translate==1 then
		day=daynames[day]
		else
		day=day
		end
	table.insert(forecast_day,day)
	table.insert(forecast_day_caps,string.upper(day))
	table.insert(forecast_day_lc,string.lower(day))
	--set month types
	table.insert(forecast_month_short,monthshort[month])
	table.insert(forecast_month_short_caps,string.upper(monthshort[month]))
	table.insert(forecast_month_short_lc,string.lower(monthshort[month]))
		if translate==1 then
		month=monthnames[month]
		else
		month=month
		end
	table.insert(forecast_month,month)
	table.insert(forecast_month_caps,string.upper(month))
	table.insert(forecast_month_lc,string.lower(month))
	--set date
	table.insert(forecast_date,date)
	end--if t~= nil
--intellicast weather icon match
local s,f,t=string.find(allweather,"40_white/(wx_[%d]*).png\"",start)
--convert to conkyweather icon
	if t~=nil then
	table.insert(weather_icon,weathericons..wimage[t]..".png")
	--convert to weather font
	table.insert(weather_font,wfont[t])
	end
--match conditions
local s,f,t=string.find(allweather," /><br />([%a%s%p]*)</td>",start)
	if t~=nil then
	table.insert(conditions,t)
	table.insert(conditions_caps,string.upper(t))
	table.insert(conditions_lc,string.lower(t))
	--set short versions--------------------------------
	local cons=t
        for k,v in pairs(con_short) do
            local cons_length=string.len(cons)
            local match_length=string.len(k)
            if cons_length==match_length then
            cons=string.gsub(cons,k,v)
            end
        end
	table.insert(conditions_short,cons)
	table.insert(conditions_short_caps,string.upper(cons))
	table.insert(conditions_short_lc,string.lower(cons))
	-----------------------------------------------------
	end
--match high temp
local s,f,t=string.find(allweather,"\"Hi\">([%p%d]*)&deg",start)
table.insert(high_temp,t)
--match low temp
local s,f,t=string.find(allweather,"\"Lo\">([%p%d]*)&deg",start)
table.insert(low_temp,t)
--match sun rise times
local s,f,t=string.find(allweather,"Rise:</strong> (%d*:%d*%s%u%u)</td>",start)
	if t~=nil then
	--get time only
	local a,b,tm=string.find(t,"([%d%p]*)")
	--get suffix only
	local a,b,suf=string.find(t,"(%u%u)")
--###############################
--24 hour conversion
table.insert(sun_rise_24,convert24(tm,suf))
--###############################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
	table.insert(sun_rise,tm.." "..suf)
	table.insert(sun_rise_lc,string.lower(tm.." "..suf))
	table.insert(sun_rise_time,tm)
	end
--match sun set times
local s,f,t=string.find(allweather,"Set:</strong> (%d*:%d*%s%u%u)</td>",f)
	if t~=nil then	
	--get time only
	local a,b,tm=string.find(t,"([%d%p]*)")
	--get suffix only
	local a,b,suf=string.find(t,"(%u%u)")
--###############################
--24 hour conversion
table.insert(sun_set_24,convert24(tm,suf))
--###############################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
	table.insert(sun_set,tm.." "..suf)
	table.insert(sun_set_lc,string.lower(tm.." "..suf))
	table.insert(sun_set_time,tm)
	end
--moon rise
local s,f,t=string.find(allweather,"Rise:</strong> (%d*:%d*%s%u%u)</td>",f)
	if t~=nil then
	--get time only
	local a,b,tm=string.find(t,"([%d%p]*)")
	--get suffix only
	local a,b,suf=string.find(t,"(%u%u)")
--###############################
--24 hour conversion
table.insert(moon_rise_24,convert24(tm,suf))
--###############################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
	table.insert(moon_rise,tm.." "..suf)
	table.insert(moon_rise_lc,string.lower(tm.." "..suf))
	table.insert(moon_rise_time,tm)
	table.insert(moon_rise_ampm,suf)
	table.insert(moon_rise_ampm_lc,string.lower(suf))
	end
--moon set
local s,f,t=string.find(allweather,"Set:</strong> (%d*:%d*%s%u%u)</td>",f)
	if t~=nil then
	--get time only
	local a,b,tm=string.find(t,"([%d%p]*)")
	--get suffix only
	local a,b,suf=string.find(t,"(%u%u)")
--###############################
--24 hour conversion
table.insert(moon_set_24,convert24(tm,suf))
--###############################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
	table.insert(moon_set,tm.." "..suf)
	table.insert(moon_set_lc,string.lower(tm.." "..suf))
	table.insert(moon_set_time,tm)
	table.insert(moon_set_ampm,suf)
	table.insert(moon_set_ampm_lc,string.lower(suf))
	end
--match uv index
local s,f,tuv=string.find(allweather,"UV Index:</strong>%s*(%d*%s*%([%a%s]*%))%s*<br />",start)
if tuv~=nil then
	--get just number
	local a,b,unm=string.find(tuv,"(%d*)%s*%([%a%s]*%)")
	--get just text
	local a,b,utx=string.find(tuv,"%d*%s*%(([%a%s]*)%)")
	table.insert(uv_index_num,unm)
		if translate==1 then
		utx=uvindextext[utx]
		else
		utx=utx
		end
	table.insert(uv_index_txt,utx)
	table.insert(uv_index_txt_caps,string.upper(utx))
	table.insert(uv_index_txt_lc,string.lower(utx))
	end
--match humidity
local s,f,t=string.find(allweather,"Humidity:</strong> (%d*)<br />",start)
table.insert(humidity,t)
--match ppt
local s,f,t=string.find(allweather,"Precipitation:</strong> (%d*)<br />",start)
table.insert(precipitation,t)
--match snow %
local s,f,t=string.find(allweather,"Snow Probability:</strong>%s*(%d*)<br />",start)
table.insert(snow,t)
--match cloud coveage
local s,f,t=string.find(allweather,"Cloud Coverage:</strong> (%d*)<br />",start)
table.insert(cloud_cover,t)
--match moon phase
local s,f,t=string.find(allweather,"Moon Phase:</strong> ([%a%s]*) <br />",start)
--set moon phase text
	if t~= nil then
	--set moon phase font and icon
	table.insert(moon_font,moonfontt[t])
	table.insert(moon_icon,moonicont[t])
		if translate==1 then
		t=moonphases[t]
		else
		t=t
		end
	table.insert(moon_phase,t)
	table.insert(moon_phase_caps,string.upper(t))
	table.insert(moon_phase_lc,string.lower(t))
	end
--match wind speeds
local s,f,tmph=string.find(allweather,"Wind Speed:</strong> (%d*)Mph",start)
local tmph=tonumber(tmph)
table.insert(wind_mph,tmph)
local s,f,t=string.find(allweather,"Mph%s*%((%d*)Km,",start)
table.insert(wind_km,t)
local s,f,t=string.find(allweather,"Km,%s*(%d*)Kts%)",start)
table.insert(wind_kts,t)
--match wind direction
local s,f,twd=string.find(allweather,"Wind Direction:</strong> ([%d&;%s%(%a%)]*)%s*</div>",start)
	if twd~=nil then
	local a,b,tdeg=string.find(twd,"(%d*)&deg;")
	table.insert(wind_deg,tdeg)
	--match wind font and nesw   
	local a,b,tnesw=string.find(twd,"%((%a*)%)")
	table.insert(wind_font,windfontt[tnesw])
		if tmph>0 and tmph<19 then
		table.insert(wind_icon,weathericons.."green_"..string.lower(tnesw)..".png")
		elseif tmph>18 and tmph<38 then
		table.insert(wind_icon,weathericons.."yellow_"..string.lower(tnesw)..".png")
		elseif tmph>37 and tmph<64 then
		table.insert(wind_icon,weathericons.."orange_"..string.lower(tnesw)..".png")
		elseif tmph>63 then
		table.insert(wind_icon,weathericons.."green_"..string.lower(tnesw)..".png")
		elseif tmph==0 then
		table.insert(wind_icon,weathericons.."no_wind.png")
		end
		if translate==1 then
		tnesw=neswtext[tnesw]
		else
		tnesw=tnesw
		end
	table.insert(wind_nesw,tnesw)
	end
if f==nil then break end
start=f
end--while
--#########################################################################################################################################

--#########################################################################
--get location
local a,b,wl=string.find(allweatherdata,"<title>%s*Intellicast%s%p%s(.*)</title>")
weather_location=string.gsub(wl," Extended Forecast in",",")
--#########################################################################

--#########################################################################
--format now weather
--extract current data
--get now weather chunk
local a,b,nowweather=string.find(allweatherdata,">Current Conditions&nbsp(.*)>View Detailed Observations for the last<br />")
now={}
monthlong={Jan="January",Feb="February",Mar="March",Apr="April",May="May",Jun="June",Jul="July",Aug="August",Sep="September",Oct="October",Nov="November",Dec="December"}
local s,f,tnow=string.find(nowweather,"<div style=\"float:right;color:#666;\">  As of ([%d%p%a%s]*) %(Local Time%)")
local s,f,t=string.find(tnow,"(%d*%p%d*%s%a*) on")
--get time only
local a,b,ntm=string.find(t,"(%d*%p%d*)")
--get suffix only
local a,b,suf=string.find(t,"(%u%u)")
--###############################
--24 hour conversion
now["time_24"]=convert24(ntm,suf)
--###############################
if translate==1 then
suf=tsuffix[suf]
else
suf=suf
end
now["time"]=ntm.." "..suf
now["time_lc"]=string.lower(ntm.." "..suf)
now["time_num"]=ntm
now["time_ampm"]=suf
now["time_ampm_lc"]=string.lower(suf)
--get day
local s,f,t=string.find(tnow,"on (%a*)%s%d*")
if translate==1 then
day=daynames[t]
else
day=t
end
now["day"]=day
now["day_caps"]=string.upper(day)
now["day_lc"]=string.lower(day)
--short day names
local ds=dayshort[t]
now["day_short"]=ds
now["day_short_caps"]=string.upper(ds)
now["day_short_lc"]=string.lower(ds)
--get date
local s,f,t=string.find(tnow,"%s(%d%d)%s")
now["date"]=t
--get months
local s,f,t=string.find(tnow,"%d%d%s(%a*)%s%d")
if translate==1 then
mnth=monthlong[t]
now["month_short"]=monthshort[mnth]
now["month_short_caps"]=string.upper(monthshort[mnth])
now["month_short_lc"]=string.lower(monthshort[mnth])
mnth=monthnames[mnth]
else
now["month_short"]=t
now["month_short_caps"]=string.upper(t)
now["month_short_lc"]=string.lower(t)
mnth=monthlong[t]
end
now["month"]=mnth
now["month_caps"]=string.upper(mnth)
now["month_lc"]=string.lower(mnth)
--get year
local s,f,t=string.find(tnow,"%a%a%a%s(%d%d%d%d)")
now["year"]=t
--get weather icon
local s,f,t=string.find(nowweather,"40_white/(wx_[%d]*)%ppng%p%stitle=%p")
now["weather_icon"]=weathericons..wimage[t]..".png"
now["weather_font"]=wfont[t]
--class=%pIcon%p /> ([%a%s]*)%s*</td>
local s,f,t=string.find(nowweather,"class=%pIcon%p /> ([%a%s%p]*)%s*%s*</td>%s*<td class=%pEmpty%p>&nbsp;")
local t=t:gsub("^%s*(.-)%s*$", "%1")
now["conditions"]=t
now["conditions_caps"]=string.upper(t)
now["conditions_lc"]=string.lower(t)
--set short versions------------------------
	local cons=t
        for k,v in pairs(con_short) do
            local cons_length=string.len(cons)
            local match_length=string.len(k)
            if cons_length==match_length then
            cons=string.gsub(cons,k,v)
            end
        end
	now["conditions_short"]=cons
	now["conditions_short_caps"]=string.upper(cons)
	now["conditions_short_lc"]=string.lower(cons)
--------------------------------------------
local s,f,t=string.find(nowweather,"Temperature\">([%p%d]*)&deg")
now["temp"]=t
local s,f,t=string.find(nowweather,">Feels Like: ([%p%d]*)&deg;</a>")
now["feels_like"]=t
local s,f,t=string.find(nowweather,">Wind Chill: </a></td>%s*<td>([%p%d]*)&deg;</td>")
now["wind_chill"]=t
local s,f,t=string.find(nowweather,">Ceiling: </a></td>%s*<td>([%a%d]*)</td>")
if t~="Unl" then
local s,f,t=string.find(t,"([%d%p]*)")
tc=t..ceiling_unit
else
	if translate==1 then unlset=additional.Unl else unlset=t end
tc=unlset
end
now["ceiling"]=tc
now["ceiling_caps"]=string.upper(tc)
now["ceiling_lc"]=string.lower(tc)
--get heat index
local s,f,t=string.find(nowweather,">Heat Index: </a></td>%s*<td>([%p%d]*)&deg;</td>")
now["heat_index"]=t
--get visibility
local s,f,t=string.find(nowweather,">Visibility: </a></td>%s*<td>([%a%d%p]*)</td>")
if t~="Unl" then
local s,f,t=string.find(t,"([%d%p]*)")
tv=t..visibility_unit
else
	if translate==1 then unlset=additional.Unl else unlset=t end
tv=unlset
end
now["visibility"]=tv
now["visibility_caps"]=string.upper(tv)
--get dew point
local s,f,t=string.find(nowweather,">Dew Point: </a></td>%s*<td>([%p%d]*)&deg;</td>")
now["dew_point"]=t
--get wind speed
local s,f,t=string.find(nowweather,">Wind: </a></td>%s*<td>(%d*)mph</td>")
local tmph=tonumber(t)
now["wind_mph"]=t..wind_mph_unit
now["wind_mph_caps"]=string.upper(t..wind_mph_unit)
--convert mph to km and knots #################################################
--[[1 mile per hour = 0.869 international nautical mile per hour (knot)
     1 mile per hour = 1.609 kilometers per hour
     1 mile per hour = 0.4470 meter per second
     1 knot = 1.852 kilometers per hour
     1 knot = 0.5144 meter per second
     1 meter per second = 3.6 kilometers per hour]]
now["wind_km"]=round(tonumber(t)*1.609)..wind_km_unit
now["wind_km_caps"]=string.upper(round(tonumber(t)*1.609)..wind_km_unit)
now["wind_kts"]=round(tonumber(t)*0.869)..wind_kts_unit
now["wind_kts_caps"]=string.upper(round(tonumber(t)*0.869)..wind_kts_unit)
--#############################################################################
local s,f,t=string.find(nowweather,">Humidity: </a></td>%s*<td>(%d*)</td>")
now["humidity"]=t
--get wind direction #######################################################
local s,f,twd=string.find(nowweather,">Direction: </a></td>%s*<td style=[%p%a]*>([%d&;%s%(%a%)]*)</td>%s*</tr>")
--check for NA
local a,b,t=string.find(twd,"(%a*)")
local tnesw=t
if tnesw~="NA" then
local a,b,t=string.find(twd,"(%d*)&deg;")
now["wind_deg"]=t..wind_degrees_unit
local a,b,tnesw=string.find(twd,"%((%a*)%)")
	if tmph>0 and tmph<19 then
	now["wind_icon"]=weathericons.."green_"..string.lower(tnesw)..".png"
	elseif tmph>18 and tmph<38 then
	now["wind_icon"]=weathericons.."yellow_"..string.lower(tnesw)..".png"
	elseif tmph>37 and tmph<64 then
	now["wind_icon"]=weathericons.."orange_"..string.lower(tnesw)..".png"
	elseif tmph>63 then
	now["wind_icon"]=weathericons.."green_"..string.lower(tnesw)..".png"
	end
now["wind_font"]=windfontt[tnesw]
--################################
	if translate==1 then
	tnesw=neswtext[tnesw]
	else
	tnesw=tnesw
	end
--################################
now["wind_nesw"]=tnesw		
else
	if translate==1 then naset=additional.NA else naset="NA" end
now["wind_deg"]=naset
now["wind_icon"]=weathericons.."no_wind.png"
now["wind_nesw"]=naset
now["wind_font"]=windfontt["N"]
end
--END WIND DIRECTION #######################################################
--get pressure
local s,f,t=string.find(nowweather,">Pressure: </a></td>%s*<td>([%d%p]*)\"</td>")
now["pressure"]=t
--convert pressures ########################################################
--[[ 1 inch of mercury = 25.4 mm of mercury = 33.86 millibars
     = 33.86 hectoPascals]]
now["pressure_mb"]=round(tonumber(t)*33.86)
--##########################################################################
local s,f,t=string.find(nowweather,">Gusts: </a></td>%s*<td>([%d%a]*)</td>")
if t~="NA" then
local s,f,t=string.find(t,"(%d*)")
tg=t..wind_mph_unit
tgkm=round(tonumber(t)*1.609)..wind_km_unit
tgkts=round(tonumber(t)*0.869)..wind_kts_unit
else
	if translate==1 then naset=additional.NA else naset="NA" end
tg=naset
tgkm=naset
tgkts=naset
end
now["wind_gusts"]=tg
now["wind_gusts_caps"]=string.upper(tg)
now["wind_gusts_km"]=tgkm
now["wind_gusts_km_caps"]=string.upper(tgkm)
now["wind_gusts_kts"]=tgkts
now["wind_gusts_kts_caps"]=string.upper(tgkts)
--##########################################################################
--get hourly forecast options hour1--------------------
--get day 1 bit
local s,f,hfc=string.find(nowweather,"<td class=%pHour%p%sstyle=%ppadding%pleft([%a%d%p%s]*)%pdeg%p</strong>",1)
--get time and conditions
--<strong>1 PM</strong><br />%s*P Cloudy%s*</td>%s*<td class=%pHour%p
local a,b,tm=string.find(hfc,"<strong>([%d%p]*)[%s%a]*</strong><br",1)
local a,b,suf=string.find(hfc,"<strong>[%d%p%s]*([%a]*)</strong><br",1)
--24 hour conversion ######################
now["fc_hour1_time_24"]=convert24(tm,suf)
--#########################################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
now["fc_hour1_time"]=tm
now["fc_hour1_ampm"]=suf
now["fc_hour1_ampm_lc"]=string.lower(suf)
local a,b,t=string.find(hfc,"</strong><br%s/>%s*([%p%s%a]*)%s*</td>%s*<td class=%pHour%p",1)
now["fc_hour1_cond"]=t
now["fc_hour1_cond_lc"]=string.lower(t)
now["fc_hour1_cond_caps"]=string.upper(t)
----------set short versions--------------------------------
	local cons=t
        for k,v in pairs(con_short) do
            local cons_length=string.len(cons)
            local match_length=string.len(k)
            if cons_length==match_length then
            cons=string.gsub(cons,k,v)
            end
        end
	now["fc_hour1_cond_short"]=cons
	now["fc_hour1_cond_short_caps"]=string.upper(cons)
	now["fc_hour1_cond_short_lc"]=string.lower(cons)
-------------------------------------------------------------
--get weather icon and font
local a,b,t=string.find(hfc,"32_white/(wx_[%d]*)%ppng%p%stitle=%p",1)
now["fc_hour1_wicon"]=weathericons..wimage[t]..".png"
now["fc_hour1_wfont"]=wfont[t]
--get temperature
--><strong>-5&deg;</strong></td>
local a,b,t=string.find(hfc,"><strong>([%p%d]*)&deg;</strong></td>",1)
now["fc_hour1_temp"]=t
--end of hour1 data gathering--repeat 2 more times
--get hourly forecast options hour2--------------------
local start=tonumber(b)
--get time and conditions
--<strong>1 PM</strong><br />%s*P Cloudy%s*</td>%s*<td class=%pHour"%p
local a,b,tm=string.find(hfc,"<strong>([%d%p]*)[%s%a]*</strong><br",start)
local a,b,suf=string.find(hfc,"<strong>[%d%p%s]*([%a]*)</strong><br",start)
--24 hour conversion ######################
now["fc_hour2_time_24"]=convert24(tm,suf)
--#########################################	
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
now["fc_hour2_time"]=tm
now["fc_hour2_ampm"]=suf
now["fc_hour2_ampm_lc"]=string.lower(suf)
local a,b,t=string.find(hfc,"</strong><br%s/>%s*([%a%s%p]*)%s*</td>%s*<td class=%pHour%p",start)
now["fc_hour2_cond"]=t
now["fc_hour2_cond_lc"]=string.lower(t)
now["fc_hour2_cond_caps"]=string.upper(t)
----------set short versions--------------------------------
	local cons=t
        for k,v in pairs(con_short) do
            local cons_length=string.len(cons)
            local match_length=string.len(k)
            if cons_length==match_length then
            cons=string.gsub(cons,k,v)
            end
        end
	now["fc_hour2_cond_short"]=cons
	now["fc_hour2_cond_short_caps"]=string.upper(cons)
	now["fc_hour2_cond_short_lc"]=string.lower(cons)
-------------------------------------------------------------
--get weather icon and font
local a,b,t=string.find(hfc,"32_white/(wx_[%d]*)%ppng%p%stitle=%p",start)
now["fc_hour2_wicon"]=weathericons..wimage[t]..".png"
now["fc_hour2_wfont"]=wfont[t]
--get temperature
--><strong>-5&deg;</strong></td>
local a,b,t=string.find(hfc,"><strong>([%p%d]*)&deg;</strong></td>",start)
now["fc_hour2_temp"]=t
--end of hour2 data gathering--repeat 1 more times
--get hourly forecast options hour3--------------------
local start=tonumber(b)
--get time and conditions
--<strong>1 PM</strong><br />%s*P Cloudy%s*</td>%s*<td class=%pHour"%p
local a,b,tm=string.find(hfc,"<strong>([%d%p]*)[%s%a]*</strong><br",start)
local a,b,suf=string.find(hfc,"<strong>[%d%p%s]*([%a]*)</strong><br",start)
--24 hour conversion ######################
now["fc_hour3_time_24"]=convert24(tm,suf)
--#########################################
		if translate==1 then
		suf=tsuffix[suf]
		else
		suf=suf
		end
now["fc_hour3_time"]=tm
now["fc_hour3_ampm"]=suf
now["fc_hour3_ampm_lc"]=string.lower(suf)
local a,b,t=string.find(hfc,"</strong><br%s/>%s*([%a%s%p]*)%s*</td>%s*<td class=%pHour%p",start)
now["fc_hour3_cond"]=t
now["fc_hour3_cond_lc"]=string.lower(t)
now["fc_hour3_cond_caps"]=string.upper(t)
----------set short versions--------------------------------
	local cons=t
        for k,v in pairs(con_short) do
            local cons_length=string.len(cons)
            local match_length=string.len(k)
            if cons_length==match_length then
            cons=string.gsub(cons,k,v)
            end
        end
	now["fc_hour3_cond_short"]=cons
	now["fc_hour3_cond_short_caps"]=string.upper(cons)
	now["fc_hour3_cond_short_lc"]=string.lower(cons)
-------------------------------------------------------------
--get weather icon and font
local a,b,t=string.find(hfc,"32_white/(wx_[%d]*)%ppng%p%stitle=%p",start)
now["fc_hour3_wicon"]=weathericons..wimage[t]..".png"
now["fc_hour3_wfont"]=wfont[t]
--get temperature
--><strong>-5&deg;</strong></td>
local a,b,t=string.find(hfc,"><strong>([%p%d]*)",start)
now["fc_hour3_temp"]=t
--end of hour3 data gathering--finished for all hours
--ALERTS###############################################################
if alert_check==1 then
--set tables
alert_type={}
alert_issued={}
if alerttest~=0 then
alert_icon=weathericons.."icon_alert_1.gif"
--extract information into tables
local start=0
local f=1
while f~=nil do
local s,f,t=string.find(alertdata,"><strong class='Alert'>([%a%s]*)</strong><br/>",start)
	if t~=nil then
	table.insert(alert_type,string.upper(t))
	end--if t~=nil
local s,f,t=string.find(alertdata,"<br />([%d%a%s:]*)<br /><br />",start)
	if t~=nil then
	table.insert(alert_issued,t)
	end--if t~=nil
if f==nil then break end
start=f
alert_number=#alert_type
end--while
else
alert_icon=weathericons.."icon_alert_0.gif"
table.insert(alert_type,"NO ALERTS")
table.insert(alert_issued,"")
alert_number=0
end--alerttest~=nil
else
alert_type={}
alert_issued={}
alert_icon=weathericons.."icon_alert_0.gif"
table.insert(alert_type,"alerts turned off")
table.insert(alert_issued,"")
alert_number=0
end--if alert check ###########################################
--###############end of data processing########################

--#########################################################################
if testing==0 then
processall=0
print ("processing complete")
elseif testing==1 then
processall=1
end--if testing ==0
--###################################################################################
end--of data processing section #####################################################
--###################################################################################
if processall==0 or testing==1 then
_G.weather_script()
end
--#########################################################################################################
--###UNCOMMENT THE BELOW LINE TO ENABLE CPU DELAY##########################################################
--end--####### end of if updates>5 #############################
--#########################################################################################################

cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
--######################################
end-- end main function ################
--######################################
function round(num)
	local idp=tonumber(settings_table[5])
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end--of round function #################################################################
function string:split(delimiter)--######################################################
local result = { }
local from  = 1
local delim_from, delim_to = string.find( self, delimiter, from  )
while delim_from do
table.insert( result, string.sub( self, from , delim_from-1 ) )
from  = delim_to + 1
delim_from, delim_to = string.find( self, delimiter, from  )
end
table.insert( result, string.sub( self, from  ) )
return result
end--string split #######################################################################
function xout(txj)--c,a,f,fs,x,y,txt,j ##################################################
c=nil
c=(txj.c or default_color)
a=nil
a=(txj.a or default_alpha)
f=nil
f=(txj.f or default_font)
fs=nil
fs=(txj.fs or default_font_size)
x=nil
x=(txj.x or 0)
y=nil
y=(txj.y or 0)
txt=nil
txt=(txj.txt or "set txt")
j=nil
j=(txj.j or "l")
	local function col(c,a)
	return ( (c/0x10000) % 0x100)/255,( (c/0x100) % 0x100)/255,(c % 0x100)/255,a
	end--local function
cairo_select_font_face (cr, f, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
cairo_set_font_size (cr, fs)
local text=string.gsub(txt," ","_")
extents=cairo_text_extents_t:create()
cairo_text_extents(cr,text,extents)
local wx=extents.width
cairo_set_source_rgba (cr,col(c,a))
if j=="l" then
cairo_move_to (cr,x,y)
adx=wx
elseif j=="c" then
cairo_move_to (cr,x-(wx/2),y)
adx=wx/2
elseif j=="r" then
cairo_move_to (cr,x-wx,y)
adx=0
end
cairo_show_text (cr,txt)
cairo_stroke (cr)
nextx=nil
nextx=adx+x
return nextx
end--function xout ###################################################################
function out(txj)--c,a,f,fs,face,x,y,txt,hj,vj,ro ##################################################
local extents=cairo_text_extents_t:create()
tolua.takeownership(extents)
--#########################################################################################################
local function color(col,alp)
return ((col / 0x10000) % 0x100) / 255, ((col / 0x100) % 0x100) / 255, (col % 0x100) / 255, alp
end
--#########################################################################################################
local c=txj.c 			or default_color		or 0xffffff
local a=txj.a 			or default_alpha		or 1
local f=txj.f 			or default_font			or "mono"
local fs=txj.fs 		or default_font_size		or 12
local x=txj.x 			or 100
local y=txj.y 			or 100
local txt=txj.txt 		or "set txt"
local hj=txj.hj 		or default_hj			or "l"
local vj=txj.vj 		or default_vj			or "n"
local ro=txj.ro			or defaukt_ro			or 0
local face=txj.face		or default_face			or "normal"
--set face
if face=="normal" then
cairo_select_font_face (cr, f, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
elseif face=="bold" then
cairo_select_font_face (cr, f, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
elseif face=="italic" then
cairo_select_font_face (cr, f, CAIRO_FONT_SLANT_ITALIC, CAIRO_FONT_WEIGHT_NORMAL);
elseif face=="bolditalic" then
cairo_select_font_face (cr, f, CAIRO_FONT_SLANT_ITALIC, CAIRO_FONT_WEIGHT_BOLD);
else
print ('face not set correctly - "normal","bold","italic","bolditalic"')
end
cairo_set_font_size (cr, fs)
cairo_text_extents(cr,txt,extents)
local wx=extents.x_advance
local wd=extents.width
local hy=extents.height
local bx=extents.x_bearing
local by=extents.y_bearing+hy
local tx=x
local ty=y
--set horizontal alignment - l, c, r
if hj=="l" then
x=x-bx
rad=0
elseif hj=="c" then
x=x-((wx-bx)/2)-bx
rad=(wx-bx)/2
elseif hj=="r" then
x=x-wx
rad=wx-bx
else
print ("hj not set correctly - l, c, r")
end
--vj. n=normal, nb=normal-ybearing, m=middle, mb=middle-ybearing, t=top
if vj=="n" then
y=y
rad2=0
ry=by
elseif vj=="nb" then
y=y-by
rad2=-by
ry=by
elseif vj=="m" then
y=y+((hy-by)/2)
rad2=((hy-by)/2)
ry=((hy-by)/2)-by
elseif vj=="mb" then
y=y+(hy/2)-by
rad2=(hy/2)-by
ry=((hy-by)/2)-by
elseif vj=="t" then
y=y+hy-by
rad2=hy-by
ry=0+by
else
print ("vj not set correctly - n, nb, m, mb, t")
end
--rotation
if ro~=0 then
local point2=(math.pi/180)*(ro-180)
local x2=tx+rad2*(math.sin(point2))
local y2=ty-rad2*(math.cos(point2))
local point=(math.pi/180)*(ro-90)
local x1=x2+rad*(math.sin(point))
local y1=y2-rad*(math.cos(point))
cairo_save (cr)
cairo_translate (cr,x1,y1)
cairo_rotate(cr,(math.pi/180)*ro)
cairo_set_source_rgba (cr,color(c,a))
cairo_show_text (cr,txt)
cairo_stroke (cr)
cairo_restore (cr)
else
cairo_move_to (cr,x,y)
cairo_set_source_rgba (cr,color(c,a))
cairo_show_text (cr,txt)
cairo_stroke (cr)
end--if ro
end--function out ###################################################################
function image(im)--#################################################################
x=nil
x=(im.x or 0)
y=nil
y=(im.y or 0)
w=nil
w=(im.w or default_image_width)
h=nil
h=(im.h or default_image_height)
file=nil
file=tostring(im.file)
if file==nil then print("set image file") end
---------------------------------------------
local show = imlib_load_image(file)
if show == nil then return end
imlib_context_set_image(show)
if tonumber(w)==0 then 
width=imlib_image_get_width() 
else
width=tonumber(w)
end
if tonumber(h)==0 then 
height=imlib_image_get_height() 
else
height=tonumber(h)
end
imlib_context_set_image(show)
local scaled=imlib_create_cropped_scaled_image(0, 0, imlib_image_get_width(), imlib_image_get_height(), width, height)
imlib_free_image()
imlib_context_set_image(scaled)
imlib_render_image_on_drawable(x, y)
imlib_free_image()
show=nil
end--function image ##################################################################
function convert24(tm,suf)
local tmlen=string.len(tm)
local colon=string.find(tm,":")
	if colon~=nil then
	tmhr=string.sub(tm,1,colon-1)
	tmmn=string.sub(tm,colon+1,tmlen)
	else
	tmhr=tm
	tmmn=""
	end
if suf=="PM" and tonumber(tmhr)~=12 then
tmhr=tmhr+12
elseif suf=="PM" and tonumber(tmhr)==12  then
tmhr=12
elseif suf=="AM" and tonumber(tmhr)<10 then
tmhr="0"..tmhr
elseif suf=="AM" and tonumber(tmhr)>=10 and tonumber(tmhr)~=12 then
tmhr=tmhr
elseif suf=="AM" and tonumber(tmhr)==12 then
tmhr="00"
end
if colon~=nil then
return tmhr..":"..tmmn
else
return tmhr
end--if colon~=nil
end--of function
--END OF SCRIPT
