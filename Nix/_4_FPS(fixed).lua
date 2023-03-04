---
--Made by ZHEkaZHE#2756
--       Uid - 12189
---
--Updater: xtragenius
---

local function print_fps()
	se.get_convar("r_3dsky"):set_int(0)

	se.get_convar("r_shadows"):set_int(0)

	se.get_convar("cl_csm_static_prop_shadows"):set_int(0)

	se.get_convar("cl_csm_shadows"):set_int(0)

	se.get_convar("cl_csm_world_shadows"):set_int(0)

	se.get_convar("cl_foot_contact_shadows"):set_int(0)

	se.get_convar("cl_csm_viewmodel_shadows"):set_int(0)

	se.get_convar("cl_csm_rope_shadows"):set_int(0)

	se.get_convar("cl_csm_sprite_shadows"):set_int(0)

	se.get_convar("cl_disablefreezecam"):set_int(0)

	se.get_convar("cl_freezecampanel_position_dynamic"):set_int(0)

	se.get_convar("cl_freezecameffects_showholiday"):set_int(0)
end	
client.register_callback("paint", print_fps)	