--Rasenmähen--

	ESX              = nil
	local PlayerData = {}

	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)

	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer   
	end)

	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end)

	-- Enter / Exit marker events
	Citizen.CreateThread(function()
		while true do

			Citizen.Wait(100)

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('rasen:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('rasen:hasExitedMarker', LastZone)
			end
		end
	end)

	-- Key Controls
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if CurrentAction then

				if IsControlJustReleased(0, 38) then
					if CurrentAction == 'menu' then
						openmenu()
					end

					CurrentAction = nil
				end
			else
				Citizen.Wait(500)
			end
		end
	end)

	AddEventHandler('rasen:hasEnteredMarker', function(zone)
		if zone == 'rasen' then
			CurrentAction     = 'menu'
			CurrentActionData = {}
		end
	end)

	AddEventHandler('rasen:hasExitedMarker', function(zone)
		CurrentAction = nil
		ESX.UI.Menu.CloseAll()
	end)

	local startCount = false
	local isPedDriven = false
	local points = 0
	local veh = nil

	function openmenu()
		local elements = {}

		table.insert(elements, {
			label = "Starten",
			value = "starten"
		})

		table.insert(elements, {
			label = "Verkaufen",
			value = "verkaufen"
		})

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
			title    = "Rasenmähen",
			elements = elements,
			align    = 'top-left'
		}, function(data, menu)
			if data.current.value == 'starten' then
				points = 0
				menu.close()
				if startCount == true then
					ESX.ShowNotification("~r~Du bist bereits am Rasenmähen")
				else 
					start()
					ESX.ShowNotification("~g~Viel Spaß beim Rasenmähen")
				end
			elseif data.current.value == 'verkaufen' then
				menu.close()
				if points > 0 and startCount == true then
					TriggerServerEvent("rasen:pay", points)
					ESX.Game.DeleteVehicle(veh)
					startCount = false
					ESX.ShowNotification("~g~Vielen Dank. Du hast $" .. points * 10 .. " bekommen für's mähen.")
				else
					ESX.ShowNotification("~r~Du bist noch nicht genug gefahren")
				end
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'menu'
			CurrentActionData = {}
		end)
	end

	function start()
		local playerId = PlayerPedId()
		ESX.Game.SpawnVehicle('mower', vector3(-938.26, 330.35, 70.88), 279.86, function(vehicle)
			veh = vehicle
			SetPedIntoVehicle(playerId, vehicle, -1)
		end)

		startCount = true
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10000)
			if startCount and isPedDriven then
				points = points + 1
				ESX.ShowNotification("~g~Rasen gemäht. (" .. points .. ")")
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey("mower")) then
				local speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6
				if speed > 5 then
					isPedDriven = true
				else
					isPedDriven = false
				end
			end
		end
	end)

	local blips = {
		{title="Rasenmahen", colour=2, id=280, x = -949.08, y = 332.99, z = 71.33},
	}
		
	Citizen.CreateThread(function()

		for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
		end
	end)

--Rasenmähen--
--vendingm--
	ESX = nil


	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)


	
	cachedData = {}


	local l_37 = 0
	local l_3B = 0.306;
	local l_3C = 0.31;
	local l_3D = 0.98;
	local l_45 = {0.0, -0.97, 0.05 }
	local name = "Soda"

	Citizen.CreateThread(function()
		RegisterNetEvent('vending_machines:drink', function()
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local sprunk = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_vend_soda_02"), false)
			local ecola = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_vend_soda_01"), false)


			if DoesEntityExist(sprunk) or DoesEntityExist(ecola) then
				sleepThread = 5
				local markerCoords = GetOffsetFromEntityInWorldCoords(sprunk, 0.0, -0.97, 0.05)
				local distanceCheck1 = #(pedCoords - markerCoords)
				local markerCoords2 = GetOffsetFromEntityInWorldCoords(ecola, 0.0, -0.97, 0.05)
				local distanceCheck2 = #(pedCoords - markerCoords2)
				if distanceCheck1 <= 0.5 then
					PurchaseDrink(markerCoords,sprunk)
				elseif distanceCheck2 <= 0.5 then
					PurchaseDrink(markerCoords2,ecola)
				end
			end

			Citizen.Wait(sleepThread)
		end)
	end)


	PurchaseDrink = function(coords,maquina)
		ESX.TriggerServerCallback("vending_machines:validatepurchase", function(validated)
			if validated then
				EjecutarAnim(coords,maquina)
			else
			ESX.ShowNotification(Config.nomoney)
			end
		end)
	end

	requestDict = function(dict)
		while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
		return dict
	end
	function EjecutarAnim(CoordsMaquina,maquina)
		if GetHashKey("prop_vend_soda_02") == GetEntityModel(maquina) then
			prop = "prop_ld_can_01b"
		elseif GetHashKey("prop_vend_soda_01") == GetEntityModel(maquina) then
			prop = "prop_ecola_can"
		end
		RequestAmbientAudioBank("VENDING_MACHINE", 0)
		if GetFollowPedCamViewMode() == 4 then
			DicAnim = requestDict("mini@sprunk@first_person")
		else
			DicAnim = requestDict("mini@sprunk")
		end
		local taks TaskGoStraightToCoord(PlayerPedId(), CoordsMaquina, 1.0, 20000, GetEntityHeading(maquina), 0.1)
		Citizen.Wait(1000)
		while GetIsTaskActive(PlayerPedId(),task) do Citizen.Wait(1); end
		if IsEntityAtCoord(PlayerPedId(), CoordsMaquina, 0.1, 0.1, 0.1, 0, 1, 0) then
			local taks2 = TaskLookAtEntity(PlayerPedId(), maquina, 2000, 2048, 2);
			Citizen.Wait(1000)
			while GetIsTaskActive(PlayerPedId(),task2) do Citizen.Wait(1); end
			TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0);
			FreezeEntityPosition(PlayerPedId(),true)
		end
		while true do
			Citizen.Wait(1)
			
				if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
					if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") < 0.52) then
						if (not IsEntityAtCoord(PlayerPedId(), CoordsMaquina, 0.1, 0.1, 0.1, 0, 1, 0)) then
							sub_35e89(1);
						end
					end
					if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
						if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > l_3C) then
							if (DoesEntityExist(l_37)) then
								if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > l_3D) then
									if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
										TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0);
										TaskClearLookAt(PlayerPedId(), 0, 0);
									end
									if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
										StopAnimTask(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", -1.5);
									end
								end
							else
								l_37 = CreateObjectNoOffset(GetHashKey(prop), CoordsMaquina, 1, 0, 0);
								AttachEntityToEntity(l_37, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1);
							end
						end
					end
				elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
					if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2") > 0.98) then
						if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
							TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 1000.0, -4.0, -1, 0x100030, 0.0, 0, 2048, 0);
							--UltimaFuncion()
							TaskClearLookAt(PlayerPedId(), 0, 0);
							TriggerEvent("esx_status:add", "thirst", 200000)
						end
						
					end
				elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
					if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3") > l_3B) then
						
						if (RequestAmbientAudioBank("VENDING_MACHINE", 0)) then
							ReleaseAmbientAudioBank();
						end
						HintAmbientAudioBank("VENDING_MACHINE", 0);
						sub_35e89(1);
						break
					end
				end
		end
	end


	function sub_35e89(a_0) 
		if (DoesEntityExist(l_37)) then
			if (IsEntityAttached(l_37)) then
				DetachEntity(l_37, 1, 1)
				if (a_0) then
					ApplyForceToEntity(l_37, 1, 6.0, 10.0, 2.0, 0.0, 0.0, 0.0, 0, 1, 1, 0, 0, 1)
				end
			end
			FreezeEntityPosition(PlayerPedId(),false)
			SetObjectAsNoLongerNeeded(l_37)
			DeleteObject(l_37)
			l_37 = nil
		end
	end


	CreateThread(function()
		local mashina = {
			GetHashKey('prop_vend_soda_02'),
			GetHashKey('prop_vend_soda_01'),
		}
		exports[Config.Target]:AddTargetModel(mashina, {
			options = {
				{
					event = "vending_machines:drink",
					icon = "fas fa-money-bill-wave-alt",
					label = Config.lable,
				},
			},
			job = {"all"},
			distance = 0.8
		}) 
	end)
--vendingm--
--antiwaffenschlag--

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local ped = GetPlayerPed( -1 )
			local weapon = GetSelectedPedWeapon(ped)
			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
		end
	end)

	function ShowNotification(text)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(text)
		DrawNotification(false, false)
	end

--antiwaffenschlag--