local detector = script.Parent:WaitForChild("Cam").d

local RS = game:GetService("ReplicatedStorage")
local modules = RS:WaitForChild("Modules")
local camController = require(modules.CameraController)
local camService = require(modules.camService)

camService.new()

local function fuck()
	camController:Disable()
	camService:setCam()
end
local function onclick()
	if not camController.canchange then return end
	fuck()
end

local function init()
	detector.MouseClick:Connect(onclick)
end

init()