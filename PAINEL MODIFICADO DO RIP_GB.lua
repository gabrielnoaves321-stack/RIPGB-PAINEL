
-- PAINEL PREMIUM RIP_GB
-- LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("PremiumRipGB")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "PremiumRipGB"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local red = Color3.fromRGB(235, 35, 48)
local bg = Color3.fromRGB(20, 20, 24)
local card = Color3.fromRGB(36, 36, 43)
local white = Color3.fromRGB(245, 245, 245)

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local panel = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(470, 365),
    Position = UDim2.new(0.5, -235, 0.5, -182),
    BackgroundColor3 = bg,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 12)}, panel)
create("UIStroke", {Color = red, Thickness = 2}, panel)

local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Color3.fromRGB(29, 24, 28),
    BorderSizePixel = 0,
}, panel)

create("TextLabel", {
    Size = UDim2.new(1, -55, 1, 0),
    Position = UDim2.fromOffset(14, 0),
    BackgroundTransparency = 1,
    Text = "☠  PAINEL PREMIUM RIP_GB",
    TextColor3 = red,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = create("TextButton", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(1, -44, 0, 3),
    BackgroundTransparency = 1,
    Text = "×",
    TextColor3 = white,
    TextSize = 27,
}, header)

-- Arrastar pelo cabeçalho
do
    local dragging = false
    local dragStart, startPosition

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPosition = panel.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType ==
            Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local sidebar = create("Frame", {
    Position = UDim2.fromOffset(10, 58),
    Size = UDim2.new(0, 125, 1, -68),
    BackgroundTransparency = 1,
}, panel)

create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)

local pageHolder = create("Frame", {
    Position = UDim2.fromOffset(145, 58),
    Size = UDim2.new(1, -155, 1, -68),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
}, panel)

local pages = {}
local selectedTab

local function makePage(name)
    local page = create("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = red,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, pageHolder)

    create("UIPadding", {
        PaddingRight = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 8),
    }, page)

    create("UIListLayout", {
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)

    pages[name] = page
    return page
end

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    selectedTab = name

    for _, obj in ipairs(sidebar:GetChildren()) do
        if obj:IsA("TextButton") then
            obj.BackgroundColor3 =
                obj.Name == name and red or card
        end
    end
end

local function makeTab(name, label)
    local b = create("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = card,
        Text = label,
        TextColor3 = white,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        BorderSizePixel = 0,
    }, sidebar)

    create("UICorner", {CornerRadius = UDim.new(0, 7)}, b)
    b.Activated:Connect(function()
        showPage(name)
    end)
end

local characterPage = makePage("PERSONAGEM")
local aimPage = makePage("AIMBOT")
local espPage = makePage("ESP")

makeTab("PERSONAGEM", "PERSONAGEM")
makeTab("AIMBOT", "AIMBOT")
makeTab("ESP", "ESP")

local function addButton(page, text, callback)
    local b = create("TextButton", {
        Size = UDim2.new(1, -5, 0, 38),
        BackgroundColor3 = card,
        Text = text,
        TextColor3 = white,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextWrapped = true,
        BorderSizePixel = 0,
    }, page)

    create("UICorner", {CornerRadius = UDim.new(0, 7)}, b)
    b.Activated:Connect(callback)
    return b
end

local function addSlider(page, label, min, max, initial, callback)
    local holder = create("Frame", {
        Size = UDim2.new(1, -5, 0, 57),
        BackgroundColor3 = card,
        BorderSizePixel = 0,
    }, page)

    create("UICorner", {CornerRadius = UDim.new(0, 7)}, holder)

    local value = initial
    create("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -16, 0, 25),
        Position = UDim2.fromOffset(8, 2),
        BackgroundTransparency = 1,
        Text = label .. ": " .. value,
        TextColor3 = white,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, holder)

    local bar = create("TextButton", {
        Position = UDim2.new(0, 8, 0, 34),
        Size = UDim2.new(1, -16, 0, 12),
        BackgroundColor3 = Color3.fromRGB(75, 75, 82),
        Text = "",
        AutoButtonColor = false,
    }, holder)

    create("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

    local fill = create("Frame", {
        Size = UDim2.new((initial-min)/(max-min), 0, 1, 0),
        BackgroundColor3 = red,
        BorderSizePixel = 0,
    }, bar)

    create("UICorner", {CornerRadius = UDim.new(1, 0)}, fill)

    local function update(x)
        local pct = math.clamp(
            (x - bar.AbsolutePosition.X) /
            math.max(bar.AbsoluteSize.X, 1), 0, 1
        )
        value = math.floor(min + (max-min)*pct)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        holder.Label.Text = label .. ": " .. value
        callback(value)
    end

    local dragging = false

    bar.Activated:Connect(function()
        update(UIS:GetMouseLocation().X)
    end)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType ==
            Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- PERSONAGEM
local speedOn = false
local speed = 50
local flyOn = false
local flySpeed = 60
local flyConnection

local function humanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

addButton(characterPage, "Velocidade: DESLIGADA", function()
    speedOn = not speedOn
    local h = humanoid()
    if h then
        h.WalkSpeed = speedOn and speed or 16
    end
end)

addSlider(characterPage, "Velocidade", 16, 350, speed, function(v)
    speed = v
    if speedOn then
        local h = humanoid()
        if h then h.WalkSpeed = speed end
    end
end)

local flyButton
local function stopFly()
    flyOn = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local h = humanoid()

    if root then
        local bv = root:FindFirstChild("RipGB_Velocity")
        local bg = root:FindFirstChild("RipGB_Gyro")
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end

    if h then h.PlatformStand = false end
    if flyButton then flyButton.Text = "Voo: DESLIGADO" end
end

local function startFly()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local h = humanoid()
    if not root or not h then return end

    stopFly()
    flyOn = true
    h.PlatformStand = true

    local bv = Instance.new("BodyVelocity")
    bv.Name = "RipGB_Velocity"
    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bv.Parent = root

    local bg = Instance.new("BodyGyro")
    bg.Name = "RipGB_Gyro"
    bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bg.P = 1e4
    bg.Parent = root

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyOn or not root.Parent then
            stopFly()
            return
        end

        local cam = workspace.CurrentCamera
        local dir = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end

        bv.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
        bg.CFrame = cam.CFrame
    end)

    flyButton.Text = "Voo: LIGADO (G)"
end

flyButton = addButton(characterPage, "Voo: DESLIGADO (G)", function()
    if flyOn then
        stopFly()
    else
        startFly()
    end
end)

addSlider(characterPage, "Velocidade do voo", 10, 350, flySpeed, function(v)
    flySpeed = v
end)

-- AIMBOT: controles visuais para integração ao combate do próprio jogo.
local aimOn = false
local fov = 120

local circle = create("Frame", {
    Name = "FOVCircle",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(fov*2, fov*2),
    Visible = false,
}, gui)

create("UICorner", {CornerRadius = UDim.new(1, 0)}, circle)
create("UIStroke", {Color = red, Thickness = 2}, circle)

local aimButton
aimButton = addButton(aimPage, "Aimbot do jogo: DESLIGADO", function()
    aimOn = not aimOn
    aimButton.Text = "Aimbot do jogo: " ..
        (aimOn and "LIGADO" or "DESLIGADO")
end)

addSlider(aimPage, "FOV", 20, 400, fov, function(v)
    fov = v
end)

local aimInfo = create("TextLabel", {
    Size = UDim2.new(1, -5, 0, 70),
    BackgroundColor3 = card,
    Text = "O botão controla o estado da assistência. A seleção e o acompanhamento da cabeça precisam ser conectados à lógica de combate do teu próprio jogo.",
    TextColor3 = white,
    TextWrapped = true,
    Font = Enum.Font.Gotham,
    TextSize = 12,
}, aimPage)

-- ESP
local espOn = false
local espButton

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local char = p.Character
            local existing = char:FindFirstChild("RipGB_Highlight")

            if espOn and not existing then
                local highlight = Instance.new("Highlight")
                highlight.Name = "RipGB_Highlight"
                highlight.FillTransparency = 0.85
                highlight.OutlineColor = red
                highlight.Adornee = char
                highlight.Parent = char
            elseif not espOn and existing then
                existing:Destroy()
            end
        end
    end
end

espButton = addButton(espPage, "ESP: DESLIGADO", function()
    espOn = not espOn
    espButton.Text = "ESP: " .. (espOn and "LIGADO" or "DESLIGADO")
    updateESP()
end)

addButton(espPage, "Remover contornos ESP", function()
    espOn = false
    espButton.Text = "ESP: DESLIGADO"
    updateESP()
end)

RunService.RenderStepped:Connect(function()
    local mouse = UIS:GetMouseLocation()
    circle.Position = UDim2.fromOffset(mouse.X, mouse.Y)
    circle.Size = UDim2.fromOffset(fov*2, fov*2)
    circle.Visible = aimOn
    updateESP()
end)

local floating = create("TextButton", {
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 18, 0.5, -26),
    BackgroundColor3 = red,
    Text = "☠",
    TextColor3 = white,
    TextSize = 29,
}, gui)
create("UICorner", {CornerRadius = UDim.new(1, 0)}, floating)

floating.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

close.Activated:Connect(function()
    panel.Visible = false
end)

UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F4 then
        panel.Visible = not panel.Visible
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    if speedOn then
        local h = humanoid()
        if h then h.WalkSpeed = speed end
    end
end)

showPage("PERSONAGEM")
