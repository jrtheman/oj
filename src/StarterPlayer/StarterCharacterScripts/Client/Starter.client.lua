local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local Modules = RS:WaitForChild("Modules")
local Player = game.Players.LocalPlayer

local Controls = require(Player.PlayerScripts.PlayerModule):GetControls()
local CameraControl = require(Modules.CameraController)

task.wait()

CameraControl.new()
CameraControl:Enable()
Controls:Disable()

--settings
local cd = 0.25

local function where(shit: number)
	CameraControl:ChangePos(shit)
	CameraControl.canchange = false
end

local function cooldown()
	if CameraControl.canchange == false then
		task.wait(cd)
		CameraControl.canchange = true
	end
end

local function movement(input, ignore)
	if ignore then
		return
	end

	if CameraControl.canchange == false then
		return
	end

	local currentPos = CameraControl:Get()
	if input.KeyCode == Enum.KeyCode.W then
		if currentPos == 1 then
			where(3)
		elseif currentPos == 2 then
			where(1)
		end
	end

	if input.KeyCode == Enum.KeyCode.S then
		if currentPos == 1 then
			where(2)
		elseif currentPos == 3 then
			where(1)
		elseif currentPos >= 4 then
			where(3)
		end
	end
	cooldown()
end

function init()
	UIS.InputBegan:Connect(movement)
end

init()
