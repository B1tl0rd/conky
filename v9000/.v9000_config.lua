--SETTINGS AND PREFERENCES--SETTINGS AND PREFERENCES--SETTINGS AND PREFERENCES
function weather_settings()--#### DO NOT EDIT THIS LINE #################
--#######################################################################
--[[set update interval.  update interval is based on conky cycles
if your conkyrc has an update_interval of 1, ie updates every second
then if you enter 60 below, the script will update every 60 seconds
however, if your conkyrc update_interval is 10, then by setting 60 below,
v9000 will update every 600 seconds (10 minutes)]]
local update_interval=1800 --avoid an interval of 1
--get web address by going to the intellicast site and entering your location in the box
--click on "Extended Forecast" to get the necessary address
local web="http://www.intellicast.com/Local/Forecast.aspx?unit=F&location=USOK0537"--insert unit=C& after aspx? for C
--set location of weather images (replace "benjamin" with your own username)
local weathericons="/home/chris/.conky/v9000/additional_files/weathericons/"
--short conditions setup
--this section allows you to set your own shorter terms to replace the terms foud in conditions
--to use for current: now["conditions_short"], now["conditions_short_caps"], now["conditions_short_lc"]
--to use for forecast: conditions_short[n], conditions_short_caps[n], conditions_short_lc[n]
--ALSO USE THIS TABLE TO ENTER CONDITIONS TRANSLATIONS
con_short={--start of table, put entries below in form eg: ["Thunderstorm"]="T.Strm",
["Wind Early"]="Wnd AM",
["Snow Showers"]="Sn Shws",
["Thunderstorm"]="T.Strm",--remember to put a comma at the end of every entry
["Scattered"]="Scat",
["Few Snow Showers"]="Fw Sn Shws",
["Wind"]="Wnd",
["Showers"]="Shws",
}--this bracket closes the table
--the script is capable of converting between several unit types
--set how many decimal places you want the conversions to show
local decimal_places=1
--some weather data options need to come with their own units attached as they can be NA on occasion
--set here what you want to have for units, or set "" for nothing
--include spaces, if desired, for formatting purposes. 
--NOTE ALSO EDIT THESE SETTINGS FOR TRANSLATION PURPOSES
local visibility_unit=" mi"
local wind_mph_unit=" mph"
local wind_km_unit=" kmh"
local wind_kts_unit=" kts"
local ceiling_unit=" ft"
local wind_degrees_unit="°"
--do you want the script to use translation tables?
--set 1 if you want to translate, 0 if not.
--the translation tables are located below
local translate=0
--set alerts on or off, set to 0 so that the script does not check for alerts
--set 1 to check for alerts
local alert_check=1
--#######################################################################
--TRANSLATION TABLES, activate by setting translate=1 above
--use con_short table above to translate weather conditions
--edit units settings above to complete translation
--translate NESW text
neswtext={
S="t_S",
SSW="tsetSSW",
SW="t_SW",
WSW="t_WSW",
W="t_W",
WNW="t_WNW",
NW="t_NW",
NNW="t_NNW",
N="t_N",
NNE="t_NNE",
NE="t_NE",
ENE="t_ENE",
E="t_E",
ESE="t_ESE",
SE="t_SE",
SSE="t_SSE",
}--end of  N E S W text table
--translate time suffix
tsuffix={
AM="t_AM",
PM="t_PM",
}--end of time suffix table
--enter translations for uv index text
uvindextext={
["Low"]="t_Low",
["Moderate"]="t_Moderate",
["High"]="t_High",
["Very High"]="t_Very High",--format is different because of the space in the text
["Extreme"]="t_Extreme",
}--end of uv text table
--enter translations for moonpahse
moonphases={
["New"]="t_New",
["Full"]="t_Full",
["First Quarter"]="t_First Quarter",
["Last Quarter"]="t_Last Quarter",
["Waning Gibbous"]="t_Waning Gibbous",
["Waning Crescent"]="t_Waning Crescent",
["Waxing Crescent"]="t_Waxing Crescent",
["Waxing Gibbous"]="t_Waxing Gibbous",
}--end of moon phase table
--enter translations for FULL day names
daynames={
Monday="t_Monday",
Tuesday="t_Tuesday",
Wednesday="t_Wednesday",
Thursday="t_Thursday",
Friday="t_Friday",
Saturday="t_Saturday",
Sunday="t_Sunday",
}--end day names table
--enter translations for SHORT day names
dayshort={
Monday="t_Mon",
Tuesday="t_Tue",
Wednesday="t_Wed",
Thursday="t_Thu",
Friday="t_Fri",
Saturday="t_Sat",
Sunday="t_Sun"
}--end short day names table
--enter translation for FULL month names
monthnames={
January="t_January",
February="t_February",
March="t_March",
April="t_April",
May="t_May",
June="t_June",
July="t_July",
August="t_August",
September="t_September",
October="t_October",
November="t_November",
December="t_December"
}--end of month name translations
--enter translations for SHORT month names
monthshort={
January="t_Jan",
February="t_Feb",
March="t_Mar",
April="t_Apr",
May="t_May",
June="t_Jun",
July="t_Jul",
August="t_Aug",
September="t_Sep",
October="t_Oct",
November="t_Nov",
December="t_Dec"
}--end of short month name translations
--enter some additional translations
additional={
NA="t_NA",
Unl="t_Unl"--for ceiling data option
}--end of additional translations
--END OF TRANSLATION TABLES
--#######################################################################
--NOTE if you make changes to these settings, they will only take effect at the next weather update
--or after killall conky and restart
--#######################################################################
if translate==1 then
return {update_interval,web,weathericons,con_short,decimal_places,visibility_unit,wind_mph_unit,wind_km_unit,wind_kts_unit,ceiling_unit,wind_degrees_unit,translate,alert_check,neswtext,tsuffix,uvindextext,moonphases,daynames,dayshort,monthnames,monthshort,additional}
else
return {update_interval,web,weathericons,con_short,decimal_places,visibility_unit,wind_mph_unit,wind_km_unit,wind_kts_unit,ceiling_unit,wind_degrees_unit,translate,alert_check}
end
end--OF SETTINGS AND PREFERENCES ########################################
--#######################################################################


