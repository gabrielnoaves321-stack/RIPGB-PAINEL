
-- PAINEL PREMIUM RIP_GB
-- LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "PremiumRipGB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local panel = make("Frame", {
    Size = UDim2.fromOffset(430, 330),
    Position = UDim2.new(0.5, -215, 0.5, -165),
    BackgroundColor3 = Color3.fromRGB(20, 20, 24),
    BorderSizePixel = 0,
    Active = true,
}, gui)

make("UICorner", {CornerRadius = UDim.new(0, 12)}, panel)
make("UIStroke", {
    Color = Color3.fromRGB(220, 35, 45),
    Thickness = 2,
}, panel)

local title = make("TextLabel", {
    Size = UDim2.new(1, -50, 0, 42),
    BackgroundTransparency = 1,
    Text = "☠ PAINEL PREMIUM RIP_GB",
    TextColor3 = Color3.fromRGB(255, 65, 70),
    TextSize = 19,
    Font = Enum.Font.GothamBold,
}, panel)

local close = make("TextButton", {
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -40, 0, 2),
    BackgroundTransparency = 1,
    Text = "×",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 28,
}, panel)

local skull = make("TextButton", {
    Size = UDim2.fromOffset(54, 54),
    Position = UDim2.new(0, 20, 0.5, -27),
    BackgroundColor3 = Color3.fromRGB(160, 15, 25),
    Text = "☠",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 30,
}, gui)
make("UICorner", {CornerRadius = UDim.new(1, 0)}, skull)

local content = make("Frame", {
    Position = UDim2.fromOffset(12, 52),
    Size = UDim2.new(1, -24, 1, -64),
    BackgroundTransparency = 1,
}, panel)

local layout = make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, content)

local function button(text, callback)
    local b = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Color3.fromRGB(43, 35, 38),
        Text = text,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
    }, content)
    make("UICorner", {CornerRadius = UDim.new(0, 7)}, b)
    b.Activated:Connect(callback)
    return b
end

local function slider(label, min, max, initial, callback)
    local holder = make("Frame", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundTransparency = 1,
    }, content)

    local txt = make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = label .. ": " .. initial,
        TextSize = 13,
    }, holder)

    local bar = make("TextButton", {
        Position = UDim2.fromOffset(0, 27),
        Size = UDim2.new(1, 0, 0, 13),
        BackgroundColor3 = Color3.fromRGB(75, 75, 80),
        Text = "",
        AutoButtonColor = false,
    }, holder)
    make("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

    local fill = make("Frame", {
        Size = UDim2.new((initial-min)/(max-min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(235, 40, 50),
    }, bar)
    make("UICorner", {CornerRadius = UDim.new(1, 0)}, fill)

    local dragging = false
    local function update(x)
        local pct = math.clamp(
            (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1
        )
        local value = math.floor(min + (max-min)*pct)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        txt.Text = label .. ": " .. value
        callback(value)
    end

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

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local speedEnabled = false
local speedValue = 16
local flyEnabled = false
local flySpeed = 60
local espEnabled = false
local aimEnabled = false
local fov = 120
local flyKey = Enum.KeyCode.G

local function updateSpeed()
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = speedEnabled and speedValue or 16
    end
end

button("PERSONAGEM — Velocidade ON/OFF", function()
    speedEnabled = not speedEnabled
    updateSpeed()
end)

slider("Velocidade", 16, 350, 50, function(v)
    speedValue = v
    if speedEnabled then updateSpeed() end
end)

button("VOO ON/OFF (tecla G)", function()
    flyEnabled = not flyEnabled
    local hum = getHumanoid()
    if hum then
        hum.PlatformStand = false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

slider("Velocidade do voo", 10, 350, 60, function(v)
    flySpeed = v
end)

button("ESP — caixas e vida ON/OFF", function()
    espEnabled = not espEnabled
    if not espEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChild("RipGB_ESP")
                if h then h:Destroy() end
            end
        end
    end
end)

button("AIMBOT — assistência do jogo ON/OFF", function()
    aimEnabled = not aimEnabled
end)

slider("FOV da mira", 20, 400, 120, function(v)
    fov = v
end)

local circle = make("Frame", {
    Name = "FOV",
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.fromOffset(fov*2, fov*2),
    Visible = false,
}, gui)
make("UICorner", {CornerRadius = UDim.new(1, 0)}, circle)
make("UIStroke", {
    Color = Color3.fromRGB(255, 40, 50),
    Thickness = 1.5,
}, circle)

local function addESP(p)
    if p == player or not espEnabled or not p.Character then return end
    local char = p.Character
    if char:FindFirstChild("RipGB_ESP") then return end

    local h = Instance.new("Highlight")
    h.Name = "RipGB_ESP"
    h.FillTransparency = 0.8
    h.OutlineColor = Color3.fromRGB(255, 40, 50)
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = char
    h.Parent = char
end

local function refreshESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if espEnabled then
            addESP(p)
        elseif p.Character then
            local h = p.Character:FindFirstChild("RipGB_ESP")
            if h then h:Destroy() end
        end
    end
end

local function startFly()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = getHumanoid()
    if not root or not hum then return end

    local bv = Instance.new("BodyVelocity")
    bv.Name = "RipGB_FlyVelocity"
    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bv.Parent = root

    local bg = Instance.new("BodyGyro")
    bg.Name = "RipGB_FlyGyro"
    bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bg.P = 1e4
    bg.Parent = root

    hum.PlatformStand = true

    task.spawn(function()
        while flyEnabled and root.Parent do
            local direction = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                direction += camera.CFrame.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                direction -= camera.CFrame.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                direction += camera.CFrame.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                direction -= camera.CFrame.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                direction += Vector3.yAxis
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                direction -= Vector3.yAxis
            end

            bv.Velocity = direction.Magnitude > 0
                and direction.Unit * flySpeed or Vector3.zero
            bg.CFrame = camera.CFrame
            task.wait()
        end

        if bv.Parent then bv:Destroy() end
        if bg.Parent then bg:Destroy() end
        if hum.Parent then hum.PlatformStand = false end
    end)
end

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F4 then
        panel.Visible = not panel.Visible
    elseif input.KeyCode == flyKey then
        if flyEnabled then startFly() end
    end
end)

skull.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)
close.Activated:Connect(function()
    panel.Visible = false
end)

RunService.RenderStepped:Connect(function()
    camera = workspace.CurrentCamera
    local mouse = UIS:GetMouseLocation()
    circle.Position = UDim2.fromOffset(mouse.X, mouse.Y)
    circle.Size = UDim2.fromOffset(fov*2, fov*2)
    circle.Visible = aimEnabled
    refreshESP()
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    updateSpeed()
end)
