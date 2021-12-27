

--[[
Core Systems: Not_Lowest
Made for: DOJ:FR Sandy Shore's Roleplay (6258955)

Use of this asset anywhere except will result in takedown of game

]]

GUIService = game:GetService("GuiService")
RunService = game:GetService("RunService")
UIS = game:GetService("UserInputService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
Players = game:GetService("Players")
ContentProvider = game:GetService("ContentProvider")

Player = Players.LocalPlayer

Core = script.Parent

--// Preload

PreloadReplicatedStorage = {
	"Draggable";
	"GuiFunctions";
	"MobileButtonMaker"

} 

PreloadGUI = {
	"CAD",
	"Mobile",
	"Settings"
}

for _,Item in ipairs(PreloadReplicatedStorage) do
	repeat task.wait() until ReplicatedStorage:FindFirstChild(Item)
end
for _,Item in ipairs(PreloadGUI) do
	repeat task.wait() until Core:FindFirstChild(Item)
end

print("Loaded")
Core.Parent = Player.PlayerGui

--==// Modules

GameGuiFunctions = require(ReplicatedStorage.GuiFunctions)
MobileButtonMaker = require(ReplicatedStorage.MobileButtonMaker)

DeviceType = ""

--// Core UI

PCButtons = {Core.CAD,Core.Settings}
MobileButtons = {Core.Mobile}
ConsoleButtons = {}

Open = "None"

--// Inital Setup

function GetPlatform()
	if GUIService:IsTenFootInterface() then
		return "Console"
	elseif UIS.TouchEnabled and not UIS.MouseEnabled then
		return "Mobile"
	else
		return "Desktop"
	end
end
DeviceType = GetPlatform()
print(DeviceType)
--// Main System

if DeviceType == "Desktop" then
	for _,frame in ipairs(PCButtons) do
		frame.Visible = true;
		
		frame.MouseEnter:Connect(function(hover)
			frame.IconButton.StateOverlay.ImageTransparency = 0.9

		end)
		frame.MouseLeave:Connect(function()
			frame.IconButton.StateOverlay.ImageTransparency = 1
		end)
		frame.IconButton.MouseButton1Click:Connect(function()
			if Open == frame.Name then
				Player.PlayerGui[frame.Name].Enabled = false
				Open = "None"
			else
				if Open ~= "None" then
					Player.PlayerGui[Open].Enabled = false
				end
				
				Player.PlayerGui[frame.Name].Enabled = true
				Open = frame.Name
			end
			
		end)

	end
elseif DeviceType == "Mobile" then
	for _,frame in ipairs(MobileButtons) do
		frame.Visible = true
	end
elseif DeviceType == "Console" then
	for _,frame in ipairs(ConsoleButtons) do
		frame.Visible = true
	end
else
	Players.LocalPlayer:Kick("Unknown Device Type, please rejoin")
end

GUIService.MenuOpened:Connect(function(openm)
	GameGuiFunctions.Gui(Core, false)
	
	if Open == "Settings" then
		GameGuiFunctions.Gui(Core.Parent.Settings, false)
		
	end
	if Open == "CAD" then
		GameGuiFunctions.Gui(Core.Parent.CAD, false)
		
	end
	pen = "None"
end)
GUIService.MenuClosed:Connect(function(openm)
	GameGuiFunctions.Gui(Core, true)
end)

Core.Enabled = true