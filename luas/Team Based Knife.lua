--[[
	Team Based Skins has many more options -> https://github.com/Zack2kl/Team-Based-Skins/
]]

local GetLocalPlayer, client_exec, gui_GetValue, gui_SetValue, LocalPlayerIndex, PlayerIndexByUserID = entities.GetLocalPlayer, client.Command, gui.GetValue, gui.SetValue, client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID

local Knife_Changer = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_knifechanger", "Knife Changer", false)
local Knife_W = gui.Window("tb_knife", "Knife Changer", 200, 200, 200, 245)
local knife_G = gui.Groupbox(Knife_W, "Team Knife Changer", 16, 16)
local active = gui.Checkbox(knife_G, 'knife_active', 'Active', false)
local knife_ct = gui.Combobox(knife_G, "knife_CT", "CT Knife", 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')
local knife_t = gui.Combobox(knife_G, "knife_T", "T Knife", 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')
local update = gui.Button(knife_G, 'Update', function()
	client_exec('cl_fullupdate', true)
end)

callbacks.Register('Draw', function()
	Knife_W:SetActive(Knife_Changer:GetValue() and gui.Reference("MENU"):IsActive())

	if not active:GetValue() then
		return
	end

	if GetLocalPlayer() == nil then
		return
	end

	if GetLocalPlayer():GetTeamNumber() == 1 then 
		return

	elseif GetLocalPlayer():GetTeamNumber() == 2 then
		if gui_GetValue("skin_knife") ~= knife_t:GetValue() then
			gui_SetValue("skin_knife", knife_t:GetValue())
		end

	elseif GetLocalPlayer():GetTeamNumber() == 3 then
		if gui_GetValue("skin_knife") ~= knife_ct:GetValue() then
			gui_SetValue("skin_knife", knife_ct:GetValue())
		end
	end
end)

client.AllowListener('player_spawn')
callbacks.Register("FireGameEvent", function(e)
	if not active:GetValue() or e:GetName() ~= 'player_spawn' or PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then
		return
	end

	client_exec('cl_fullupdate', true)
end)
