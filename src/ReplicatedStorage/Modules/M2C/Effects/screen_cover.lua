return function(): frame
	local cover = Instance.new("ScreenGui")
	cover.Name = "cover_Moon2Cutscene"
	cover.IgnoreGuiInset = true

	local frame = Instance.new("Frame", cover)
	frame.Name = "FadeFrame"
	frame.Size = UDim2.fromScale(1,1)
	frame.BackgroundTransparency = 1
	frame.BackgroundColor3 = Color3.new(0,0,0)

	cover.Parent = game:GetService("Players").LocalPlayer.PlayerGui

	return frame
end