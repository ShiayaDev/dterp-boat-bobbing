CreateThread(function()
    -- Start an infinite loop so the script constantly checks the player's state
    while true do

        -- Default wait time to reduce CPU usage when nothing important is happening
        local sleep = 1000

        -- Get the player's ped (character)
        local ped = PlayerPedId()

        -- Check if the player is currently inside ANY vehicle
        if IsPedInAnyVehicle(ped, false) then

            -- Get the vehicle the player is currently in
            local veh = GetVehiclePedIsIn(ped, false)

            -- Check if the vehicle class is a boat (class 14 in GTA/FiveM)
            if GetVehicleClass(veh) == 14 then

                -- Since we are in a boat, check more frequently
                sleep = 200

                -- Make sure the player is the DRIVER of the boat
                if GetPedInVehicleSeat(veh, -1) == ped then

                    -- Check if the engine is currently running
                    local engineOn = GetIsVehicleEngineRunning(veh)

                    -- Check if the player is pressing W (accelerate)
                    local accelerating = IsControlPressed(0, 71)

                    -- Check if the player is steering left (A) or right (D)
                    local steering = IsControlPressed(0, 63) or IsControlPressed(0, 64)

                    -- If engine is OFF and player is NOT accelerating or steering
                    if not engineOn and not accelerating and not steering then
                        -- Freeze the boat in place so it doesn't drift
                        FreezeEntityPosition(veh, true)
                    else
                        -- Otherwise unfreeze the boat so it can move normally
                        FreezeEntityPosition(veh, false)
                    end

                end
            end
        end

        -- Wait the set amount of time before running the loop again
        Wait(sleep)
    end
end)