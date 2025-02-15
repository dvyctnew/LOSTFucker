_G.RFZ = 1
_G.HBESIZE = 5
local function handle()
	local plr = game.Players.LocalPlayer
	if game.CoreGui:FindFirstChild("LocalScript") then game.CoreGui:FindFirstChild("LocalScript"):Remove() end
	local fakescript = Instance.new("LocalScript")
	fakescript.Parent = game.CoreGui
	local chamsfolder = Instance.new("Folder")
	chamsfolder.Name = "CHAMS"
	chamsfolder.Parent = fakescript
	_G.SELFESP = false

	local BOX = Instance.new("BillboardGui")
	local Frame = Instance.new("Frame")
	local HealthBG = Instance.new("Frame")
	local Health = Instance.new("Frame")

	BOX.Name = "BOX"
	BOX.Parent = chamsfolder
	BOX.Enabled = false
	BOX.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	BOX.Active = true
	BOX.AlwaysOnTop = true
	BOX.LightInfluence = 1.000
	BOX.Size = UDim2.new(6, 0, 8, 0)

	Frame.Parent = BOX
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(73, 37, 255)
	Frame.BackgroundTransparency = 0.850
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 4
	Frame.Position = UDim2.new(0.5, 0, 0.55, 0)
	Frame.Size = UDim2.new(0.9, 0, 0.8, 0)

	HealthBG.Name = "HealthBG"
	HealthBG.Parent = BOX
	HealthBG.AnchorPoint = Vector2.new(0.5, 0.5)
	HealthBG.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	HealthBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HealthBG.BorderSizePixel = 0
	HealthBG.Position = UDim2.new(0.01, 0, 0.55, 0)
	HealthBG.Size = UDim2.new(0.02, 0, 0.8, 0)

	Health.Name = "Health"
	Health.Parent = HealthBG
	Health.AnchorPoint = Vector2.new(0.5, 1)
	Health.BackgroundColor3 = Color3.fromRGB(0, 255, 17)
	Health.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Health.BorderSizePixel = 0
	Health.Position = UDim2.new(0.5, 0, 1, 0)
	Health.Size = UDim2.new(1, 0, 1, 0)
	Health.ZIndex = 10

	local NAME = Instance.new("BillboardGui")
	local TextLabel = Instance.new("TextLabel")
	local uistroke = Instance.new("UIStroke")

	NAME.Name = "NAME"
	NAME.Parent = chamsfolder
	NAME.Enabled = false
	NAME.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	NAME.Active = true
	NAME.AlwaysOnTop = true
	NAME.ExtentsOffsetWorldSpace = Vector3.new(0, 3, 0)
	NAME.LightInfluence = 1.000
	NAME.Size = UDim2.new(0, 300, 0, 100)

	TextLabel.Parent = NAME
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.5, 0, 0.4, 0)
	TextLabel.Size = UDim2.new(1, 0, 0.1, 0)
	TextLabel.Font = Enum.Font.Gotham
	TextLabel.Text = "USERNAME, TEAM ID, DISTANCE, GUN"
	TextLabel.TextColor3 = Color3.fromRGB(67, 0, 115)
	TextLabel.TextSize = 14.000

	uistroke.Parent = TextLabel
	uistroke.Color = Color3.new(0, 0, 0)
	uistroke.Thickness = 1
	uistroke.Transparency = 0
	uistroke.Enabled = true
	uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

	local function createAddons(chr)
		local root = chr:FindFirstChild("HumanoidRootPart")
		local head =chr:FindFirstChild("Head")
		if not root then return end
		if root:FindFirstChild("BOX") or root:FindFirstChild("NAME") then return end
		local boxTemplate = chamsfolder:FindFirstChild("BOX")
		local nameTemplate = chamsfolder:FindFirstChild("NAME")
		if not boxTemplate or not nameTemplate then return end
		local boxclone = boxTemplate:Clone()
		local nameclone = nameTemplate:Clone()
		boxclone.Parent = root
		nameclone.Parent = root
		boxclone.Enabled = true
		nameclone.Enabled = true
		local o = head:FindFirstChild("OriginalSize")
		o.Value = Vector3.new(_G.HBESIZE,_G.HBESIZE,_G.HBESIZE)
		head.Size = Vector3.new(_G.HBESIZE,_G.HBESIZE,_G.HBESIZE)
		spawn(function()
			while root and root.Parent do
				wait(0.1)
				local localRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				local distance = localRoot and (localRoot.Position - root.Position).Magnitude or 0
				nameclone.TextLabel.Text = "Username: " .. chr.Name .. ", Distance: " .. math.floor(distance)
				local humanoid = chr:FindFirstChild("Humanoid")
				if humanoid then
					local newy = humanoid.Health / humanoid.MaxHealth
					local bg = boxclone:FindFirstChild("HealthBG")
					if bg and bg:FindFirstChild("Health") then
						local hp = bg.Health
						hp.Size = UDim2.new(newy, 0, hp.Size.Y.Scale, hp.Size.Y.Offset)
					end
				end
			end
		end)
	end

	local function addCharacter(chr)
		if chr then
			if chr == plr.Character and not _G.SELFESP then return end
			createAddons(chr)
		end
	end

	for _, chr in ipairs(game.Workspace.Players:GetChildren()) do
		addCharacter(chr)
	end

	game.Workspace.Players.ChildAdded:Connect(addCharacter)
end

while true do
	wait()
	wait(_G.RFZ)
	handle()
end

