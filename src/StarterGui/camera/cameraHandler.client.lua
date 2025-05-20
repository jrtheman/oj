local replicatedStorage = game:GetService("ReplicatedStorage")
local modules = replicatedStorage:WaitForChild("Modules")
local camController = require(modules.CameraController)
local camService = require(modules.camService)

local player = workspace:WaitForChild("Player")
local cameraPos = player.CameraPosition

local cameraGui = script.Parent
local exitButton = cameraGui:WaitForChild("exit")
local nextButton = cameraGui:WaitForChild("next")
local previousButton = cameraGui:WaitForChild("previous")


local function onExit()
	local cameraPos5 = cameraPos.Position5
	camController:Enable(cameraPos5)
	camController:ChangePos(5)
	camService:exit()
end

local function onNext()
	camService:changePos(true)
end

local function onPrevious()
	camService:changePos(false)
end

local function init()
	exitButton.MouseButton1Click:Connect(onExit)
	nextButton.MouseButton1Click:Connect(onNext)
	previousButton.MouseButton1Click:Connect(onPrevious)
end
init()