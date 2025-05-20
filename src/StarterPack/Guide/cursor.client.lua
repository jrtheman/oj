local UIS = game:GetService("UserInputService")

local R = game:GetService("RunService")
local RS = game:GetService("ReplicatedStorage")
local modules = RS:WaitForChild("Modules")
local camcontrol = require(modules.CameraController)

local mouse = game.Players.LocalPlayer:GetMouse()
local detectors = workspace:WaitForChild("Map").Detectors
local function guide()
	local get = camcontrol:Get()
	if get == 3 or get == 4 then
		if mouse.Target == detectors.Camera or mouse.Target == detectors.Door then
			UIS.MouseIcon = "rbxassetid://16983414920"
		else
			UIS.MouseIcon = "rbxassetid://0"
		end
	else
		UIS.MouseIcon = "rbxassetid://0"
	end
end

local function init()
	R.RenderStepped:Connect(guide)
end

init()