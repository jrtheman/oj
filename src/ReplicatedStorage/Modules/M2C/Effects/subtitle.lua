local subtitlesUi = script.Subtitles
return function(text:string, properties:{})
	subtitlesUi.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	
	if text then
		for i,v in properties or {} do
			subtitlesUi.Subtitles[i] = v
		end

		subtitlesUi.Subtitles.Text = text
	end

	return subtitlesUi.Subtitles
end