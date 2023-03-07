local Enable_Letal = ui.add_check_box("letal damage", "check_let", false)
local onLethalValue = ui.add_slider_int("Lethal_BAIM", "xxx", 0, 100, 50)


client.register_callback("create_move", function( pCmd )

    if Enable_Letal:get_value() == true then
        onLethalValue:set_visible(true)
    else
        onLethalValue:set_visible(false)
    end

    local players = entitylist.get_players(0)
    local SCAN_HEAD = 0
    for i = 1, #players do
        local player = players[i]
		
		local damage = player:get_prop_int(se.get_netvar('DT_BasePlayer', 'm_iHealth')) <= onLethalValue:get_value() and player:is_alive()
	    if	damage then
            ragebot.override_hitscan(player:get_index() ,SCAN_HEAD, false)
	    else
            ragebot.override_hitscan(player:get_index() ,SCAN_HEAD,true)
	    end
    end
end)