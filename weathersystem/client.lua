--- WEATHER SYSTEM -- 
function setWeatherClient(weather)
	SetWeather(weather)
end
AddRemoteEvent("setWeatherClient", setWeatherClient)

function setFogClient(density)
	SetFogDensity(density)
end
AddRemoteEvent("setFogClient", setFogClient)