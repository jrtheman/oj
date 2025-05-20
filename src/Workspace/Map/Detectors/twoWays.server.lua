local detector = script.Parent
local doordetector = detector:WaitForChild("Door",100).ClickDetector
local camdetector = detector:WaitForChild("Camera",100).ClickDetector

local RS = game:GetService("ReplicatedStorage")
local Modules = RS:WaitForChild("Modules")
local cutscene = require(Modules.cutscene)
local CamController = require(Modules.CameraController)

local opened = false
local boolen = false
local cd = 0.5


local function convenience(name : string,open : boolean)
	boolen = true
	opened = open
	CamController:Disable()
	
	local new = cutscene.door(name)

	new.task:onEnd(function()
		local c = workspace:WaitForChild("Cutscene")
		local Camerabone = c.Viewmodel.CameraBone
		
		CamController:Enable(Camerabone)
		CamController:ChangePos(4)
		boolen = false
	end)
end

local function where(num : number)
	CamController:ChangePos(num)
	CamController.canchange = false
end

local function cooldown()
	if CamController.canchange == false and boolen == false then
		task.wait(cd)
		CamController.canchange = true
	end
end

local function door()
	local get = CamController:Get()
	if CamController.canchange == false then return end
	if get == 3 then 
			where(4)
	elseif get == 4 then 
		if opened == false and boolen == false then
			convenience("Open",true)
		else
			if boolen == false then
			convenience("Close",false)
			end
		end
	end
	cooldown()
end

local function cam()
	local get = CamController:Get()
	if CamController.canchange == false then return end
	if get == 5 then return end
	if get == 3 or get == 4 then 
		where(5)
	end
	cooldown()
end



local function init()
	doordetector.MouseClick:Connect(door)
	camdetector.MouseClick:Connect(cam)
end

init()