--========================================================--
--                  PAINEL DO RIP GB                     --
--                  LOCAL SCRIPT                         --
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================--
-- CONFIGURAÇÕES
--========================================================--

local SENHA = "PAINEL MODIFICADO DO RIP GB"

local SpeedValue = 16
local FlySpeedValue = 40
local FOVValue = 250
local SpinSpeedValue = 25

local SpeedEnabled = false
local FlyEnabled = false
local SpinEnabled = false
local AimbotEnabled = false

local ESPBoxEnabled = false
local ESPLineEnabled = false
local ESPHealthEnabled = false

local TargetPart = "Head"

--========================================================--
-- GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "RIPGB_PANEL"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local function Round(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 10)
	corner.Parent = obj
end

--========================================================--
-- SENHA
--========================================================--

local PasswordFrame = Instance.new("Frame")
PasswordFrame.Size = UDim2.new(0, 380, 0, 220)
PasswordFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
PasswordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
PasswordFrame.BorderSizePixel = 0
PasswordFrame.Parent = Gui
Round(PasswordFrame, 14)

local PasswordStroke = Instance.new("UIStroke")
PasswordStroke.Color = Color3.fromRGB(180, 30, 30)
PasswordStroke.Thickness = 2
PasswordStroke.Parent = PasswordFrame

local PasswordTitle = Instance.new("TextLabel")
PasswordTitle.Size = UDim2.new(1, 0, 0, 55)
PasswordTitle.BackgroundTransparency = 1
PasswordTitle.Text = "PAINEL DO RIP GB"
PasswordTitle.TextColor3 = Color3.fromRGB(255, 40, 40)
PasswordTitle.TextSize = 25
PasswordTitle.Font = Enum.Font.GothamBold
PasswordTitle.Parent = PasswordFrame

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(1, -50, 0, 45)
PasswordBox.Position = UDim2.new(0, 25, 0, 75)
PasswordBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
PasswordBox.PlaceholderText = "Digite a senha..."
PasswordBox.Text = ""
PasswordBox.TextColor3 = Color3.new(1, 1, 1)
PasswordBox.TextSize = 16
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.ClearTextOnFocus = false
PasswordBox.Parent = PasswordFrame
Round(PasswordBox, 8)

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1, -50, 0, 45)
EnterButton.Position = UDim2.new(0, 25, 0, 135)
EnterButton.BackgroundColor3 = Color3.fromRGB(180, 25, 25)
EnterButton.Text = "ENTRAR"
EnterButton.TextColor3 = Color3.new(1, 1, 1)
EnterButton.TextSize = 17
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = PasswordFrame
Round(EnterButton, 8)

--========================================================--
-- PAINEL PRINCIPAL
--========================================================--

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 620, 0, 440)
Main.Position = UDim2.new(0.5, -310, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui
Round(Main, 14)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(130, 25, 25)
MainStroke.Thickness = 2
MainStroke.Parent = Main

--========================================================--
-- CABEÇALHO
--========================================================--

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
Header.BorderSizePixel = 0
Header.Parent = Main
Round(Header, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PAINEL DO RIP GB"
Title.TextColor3 = Color3.fromRGB(240, 35, 35)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

--========================================================--
-- X
--========================================================--

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 42, 0, 42)
CloseButton.Position = UDim2.new(1, -51, 0, 9)
CloseButton.BackgroundColor3 = Color3.fromRGB(130, 25, 25)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header
Round(CloseButton, 10)

CloseButton.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--========================================================--
-- ABAS
--========================================================--

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(0, 150, 1, -70)
Tabs.Position = UDim2.new(0, 10, 0, 65)
Tabs.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
Tabs.BorderSizePixel = 0
Tabs.Parent = Main
Round(Tabs, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -175, 1, -70)
Content.Position = UDim2.new(0, 165, 0, 65)
Content.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
Content.BorderSizePixel = 0
Content.Parent = Main
Round(Content, 10)

local TabButtons = {}
local Pages = {}

local function CreateTab(name, order)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -20, 0, 48)
	Button.Position = UDim2.new(0, 10, 0, (order - 1) * 58 + 10)
	Button.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	Button.Text = name
	Button.TextColor3 = Color3.fromRGB(220, 220, 220)
	Button.TextSize = 15
	Button.Font = Enum.Font.GothamBold
	Button.Parent = Tabs
	Round(Button, 9)

	local Page = Instance.new("ScrollingFrame")
	Page.Size = UDim2.new(1, -20, 1, -20)
	Page.Position = UDim2.new(0, 10, 0, 10)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.ScrollBarThickness = 4
	Page.CanvasSize = UDim2.new(0, 0, 0, 500)
	Page.Visible = false
	Page.Parent = Content

	TabButtons[name] = Button
	Pages[name] = Page

	return Button, Page
end

local CharacterButton, CharacterPage = CreateTab("PERSONAGEM", 1)
local CombatButton, CombatPage = CreateTab("COMBATE", 2)
local ESPButton, ESPPage = CreateTab("ESP", 3)

local function ShowPage(name)

	for tab, page in pairs(Pages) do
		page.Visible = false
		TabButtons[tab].BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	end

	Pages[name].Visible = true
	TabButtons[name].BackgroundColor3 = Color3.fromRGB(160, 30, 30)
end

CharacterButton.MouseButton1Click:Connect(function()
	ShowPage("PERSONAGEM")
end)

CombatButton.MouseButton1Click:Connect(function()
	ShowPage("COMBATE")
end)

ESPButton.MouseButton1Click:Connect(function()
	ShowPage("ESP")
end)

--========================================================--
-- TOGGLE
--========================================================--

local function CreateToggle(parent, text, y, callback)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -10, 0, 45)
	Button.Position = UDim2.new(0, 5, 0, y)
	Button.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	Button.Text = text .. "  [ OFF ]"
	Button.TextColor3 = Color3.fromRGB(230, 230, 230)
	Button.TextSize = 15
	Button.Font = Enum.Font.GothamBold
	Button.Parent = parent
	Round(Button, 8)

	local Enabled = false

	Button.MouseButton1Click:Connect(function()

		Enabled = not Enabled

		if Enabled then
			Button.Text = text .. "  [ ON ]"
			Button.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
		else
			Button.Text = text .. "  [ OFF ]"
			Button.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
		end

		callback(Enabled)
	end)

	return Button
end

--========================================================--
-- SLIDER
--========================================================--

local function CreateSlider(parent, text, min, max, default, y, callback)

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -10, 0, 25)
	Label.Position = UDim2.new(0, 5, 0, y)
	Label.BackgroundTransparency = 1
	Label.Text = text .. ": " .. tostring(default)
	Label.TextColor3 = Color3.fromRGB(230, 230, 230)
	Label.TextSize = 14
	Label.Font = Enum.Font.GothamBold
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = parent

	local Bar = Instance.new("Frame")
	Bar.Size = UDim2.new(1, -10, 0, 10)
	Bar.Position = UDim2.new(0, 5, 0, y + 30)
	Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
	Bar.BorderSizePixel = 0
	Bar.Parent = parent
	Round(Bar, 6)

	local Fill = Instance.new("Frame")
	Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	Fill.BackgroundColor3 = Color3.fromRGB(190, 30, 30)
	Fill.BorderSizePixel = 0
	Fill.Parent = Bar
	Round(Fill, 6)

	local Dragging = false

	local function SetValue(x)

		local percent = math.clamp(
			(x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
			0,
			1
		)

		local value = math.floor(min + (max - min) * percent)

		Fill.Size = UDim2.new(percent, 0, 1, 0)
		Label.Text = text .. ": " .. tostring(value)

		callback(value)
	end

	Bar.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			SetValue(input.Position.X)
		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			SetValue(input.Position.X)
		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end

	end)
end

--========================================================--
-- PERSONAGEM
--========================================================--

CreateToggle(CharacterPage, "SPEED", 10, function(state)

	SpeedEnabled = state

	local char = Player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if hum then
		hum.WalkSpeed = state and SpeedValue or 16
	end
end)

CreateSlider(CharacterPage, "Velocidade", 16, 100, 16, 70, function(value)

	SpeedValue = value

	if SpeedEnabled then

		local char = Player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		if hum then
			hum.WalkSpeed = value
		end
	end
end)

CreateToggle(CharacterPage, "FLY", 125, function(state)
	FlyEnabled = state
end)

CreateSlider(CharacterPage, "Fly Speed", 10, 100, 40, 185, function(value)
	FlySpeedValue = value
end)

CreateToggle(CharacterPage, "SPIN", 245, function(state)
	SpinEnabled = state
end)

-- BARRA DO SPIN 1-100
CreateSlider(CharacterPage, "Spin Speed", 1, 100, 25, 305, function(value)
	SpinSpeedValue = value
end)

--========================================================--
-- COMBATE
--========================================================--

CreateToggle(CombatPage, "AIMBOT", 10, function(state)
	AimbotEnabled = state
end)

--========================================================--
-- FOV
--========================================================--

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.Size = UDim2.new(0, FOVValue, 0, FOVValue)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.Parent = Gui
Round(FOVCircle, 999)

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(255, 40, 40)
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

CreateToggle(CombatPage, "FOV", 65, function(state)
	FOVCircle.Visible = state
end)

local TargetLabel = Instance.new("TextLabel")
TargetLabel.Size = UDim2.new(1, -10, 0, 30)
TargetLabel.Position = UDim2.new(0, 5, 0, 120)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "ALVO"
TargetLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
TargetLabel.TextSize = 15
TargetLabel.Font = Enum.Font.GothamBold
TargetLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetLabel.Parent = CombatPage

local TargetParts = {
	{"CABEÇA", "Head"},
	{"TORSO", "HumanoidRootPart"},
	{"PÉ", "LeftFoot"}
}

for i, data in ipairs(TargetParts) do

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0, 100, 0, 38)
	Button.Position = UDim2.new(0, (i - 1) * 110, 0, 155)
	Button.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	Button.Text = data[1]
	Button.TextColor3 = Color3.fromRGB(230, 230, 230)
	Button.TextSize = 13
	Button.Font = Enum.Font.GothamBold
	Button.Parent = CombatPage
	Round(Button, 8)

	Button.MouseButton1Click:Connect(function()

		TargetPart = data[2]

		for _, b in ipairs(CombatPage:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
			end
		end

		Button.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	end)
end

CreateSlider(CombatPage, "FOV", 50, 500, 250, 215, function(value)

	FOVValue = value

	FOVCircle.Size = UDim2.new(0, value, 0, value)
end)

--========================================================--
-- ESP
--========================================================--

CreateToggle(ESPPage, "ESP BOX", 10, function(state)
	ESPBoxEnabled = state
end)

CreateToggle(ESPPage, "ESP LINHA", 65, function(state)
	ESPLineEnabled = state
end)

CreateToggle(ESPPage, "BARRA DE VIDA", 120, function(state)
	ESPHealthEnabled = state
end)

--========================================================--
-- ESP SYSTEM
--========================================================--

local ESPObjects = {}

local function RemoveESP(plr)

	if ESPObjects[plr] then

		for _, obj in pairs(ESPObjects[plr]) do

			if typeof(obj) == "Instance" then
				obj:Destroy()
			end

		end

		ESPObjects[plr] = nil
	end
end

local function CreateESP(plr)

	if plr == Player then
		return
	end

	if ESPObjects[plr] then
		return
	end

	ESPObjects[plr] = {}

	local Box = Instance.new("Highlight")
	Box.Name = "RIPGB_ESP"
	Box.FillTransparency = 1
	Box.OutlineColor = Color3.fromRGB(255, 40, 40)
	Box.Enabled = false
	Box.Parent = workspace

	ESPObjects[plr].Box = Box

	local Billboard = Instance.new("BillboardGui")
	Billboard.Size = UDim2.new(0, 100, 0, 20)
	Billboard.StudsOffset = Vector3.new(0, 3, 0)
	Billboard.AlwaysOnTop = true
	Billboard.Enabled = false
	Billboard.Parent = Gui

	local Health = Instance.new("TextLabel")
	Health.Size = UDim2.new(1, 0, 1, 0)
	Health.BackgroundTransparency = 1
	Health.TextColor3 = Color3.fromRGB(80, 255, 80)
	Health.TextSize = 13
	Health.Font = Enum.Font.GothamBold
	Health.Parent = Billboard

	ESPObjects[plr].Billboard = Billboard
	ESPObjects[plr].Health = Health
end

for _, plr in ipairs(Players:GetPlayers()) do
	CreateESP(plr)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

--========================================================--
-- AIMBOT
--========================================================--

local function GetClosestTarget()

	local closest = nil
	local shortest = FOVValue

	for _, plr in ipairs(Players:GetPlayers()) do

		if plr ~= Player and plr.Character then

			local part = plr.Character:FindFirstChild(TargetPart)
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")

			if part and hum and hum.Health > 0 then

				local screenPos, visible =
					Camera:WorldToViewportPoint(part.Position)

				if visible then

					local center = Vector2.new(
						Camera.ViewportSize.X / 2,
						Camera.ViewportSize.Y / 2
					)

					local distance =
						(Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude

					if distance < shortest then
						shortest = distance
						closest = part
					end
				end
			end
		end
	end

	return closest
end

--========================================================--
-- FLY
--========================================================--

local BodyVelocity

local function UpdateFly()

	local char = Player.Character

	if not char then
		return
	end

	local root = char:FindFirstChild("HumanoidRootPart")

	if not root then
		return
	end

	if FlyEnabled then

		if not BodyVelocity then

			BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.MaxForce = Vector3.new(
				100000,
				100000,
				100000
			)

			BodyVelocity.Parent = root
		end

		local direction = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction += Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction -= Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction -= Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction += Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0, 1, 0)
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction -= Vector3.new(0, 1, 0)
		end

		BodyVelocity.Velocity =
			direction * FlySpeedValue

	else

		if BodyVelocity then
			BodyVelocity:Destroy()
			BodyVelocity = nil
		end
	end
end

--========================================================--
-- LOOP
--========================================================--

RunService.RenderStepped:Connect(function(dt)

	-- AIMBOT
	if AimbotEnabled then

		local target = GetClosestTarget()

		if target then

			Camera.CFrame =
				CFrame.new(
					Camera.CFrame.Position,
					target.Position
				)
		end
	end

	-- SPIN
	if SpinEnabled then

		local char = Player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then

			root.CFrame =
				root.CFrame *
				CFrame.Angles(
					0,
					math.rad(SpinSpeedValue * 6) * dt,
					0
				)
		end
	end

	-- FLY
	UpdateFly()

	-- ESP
	for plr, data in pairs(ESPObjects) do

		local char = plr.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if char and hum and root then

			data.Box.Adornee = char
			data.Box.Enabled = ESPBoxEnabled

			data.Billboard.Adornee = root
			data.Billboard.Enabled = ESPHealthEnabled

			if ESPHealthEnabled then

				data.Health.Text =
					"HP: " ..
					math.floor(hum.Health) ..
					" / " ..
					math.floor(hum.MaxHealth)
			end

		else

			data.Box.Enabled = false
			data.Billboard.Enabled = false
		end
	end
end)

--========================================================--
-- BOTÃO FLUTUANTE
--========================================================--

local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 100, 0, 45)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -22)
FloatingButton.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
FloatingButton.Text = "PAINEL"
FloatingButton.TextColor3 = Color3.new(1, 1, 1)
FloatingButton.TextSize = 15
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.Parent = Gui
Round(FloatingButton, 10)

FloatingButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--========================================================--
-- ARRASTAR
--========================================================--

local function MakeDraggable(frame, dragArea)

	local dragging = false
	local dragStart
	local startPos

	dragArea.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then

			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

			local delta = input.Position - dragStart

			frame.Position =
				UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
		end
	end)
end

MakeDraggable(Main, Header)
MakeDraggable(FloatingButton, FloatingButton)

--========================================================--
-- VERIFICAÇÃO DA SENHA
--========================================================--

EnterButton.MouseButton1Click:Connect(function()

	if PasswordBox.Text == SENHA then

		PasswordFrame.Visible = false
		Main.Visible = true

		ShowPage("PERSONAGEM")

	else

		PasswordBox.Text = ""
		PasswordBox.PlaceholderText = "Senha incorreta!"
	end
end)

PasswordBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		EnterButton:Activate()
	end
end)

--========================================================--
-- RESPAWN
--========================================================--

Player.CharacterAdded:Connect(function(char)

	task.wait(0.5)

	local hum = char:FindFirstChildOfClass("Humanoid")

	if hum and SpeedEnabled then
		hum.WalkSpeed = SpeedValue
	end
end)

--========================================================--
-- FIM
--========================================================--