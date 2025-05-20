
local CameraController = {}
CameraController.__index = CameraController
--

local RS = game:GetService("RunService")
local R = game:GetService("ReplicatedStorage")

local Remotes = R:WaitForChild("Remotes")
local PS = game:GetService("Players")
local Tween = game:GetService("TweenService")

local Info = TweenInfo.new(0.2,Enum.EasingStyle.Sine)
--
local player = PS.LocalPlayer
local mouse = player:GetMouse()
local cam = workspace.CurrentCamera

local WorkspaceUtilities = workspace.Player:WaitForChild("CameraPosition")
local CameraPart = WorkspaceUtilities:FindFirstChild("Position1")
--
local CAMERA_RENDER_KEY = "Render Camera"


function CameraController.new()
	local self = setmetatable(CameraController,{})
	
	self.pivotPoint = CameraPart
	self.currentpos = 1
	self.tw = nil
	self.canchange = true
	
	return self
end

function CameraController:Enable(shit)
	cam.CameraType = Enum.CameraType.Scriptable
	cam.CameraSubject = nil
	cam.FieldOfView = 70
	
	self.canchange = true
	if self.pivotPoint ~= nil then
		cam.CFrame = self.pivotPoint.CFrame
	end
	
	if shit then
		cam.CFrame = shit.CFrame 
	end
	
	local function RenderCamera()
		if not self.pivotPoint then return end
		local centerPos, mousePos = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2), Vector2.new(mouse.X, mouse.Y)
		local xDist, yDist = mousePos.X - centerPos.X, mousePos.Y - centerPos.Y

		local xRot, yRot = math.rad(yDist), math.rad(xDist)
		xRot, yRot = xRot/(cam.ViewportSize.X * 0.01), yRot/(cam.ViewportSize.Y * 0.01)
		xRot, yRot = math.clamp(xRot, math.rad(-90), math.rad(90)), math.clamp(yRot, math.rad(-60), math.rad(60))

		xRot, yRot = -xRot, -yRot

		local t = Tween:Create(cam,Info,{CFrame = self.pivotPoint.CFrame * CFrame.Angles(xRot, yRot, 0)})
		t:Play()
		self.tw = t
		--cam.CFrame = self.pivotPoint * CFrame.Angles(xRot, yRot, 0)
	end
	
	RS:BindToRenderStep(CAMERA_RENDER_KEY, Enum.RenderPriority.Camera.Value, RenderCamera)
end

function CameraController:ChangePos(Pos : number)
	if not Pos then return end
	
	local Position = WorkspaceUtilities:FindFirstChild("Position"..Pos)
	if Position then
		if self.canchange == true then
			self.pivotPoint = Position
			self.currentpos = Pos
		else
			warn("cant")
		end
	end
end

function CameraController:Get()
	if not self.currentpos then return end
	return self.currentpos
end

function CameraController:Disable()
	if self.tw ~= nil then
		self.tw:Cancel()
		self.canchange = false
		RS:UnbindFromRenderStep(CAMERA_RENDER_KEY)
	end
end

return CameraController
