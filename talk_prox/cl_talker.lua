--[[------------------------------------------------------------
    BlockBa5her's voice proximity script
    Protected under the GPL-3 license
    (NOT PUBLIC DOMAIN)
    License information:
        - Always redistribute under the same license
        - Must disclose the source at all times
        - Copyrighted
        - Doesn't include a warranty
        - Changes to the code must be publically announced (unless private use)
------------------------------------------------------------]]--

options = {
    proximity = 6.01 -- The proximity of the player (MAKE SURE IT IS A DECIMAL)
}

--[[-----------------------------------------------------------------
    Don't touch below the line unless you know what you are doing
-----------------------------------------------------------------]]--

options.proximity = options.proximity + 0.01

function start()
    Citizen.CreateThread(function()

        function setProx()
            NetworkSetTalkerProximity(options.proximity)
            TriggerEvent("chatMessage", "SYSTEM", {0,0,0}, string.format("Changing voice proximity to %s meters", math.floor(options.proximity)))
        end
        setProx()
        
        Citizen.Wait(50)
    
        local last = NetworkGetTalkerProximity()



        while true do 
            local now = NetworkGetTalkerProximity()
            if (now ~= last) then
                TriggerEvent("chatMessage", "SYSTEM", {0,0,0}, "Don't try to change your voice proximity!")
                setProx()
                Citizen.Wait(50)
                last = NetworkGetTalkerProximity()
            end
            Citizen.Wait(1000);
        end
    end)
end

Citizen.CreateThread(function()
    while not NetworkIsPlayerConnected(PlayerId()) do
        Citizen.Wait(10)
    end

    start()
end)