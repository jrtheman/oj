local camService = {}
camService.__index = camService

local camera = workspace.CurrentCamera

camService.new = function()
	local self = setmetatable(camService,{})
	
	self.player = workspace:WaitForChild("Player")
	self.folder = self.player.tween
	self.instances = self.player.SecurityPos
	self.index = 1
	self.currentPosition = self.instances.Position1
	self.canChange = false
	
	return self
end

local function enablegui(enable : boolean)
	local player = game.Players.LocalPlayer
	local starterGui = player.PlayerGui
	local cameraGui = starterGui:WaitForChild("camera")
	cameraGui.Enabled = enable
end
local function tweentocam(goal : CFrame)
	local tween = game:GetService("TweenService")
	local info = TweenInfo.new(0.25,Enum.EasingStyle.Sine)
	local t = tween:Create(camera,info,{CFrame = goal})
	return t
end

function camService:setCam()
	local goal = self.folder.tween.CFrame
	local tweencam = tweentocam(goal)
	tweencam:Play()
	
	tweencam.Completed:Connect(function()
		camera.CFrame = self.currentPosition.CFrame
		camService.canChange = true
		enablegui(true)
	end)

end

local function cameraChange()
	local self  = camService
	local nextPos = self.instances:FindFirstChild("Position"..self.index)
	if not nextPos then warn("check name if same name then change it") return end
	camera.CFrame = nextPos.CFrame
end

function camService:changePos(enabled : boolean)
	local numberOfCams = #self.instances:GetChildren()
	if not self.canChange then return end
	
	if enabled then
		if self.index ~= numberOfCams then
			self.index +=1
			cameraChange()
		elseif self.index == numberOfCams then
			self.index = 1
			cameraChange()
		end
	elseif not enabled then
		if self.index > 1 then
			self.index -=1
			cameraChange()
		elseif self.index == 1 then
			self.index = numberOfCams 
			cameraChange()
		end
	end
	print(self.index)
end


function camService:exit()
	enablegui(false)
end

return camService
