-- Weather system by Melon, V1.0
DynamicWeather = true -- or false for disable
CurrentWeather = 1 -- Basic Weather = EXTRASUNNY
CurrentWeatherName = "Extrasunny" -- Basic weather name

debugprint = true -- Print weather change

WeatherTimer = 0

local EXTRASUNNY = 1
local CLEARING = 2
local CLEAR = 3
local CLOUDS = 4
local SANDSTORM = 5
local OVERCAST = 6
local CLOUDS2 = 7
local CLOUDS3 = 8
local CLOUDS4 = 9
local THUNDER = 10
local CLOUDS5 = 11

function OnPackageStart()
	-- Start the weather system, by Melon's
	if DynamicWeather then

		WeatherTimer = CreateTimer(function()

		NextWeatherStage()

		end, 600000)
	end
end
AddEvent("OnPackageStart", OnPackageStart)

function NextWeatherStage()
	if CurrentWeather == CLEAR or CurrentWeather == CLOUDS or CurrentWeather == EXTRASUNNY or CurrentWeather == 11 then
		local new = math.random(1,2)
		if new == EXTRASUNNY then
			CurrentWeather = CLEARING
		else
			CurrentWeather = OVERCAST
		end
	elseif CurrentWeather == CLEARING or CurrentWeather == OVERCAST or CurrentWeather == CLOUDS4 then
		local new = math.random(1,6)
		if new == EXTRASUNNY then
			if CurrentWeather == CLEARING then CurrentWeather = CLOUDS4 else CurrentWeather = CLOUDS5 end
		elseif new == CLEARING then
			CurrentWeather = CLOUDS
		elseif new == CLEAR then
			CurrentWeather = CLEAR
		elseif new == CLOUDS then
			CurrentWeather = EXTRASUNNY
		elseif new == SANDSTORM then
			CurrentWeather = CLOUDS2
		else
			CurrentWeather = CLOUDS3
		end
	elseif CurrentWeather == THUNDER or CurrentWeather == OVERCAST then
		CurrentWeather = EXTRASUNNY
	elseif CurrentWeather == CLOUDS2 or CurrentWeather == CLOUDS3 then
		CurrentWeather = EXTRASUNNY
	end

	for k, v in pairs(GetAllPlayers()) do
		CallRemoteEvent(v, "setWeatherClient", CurrentWeather)
	end

	FogSystem()
	WeatherStageName()
	
end

function FogSystem()

	if CurrentWeather == OVERCAST or CurrentWeather == THUNDER then
		for k, v in pairs(GetAllPlayers()) do
			CallRemoteEvent(v, "setFogClient", 5.0)
		end
	else
		for k, v in pairs(GetAllPlayers()) do
			CallRemoteEvent(v, "setFogClient", 0.0)
		end
	end

end

function WeatherStageName()

	if CurrentWeather == EXTRASUNNY then
		CurrentWeatherName = "Extrasunny"
	elseif CurrentWeather == CLEARING then
		CurrentWeatherName = "Clearing"
	elseif CurrentWeather == CLEAR then
		CurrentWeatherName = "Clear"
	elseif CurrentWeather == CLOUDS or CurrentWeather == CLOUDS2 or CurrentWeather == CLOUDS3 or CurrentWeather == CLOUDS4 or CurrentWeather == CLOUDS5 then
		CurrentWeatherName = "Clouds"
	elseif CurrentWeather == SANDSTORM then
		CurrentWeatherName = "Sandstorm"
	elseif CurrentWeather == OVERCAST then
		CurrentWeatherName = "Overcast"
	elseif CurrentWeather == THUNDER then
		CurrentWeatherName = "Thunder"
	end

	if debugprint then
		print("[W-S] Nouvelle météo générée: " .. CurrentWeatherName)
	end
end

function OnPlayerSpawn(player)
    -- Synchronize weather with all clients
	CallRemoteEvent(player, "setWeatherClient", CurrentWeather)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

-------------- COMMANDS ------------------

AddCommand("weather", function(player, weather)

	for k, v in pairs(GetAllPlayers()) do
		CallRemoteEvent(v, "setWeatherClient", weather)
	end

	if tonumber(PlayerData[player].admin) < 1 then
        return AddPlayerChat(player, '<span color="#ff2e2e">'.."Insufficient permission"..'</>')
    end

	CurrentWeather = weather

	AddPlayerChat(player, '<span color="#a6ffcd">'.. "You've changed weather." ..'</>')
end)

AddCommand("freezeweather", function(player)

	if tonumber(PlayerData[player].admin) < 1 then
        return AddPlayerChat(player, '<span color="#ff2e2e">'.."Insufficient permission"..'</>')
    end

	PauseTimer(WeatherTimer)

	AddPlayerChat(player, '<span color="#fcffad">'.. "You've freezed weather system" ..'</>')
end)

AddCommand("unfreezeweather", function(player)

	if tonumber(PlayerData[player].admin) < 1 then
        return AddPlayerChat(player, '<span color="#ff2e2e">'.."Permission insuffisante"..'</>')
	end
	
	UnpauseTimer(WeatherTimer)

	AddPlayerChat(player, '<span color="#fcffad">'.."You've unfreezed weather system"..'</>')
end)
