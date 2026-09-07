--//==================================================
--// PAINEL DO RIP GB
--// LocalScript - Roblox Studio
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
--// REMOVE CÓPIA ANTERIOR
--==================================================

local OldGui = PlayerGui:FindFirstChild("RIPGB_PANEL")

if OldGui then
    OldGui:Destroy()
end

--==================================================
--// SENHAS
--==================================================

local SENHAS = {
    ["RIPGB-7K2M"] = true,
    ["RIPGB-9Q4X"] = true,
    ["RIPGB-3T8P"] = true,
    ["RIPGB-6N5V"] = true,
    ["RIPGB-2H9R"] = true,
    ["RIPGB-8W3L"] = true,
    ["RIPGB-4F7Z"] = true,
    ["RIPGB-5C2J"] = true,
    ["RIPGB-1M8K"] = true,
    ["RIPGB-0X6Q"] = true,
    ["RIPGB-A7P3"] = true,
    ["RIPGB-B9L5"] = true,
    ["RIPGB-C4N8"] = true,
    ["RIPGB-D2V6"] = true,
    ["RIPGB-E8R1"] = true,
    ["RIPGB-F5K9"] = true,
    ["RIPGB-G3T7"] = true,
    ["RIPGB-H6M2"] = true,
    ["RIPGB-J9Q4"] = true,
    ["RIPGB-K1W8"] = true,
    ["RIPGB-L5X3"] = true,
    ["RIPGB-M7C9"] = true,
    ["RIPGB-N2F6"] = true,
    ["RIPGB-P8H4"] = true,
    ["RIPGB-Q3V7"] = true,
    ["RIPGB-R6Z1"] = true,
    ["RIPGB-S9K5"] = true,
    ["RIPGB-T4M8"] = true,
    ["RIPGB-V2L6"] = true,
    ["RIPGB-W7P3"] = true,
    ["RIPGB-X5N9"] = true,
    ["RIPGB-Y1C4"] = true,
    ["RIPGB-Z8F2"] = true,
    ["RIPGB-3H6K"] = true,
    ["RIPGB-9J2M"] = true,
    ["RIPGB-4Q7R"] = true,
    ["RIPGB-6V1X"] = true,
    ["RIPGB-8L5T"] = true,
    ["RIPGB-2P9W"] = true,
    ["RIPGB-7C3Z"] = true,
    ["RIPGB-5M8F"] = true,
    ["RIPGB-1R6H"] = true,
    ["RIPGB-9X4K"] = true,
    ["RIPGB-3N7Q"] = true,
    ["RIPGB-6T2V"] = true,
    ["RIPGB-8Z5L"] = true,
    ["RIPGB-4W1P"] = true,
    ["RIPGB-7F9C"] = true,
    ["RIPGB-2K6M"] = true,
    ["RIPGB-5Q8X"] = true,
}

--==================================================
--// VARIÁVEIS
--==================================================

local SpeedEnabled = false
local SpeedValue = 16

local FlyEnabled = false
local SpinEnabled = false
local SpinSpeed = 10

local NoClipEnabled = false

local AimbotEnabled = false
local FOVEnabled = false
local FOVRadius = 120
local AimPart = "Head"

local ESPBoxEnabled = false
local ESPHealthEnabled = false

local FlyVelocity
local SpinConnection

--==================================================
--// GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "RIPGB_PANEL"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--==================================================
--// FUNÇÕES VISUAIS
--==================================================

local function Round(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Object
end

local function Stroke(Object)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Transparency = 0.25
    UIStroke.Parent = Object
end

--==================================================
--// TELA DE SENHA
--==================================================

local PasswordFrame = Instance.new("Frame")
PasswordFrame.Size = UDim2.new(0, 380, 0, 230)
PasswordFrame.Position = UDim2.new(0.5, -190, 0.5, -115)
PasswordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PasswordFrame.Parent = Gui

Round(PasswordFrame, 15)
Stroke(PasswordFrame)

local PasswordTitle = Instance.new("TextLabel")
PasswordTitle.Size = UDim2.new(1, 0, 0, 55)
PasswordTitle.BackgroundTransparency = 1
PasswordTitle.Text = "PAINEL DO RIP GB"
PasswordTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
PasswordTitle.TextScaled = true
PasswordTitle.Font = Enum.Font.GothamBold
PasswordTitle.Parent = PasswordFrame

local PasswordSub = Instance.new("TextLabel")
PasswordSub.Size = UDim2.new(1, -30, 0, 30)
PasswordSub.Position = UDim2.new(0, 15, 0, 55)
PasswordSub.BackgroundTransparency = 1
PasswordSub.Text = "Digite sua senha para continuar"
PasswordSub.TextColor3 = Color3.fromRGB(220, 220, 220)
PasswordSub.TextScaled = true
PasswordSub.Font = Enum.Font.Gotham
PasswordSub.Parent = PasswordFrame

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(1, -50, 0, 45)
PasswordBox.Position = UDim2.new(0, 25, 0, 95)
PasswordBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PasswordBox.PlaceholderText = "Digite a senha..."
PasswordBox.Text = ""
PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
PasswordBox.TextScaled = true
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.ClearTextOnFocus = false
PasswordBox.Parent = PasswordFrame

Round(PasswordBox, 10)

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1, -50, 0, 45)
EnterButton.Position = UDim2.new(0, 25, 0, 155)
EnterButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
EnterButton.Text = "ENTRAR"
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterButton.TextScaled = true
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = PasswordFrame

Round(EnterButton, 10)

--==================================================
--// PAINEL PRINCIPAL
--==================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 430)
Main.Position = UDim2.new(0.5, -325, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.Visible = false
Main.Parent = Gui

Round(Main, 15)
Stroke(Main)

--==================================================
--// TÍTULO
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 55)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PAINEL DO RIP GB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

--==================================================
--// BOTÃO FECHAR
--==================================================

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -48, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Main

Round(CloseButton, 10)

--==================================================
--// ÁREA DAS ABAS
--==================================================

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(0, 145, 1, -70)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Tabs.Parent = Main

Round(Tabs, 12)

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -170, 1, -70)
Pages.Position = UDim2.new(0, 160, 0, 60)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

--==================================================
--// PÁGINAS
--==================================================

local PersonagemPage = Instance.new("Frame")
PersonagemPage.Size = UDim2.new(1, 0, 1, 0)
PersonagemPage.BackgroundTransparency = 1
PersonagemPage.Visible = true
PersonagemPage.Parent = Pages

local CombatePage = Instance.new("Frame")
CombatePage.Size = UDim2.new(1, 0, 1, 0)
CombatePage.BackgroundTransparency = 1
CombatePage.Visible = false
CombatePage.Parent = Pages

local ESPPage = Instance.new("Frame")
ESPPage.Size = UDim2.new(1, 0, 1, 0)
ESPPage.BackgroundTransparency = 1
ESPPage.Visible = false
ESPPage.Parent = Pages

local function CreateTab(Text, Position)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 50)
    Button.Position = Position
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = Text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.Parent = Tabs

    Round(Button, 10)

    return Button
end

local PersonagemTab = CreateTab(
    "PERSONAGEM",
    UDim2.new(0, 10, 0, 15)
)

local CombateTab = CreateTab(
    "COMBATE",
    UDim2.new(0, 10, 0, 75)
)

local ESPTab = CreateTab(
    "ESP",
    UDim2.new(0, 10, 0, 135)
)

--==================================================
--// TROCA DE PÁGINA
--==================================================

local function ShowPage(Page)
    PersonagemPage.Visible = false
    CombatePage.Visible = false
    ESPPage.Visible = false

    if Page == "PERSONAGEM" then
        PersonagemPage.Visible = true
    elseif Page == "COMBATE" then
        CombatePage.Visible = true
    elseif Page == "ESP" then
        ESPPage.Visible = true
    end
end

PersonagemTab.MouseButton1Click:Connect(function()
    ShowPage("PERSONAGEM")
end)

CombateTab.MouseButton1Click:Connect(function()
    ShowPage("COMBATE")
end)

ESPTab.MouseButton1Click:Connect(function()
    ShowPage("ESP")
end)

--==================================================
--// TOGGLE
--==================================================

local function CreateToggle(Parent, Text, Position, Callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 250, 0, 45)
    Button.Position = Position
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = Text .. " : OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.Parent = Parent

    Round(Button, 10)

    local Enabled = false

    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled

        if Enabled then
            Button.Text = Text .. " : ON"
            Button.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        else
            Button.Text = Text .. " : OFF"
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end

        Callback(Enabled)
    end)

    return Button
end

--==================================================
--// SLIDER
--==================================================

local function CreateSlider(Parent, Text, Position, Min, Max, Default, Callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 250, 0, 30)
    Label.Position = Position
    Label.BackgroundTransparency = 1
    Label.Text = Text .. ": " .. tostring(Default)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Parent

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 250, 0, 12)
    Bar.Position = Position + UDim2.new(0, 0, 0, 32)
    Bar.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    Bar.Parent = Parent

    Round(Bar, 8)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    Fill.Parent = Bar

    Round(Fill, 8)

    local Dragging = false

    local function Update(X)
        local Percent = math.clamp(
            (X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
            0,
            1
        )

        local Value = math.floor(
            Min + (Max - Min) * Percent
        )

        Fill.Size = UDim2.new(Percent, 0, 1, 0)
        Label.Text = Text .. ": " .. tostring(Value)

        Callback(Value)
    end

    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            Update(Input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
            Update(Input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)
end

--==================================================
--// PERSONAGEM
--==================================================

CreateToggle(
    PersonagemPage,
    "SPEED",
    UDim2.new(0, 20, 0, 15),
    function(State)
        SpeedEnabled = State

        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = SpeedEnabled and SpeedValue or 16
        end
    end
)

CreateSlider(
    PersonagemPage,
    "VELOCIDADE",
    UDim2.new(0, 20, 0, 70),
    16,
    150,
    16,
    function(Value)
        SpeedValue = Value

        if SpeedEnabled then
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end
    end
)

CreateToggle(
    PersonagemPage,
    "FLY",
    UDim2.new(0, 20, 0, 125),
    function(State)
        FlyEnabled = State

        local Character = Player.Character
        local Root = Character and Character:FindFirstChild("HumanoidRootPart")

        if not Root then return end

        if State then
            FlyVelocity = Instance.new("BodyVelocity")
            FlyVelocity.MaxForce = Vector3.new(
                math.huge,
                math.huge,
                math.huge
            )
            FlyVelocity.Velocity = Vector3.zero
            FlyVelocity.Parent = Root
        else
            if FlyVelocity then
                FlyVelocity:Destroy()
                FlyVelocity = nil
            end
        end
    end
)

CreateToggle(
    PersonagemPage,
    "SPIN",
    UDim2.new(0, 20, 0, 180),
    function(State)
        SpinEnabled = State
    end
)

CreateSlider(
    PersonagemPage,
    "VELOCIDADE SPIN",
    UDim2.new(0, 20, 0, 235),
    1,
    50,
    10,
    function(Value)
        SpinSpeed = Value
    end
)

CreateToggle(
    PersonagemPage,
    "NOCLIP",
    UDim2.new(0, 20, 0, 290),
    function(State)
        NoClipEnabled = State
    end
)

--==================================================
--// COMBATE
--==================================================

CreateToggle(
    CombatePage,
    "AIMBOT",
    UDim2.new(0, 20, 0, 15),
    function(State)
        AimbotEnabled = State
    end
)

CreateToggle(
    CombatePage,
    "FOV",
    UDim2.new(0, 20, 0, 70),
    function(State)
        FOVEnabled = State
    end
)

CreateSlider(
    CombatePage,
    "RAIO FOV",
    UDim2.new(0, 20, 0, 125),
    50,
    400,
    120,
    function(Value)
        FOVRadius = Value
    end
)

local AimPartButton = Instance.new("TextButton")
AimPartButton.Size = UDim2.new(0, 250, 0, 45)
AimPartButton.Position = UDim2.new(0, 20, 0, 180)
AimPartButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AimPartButton.Text = "PARTE: HEAD"
AimPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimPartButton.TextScaled = true
AimPartButton.Font = Enum.Font.GothamBold
AimPartButton.Parent = CombatePage

Round(AimPartButton, 10)

AimPartButton.MouseButton1Click:Connect(function()
    if AimPart == "Head" then
        AimPart = "HumanoidRootPart"
        AimPartButton.Text = "PARTE: ROOT"
    else
        AimPart = "Head"
        AimPartButton.Text = "PARTE: HEAD"
    end
end)

--==================================================
--// ESP
--==================================================

CreateToggle(
    ESPPage,
    "ESP BOX",
    UDim2.new(0, 20, 0, 15),
    function(State)
        ESPBoxEnabled = State
    end
)

CreateToggle(
    ESPPage,
    "ESP HEALTH",
    UDim2.new(0, 20, 0, 70),
    function(State)
        ESPHealthEnabled = State
    end
)

--==================================================
--// FOV CIRCLE
--==================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Size = UDim2.new(0, FOVRadius * 2, 0, FOVRadius * 2)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.Parent = Gui

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Thickness = 2
FOVStroke.Color = Color3.fromRGB(255, 0, 0)
FOVStroke.Parent = FOVCircle

--==================================================
--// AIMBOT
--==================================================

local function GetClosestTarget()
    local Closest = nil
    local ClosestDistance = FOVRadius

    for _, Target in ipairs(Players:GetPlayers()) do
        if Target ~= Player then
            local Character = Target.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local Part = Character and Character:FindFirstChild(AimPart)

            if Humanoid and Humanoid.Health > 0 and Part then
                local ScreenPosition, OnScreen =
                    Camera:WorldToViewportPoint(Part.Position)

                if OnScreen then
                    local MousePosition =
                        UserInputService:GetMouseLocation()

                    local Distance = (
                        Vector2.new(
                            ScreenPosition.X,
                            ScreenPosition.Y
                        ) - MousePosition
                    ).Magnitude

                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        Closest = Part
                    end
                end
            end
        end
    end

    return Closest
end

--==================================================
--// ESP
--==================================================

local ESPObjects = {}

local function RemoveESP(PlayerTarget)
    local Data = ESPObjects[PlayerTarget]

    if Data then
        for _, Object in pairs(Data) do
            if Object and Object.Parent then
                Object:Destroy()
            end
        end

        ESPObjects[PlayerTarget] = nil
    end
end

local function CreateESP(PlayerTarget)
    if PlayerTarget == Player then return end

    local Character = PlayerTarget.Character
    if not Character then return end

    RemoveESP(PlayerTarget)

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RIPGB_ESP"
    Highlight.Adornee = Character
    Highlight.FillTransparency = 0.8
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Character

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "RIPGB_HEALTH"
    Billboard.Size = UDim2.new(0, 100, 0, 25)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Parent = Character

    local HealthLabel = Instance.new("TextLabel")
    HealthLabel.Size = UDim2.new(1, 0, 1, 0)
    HealthLabel.BackgroundTransparency = 1
    HealthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    HealthLabel.TextScaled = true
    HealthLabel.Font = Enum.Font.GothamBold
    HealthLabel.Parent = Billboard

    ESPObjects[PlayerTarget] = {
        Highlight = Highlight,
        Billboard = Billboard,
        HealthLabel = HealthLabel
    }
end

--==================================================
--// BOTÃO FLUTUANTE
--==================================================

local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 145, 0, 50)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -25)
FloatingButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
FloatingButton.Text = "PAINEL DO RIP GB"
FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.TextScaled = true
FloatingButton.Font = Enum.Font.GothamBold

-- IMPORTANTE:
-- fica escondido até a senha ser aceita
FloatingButton.Visible = false

FloatingButton.Parent = Gui

Round(FloatingButton, 10)
Stroke(FloatingButton)

FloatingButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--==================================================
--// ARRASTAR PAINEL
--==================================================

local function MakeDraggable(Object)
    local Dragging = false
    local DragStart
    local StartPosition

    Object.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Object.Position

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = Input.Position - DragStart

            Object.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end

MakeDraggable(Main)
MakeDraggable(FloatingButton)

--==================================================
--// FECHAR
--==================================================

CloseButton.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

--==================================================
--// LOOP PRINCIPAL
--==================================================

RunService.RenderStepped:Connect(function()
    
    -- SPEED
    if SpeedEnabled then
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = SpeedValue
        end
    end

    -- NOCLIP
    if NoClipEnabled then
        local Character = Player.Character

        if Character then
            for _, Object in ipairs(Character:GetDescendants()) do
                if Object:IsA("BasePart") then
                    Object.CanCollide = false
                end
            end
        end
    end

    -- FLY
    if FlyEnabled and FlyVelocity then
        local Character = Player.Character
        local Root = Character and Character:FindFirstChild("HumanoidRootPart")

        if Root then
            local Direction = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                Direction += Camera.CFrame.LookVector
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                Direction -= Camera.CFrame.LookVector
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                Direction -= Camera.CFrame.RightVector
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                Direction += Camera.CFrame.RightVector
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                Direction += Vector3.new(0, 1, 0)
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                Direction -= Vector3.new(0, 1, 0)
            end

            if Direction.Magnitude > 0 then
                Direction = Direction.Unit * SpeedValue
            end

            FlyVelocity.Velocity = Direction
        end
    end

    -- SPIN
    if SpinEnabled then
        local Character = Player.Character
        local Root = Character and Character:FindFirstChild("HumanoidRootPart")

        if Root then
            Root.CFrame =
                Root.CFrame *
                CFrame.Angles(0, math.rad(SpinSpeed), 0)
        end
    end

    -- FOV
    FOVCircle.Visible = FOVEnabled

    if FOVEnabled then
        FOVCircle.Size =
            UDim2.new(0, FOVRadius * 2, 0, FOVRadius * 2)

        local MousePosition =
            UserInputService:GetMouseLocation()

        FOVCircle.Position =
            UDim2.new(0, MousePosition.X, 0, MousePosition.Y)
    end

    -- AIMBOT
    if AimbotEnabled then
        local Target = GetClosestTarget()

        if Target then
            Camera.CFrame =
                CFrame.new(
                    Camera.CFrame.Position,
                    Target.Position
                )
        end
    end

    -- ESP
    for _, Target in ipairs(Players:GetPlayers()) do
        if Target ~= Player then

            local Character = Target.Character
            local Data = ESPObjects[Target]

            if (ESPBoxEnabled or ESPHealthEnabled) and Character then

                if not Data then
                    CreateESP(Target)
                    Data = ESPObjects[Target]
                end

                if Data then
                    Data.Highlight.Enabled = ESPBoxEnabled
                    Data.Billboard.Enabled = ESPHealthEnabled

                    local Humanoid =
                        Character:FindFirstChildOfClass("Humanoid")

                    if Humanoid then
                        Data.HealthLabel.Text =
                            "HP: " .. math.floor(Humanoid.Health)
                    end
                end
            else
                RemoveESP(Target)
            end
        end
    end
end)

--==================================================
--// RESPAWN
--==================================================

Player.CharacterAdded:Connect(function(Character)

    local Humanoid =
        Character:WaitForChild("Humanoid")

    task.wait(0.5)

    if SpeedEnabled then
        Humanoid.WalkSpeed = SpeedValue
    else
        Humanoid.WalkSpeed = 16
    end

    if NoClipEnabled then
        for _, Object in ipairs(Character:GetDescendants()) do
            if Object:IsA("BasePart") then
                Object.CanCollide = false
            end
        end
    end

    if FlyEnabled then
        task.wait(0.2)

        local Root =
            Character:FindFirstChild("HumanoidRootPart")

        if Root then
            FlyVelocity = Instance.new("BodyVelocity")
            FlyVelocity.MaxForce = Vector3.new(
                math.huge,
                math.huge,
                math.huge
            )
            FlyVelocity.Velocity = Vector3.zero
            FlyVelocity.Parent = Root
        end
    end
end)

--==================================================
--// SENHA
--==================================================

EnterButton.MouseButton1Click:Connect(function()

    if SENHAS[PasswordBox.Text] then

        -- fecha completamente a tela da senha
        PasswordFrame.Visible = false

        -- libera o painel
        Main.Visible = true

        -- libera o botão flutuante
        FloatingButton.Visible = true

        ShowPage("PERSONAGEM")

    else

        PasswordBox.Text = ""
        PasswordBox.PlaceholderText = "Senha incorreta!"

    end
end)

-- ENTER TAMBÉM FUNCIONA
PasswordBox.FocusLost:Connect(function(EnterPressed)

    if EnterPressed then
        EnterButton:Activate()
    end

end)

--==================================================
--// GARANTIA: COMEÇA SOMENTE NA SENHA
--==================================================

PasswordFrame.Visible = true
Main.Visible = false
FloatingButton.Visible = false
FOVCircle.Visible = false

ShowPage("PERSONAGEM")
