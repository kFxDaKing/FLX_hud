ESX = nil
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded  = true
	ESX.PlayerData    = xPlayer

	cash = ESX.PlayerData.money



end)
PlayerData = {}
local boss = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded  = true
    ESX.PlayerData    = xPlayer

    cash = ESX.PlayerData.money

  PlayerData  = xPlayer
  if PlayerData.job.grade_name == 'boss' then
    
    boss = true
  else
    boss = false
  end
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job



  if PlayerData.job.grade_name == 'boss' then
    
    boss = true
  else
    boss = false
  end

end)
function roundxx(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function drawRct2(x,y,width,height,r,g,b,a)
	DrawRect(x + width/4, y + height/1, width, height, r, g, b, a)
end

function drawTxt3(x,y ,width,height,scale, text, r,g,b,a)
        SetTextFont(6)
        SetTextProportional(0)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, a)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(2, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x - width/5.5, y - height/20000)
end

local ShowHUD = true
local cash = 0
local blackcash = 0
RegisterNetEvent("sendWeight")
AddEventHandler("sendWeight", function(mm)
	Weight = mm
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(_, _, _)
	cash = ESX.GetPlayerData().money
end)
RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(_, _)
	cash = ESX.GetPlayerData().money
end)
RegisterNetEvent("showhud:toggle")
AddEventHandler("showhud:toggle", function(m)
	ShowHUD = m
end)
local rdy = true
function ShowHud()
	ShowHUD = not ShowHUD

end
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	rdy = true
end)

local faimVal = 0
local soifVal = 0
Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(5000)
		
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			faimVal = status.val/1000000*100

		end)
		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			soifVal = status.val/1000000*100

		end)
		
	end

end)

HUD = {}
local societyMoney = 0

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)

  if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' and 'society_' .. PlayerData.job.name == society then
    societyMoney = money
  end

end)

Citizen.CreateThread(function()
	hea = 200
	while true do
		Citizen.Wait(0)
		if rdy then
			if ShowHUD then
				local myPed = GetPlayerPed(-1)
				local veh = GetVehiclePedIsIn(myPed,true)
				local health = GetEntityHealth(myPed) - 100
				local armor = GetPedArmour(myPed)
				local vitesse = GetEntitySpeed(veh) * 3.6
				local plate = GetVehicleNumberPlateText(veh)
				if health < 0 then 
					health = GetEntityHealth(myPed)
				end
				local armor = GetPedArmour(myPed)
				drawTxt3(1.010, 0.963, 1.0,1.0,0.40 , "" .."❤️" ,255, 255, 255, 255) 
				drawTxt3(1.031, 0.963, 1.0,1.0,0.50 , "" ..math.ceil(health) .. "", 255, 255, 255, 255)

				drawTxt3(1.049, 0.963, 1.0,1.0,0.40 , "" .."🛡" ,255, 255, 255, 255) 
                drawTxt3(1.068, 0.963, 1.0,1.0,0.50 , "" ..math.ceil(armor).."", 255, 255, 255, 255) 
                
            
		     	drawTxt3(1.087, 0.963, 1.0,1.0,0.40 , "" .."🍔" ,255, 255, 255, 255) 
				drawTxt3(1.108, 0.963, 1.0,1.0,0.50 , "" ..math.ceil(faimVal) .. "", 255, 255, 255, 255) 

				drawTxt3(1.125, 0.963, 1.0,1.0,0.40 , "" .."🥤" ,255, 255, 255, 255) 
				drawTxt3(1.144, 0.963, 1.0,1.0,0.50 , "" ..math.ceil(soifVal) .. "", 255, 255, 255, 255) 

			end
		end
	end
end)


local LastPress = 0
Citizen.CreateThread( function()
	while true do
		Wait( 0 )


        if IsControlPressed( 0, 82 ) then
          if PlayerData.job~= nil then
					drawTxt3(1.249, 1.453, 1.0,1.0,0.40 , PlayerData.job.label .. " - " ..  PlayerData.job.grade_label ,255, 255, 255, 255) 
          end
				end


	end
end )


function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow(0)
	SetTextOutline(0)
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

SendNUIMessage({hud = ShowHUD})