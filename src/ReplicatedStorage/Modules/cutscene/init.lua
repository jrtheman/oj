
local cutscene = {}

local RS = game:GetService("ReplicatedStorage")
local Run = game:GetService("RunService")

local tween = game:GetService("TweenService")
local Modules = RS:WaitForChild("Modules")
local Cutscenes = RS:WaitForChild("Cutscenes")
local M2C = require(Modules.M2C)

local camera = workspace.CurrentCamera
local folder = workspace:WaitForChild("Cutscene")

local function tweentocam(part)
	local info = TweenInfo.new(.2,Enum.EasingStyle.Sine)
	local t = tween:Create(camera,info,{CFrame = part.CFrame})
	
	return t
end

local function invisoff(so:Model, enable : number)
	if not so then return end
	for _, parts in pairs(so:GetDescendants()) do
		if parts:IsA("BasePart") then
			parts.Transparency = enable
		end
	end
end

cutscene.door = function(yeah : string)
	if not yeah then return end

	local newcut = M2C.new(Cutscenes["Door"..yeah])
	newcut:play()
	task.wait()
	local t = tweentocam(folder.Viewmodel.CameraBone)
	t:Play()

	local data = require(script["data"..yeah])
	for _,v in pairs(data) do
		newcut.task:register(_,function()
			if v.Sounds then
				for _, sounds in pairs (v.Sounds) do
					if sounds:IsA("Sound") then
						sounds:Play()
					end
				end
			end
		end)
	end

	invisoff(folder.Viewmodel,0)
	local connection
	t.Completed:Connect(function()
		connection = Run.RenderStepped:Connect(function()
			camera.CFrame = folder.Viewmodel.CameraBone.CFrame
		end)
	end)


	newcut.task:onEnd(function()
		invisoff(folder.Viewmodel,1)
		if connection ~= nil then
			connection:Disconnect()
			
		end
		
		--newcut:reset()
	end)

	return newcut
end
return cutscene
