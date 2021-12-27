RunService = game:GetService("RunService")
Players = game:GetService("Players")

if RunService:IsClient() then
	local Player = Players.LocalPlayer
	GUIsHidden = {}
	
	local GUI = {}
	GUI.__index = GUI
	
	GUI.Gui = function(gui: userdata,Enabled: bool)
		if gui:IsA("ScreenGui") then
			if Enabled == false then
				table.insert(GUIsHidden,gui)
				gui.Enabled = false
			else
				local TableNumber = table.find(GUIsHidden,gui)
				gui.Enabled = true
				table.remove(GUIsHidden,TableNumber)
			end
		end
	end

	GUI.HideAllGuis = function(Exclusions: table)
		for _,gui in ipairs(Player.PlayerGui:GetChildren()) do
			if not table.find(Exclusions,gui.Name) then
				if gui.Enabled == true then
					GUI.Gui(gui,false)

				end
			end
		end
	end
	GUI.ShowAllGuis = function(Exclusions: table)
		for _,gui in ipairs(GUIsHidden) do
			if not table.find(Exclusions,gui.Name) then
				if gui.Enabled == false then
					print(gui)
					GUI.Gui(gui,true)
				end
			end
		end
	end
	
	
	return GUI
end

return {}