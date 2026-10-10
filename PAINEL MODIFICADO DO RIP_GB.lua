-- PAINEL PREMIUM RIP_GB
-- Coloque em StarterPlayer > StarterPlayerScripts
-- Cria um painel local para cada jogador.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RIP_GB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local state = {
    Speed = 16,
    FlySpeed = 30,
    SpinSpeed = 10,
    Fly = false,
    Spin = false,
    Noclip = false,
    Box = false,
    Names = false,
    Health = false,
}

local function character()
    return player.Character
end

local function humanoid()
    local c = character()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local panel = make("Frame", {
    Size = UDim2.fromOffset(350, 420),
    Position = UDim2.new(0.5, -175, 0.5, -210),
    BackgroundColor3 = Color3.fromRGB(22, 22, 27),
    BorderSizePixel = 0,
    Active = true,
}, gui)

make("UICorner", {CornerRadius = UDim.new(0, 10)}, panel)
make("UIStroke", {
    Color = Color3.fromRGB(230, 35, 50),
    Thickness = 2,
}, panel)

make("TextLabel", {
    Size = UDim2.new(1, -45, 0, 45),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "PAINEL PREMIUM RIP_GB",
    TextColor3 = Color3.fromRGB(255, 65, 75),
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local close = make("TextButton", {
    Size = UDim2.fromOffset(32, 30),
    Position = UDim2.new(1, -38, 0, 7),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    BackgroundColor3 = Color3.fromRGB(155, 25, 35),
    Font = Enum.Font.GothamBold,
}, panel)

close.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

local tabs = make("Frame", {
    Position = UDim2.fromOffset(10, 48),
    Size = UDim2.new(1, -20, 0, 35),
    BackgroundTransparency = 1,
}, panel)

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 5),
}, tabs)

local content = make("ScrollingFrame", {
    Position = UDim2.fromOffset(10, 91),
    Size = UDim2.new(1, -20, 1, -101),
    BackgroundColor3 = Color3.fromRGB(30, 30, 36),
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, panel)

make("UIPadding", {
    PaddingTop = UDim.new(0, 8),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 8),
}, content)

local pages = {}
local layouts = {}

for _, name in ipairs({"PERSONAGEM", "COMBATE", "ESP"}) do
    local page = make("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Visible = false,
    }, content)

    make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)

    pages[name] = page

    local tab = make("TextButton", {
        Name = name,
        Size = UDim2.new(1/3, -4, 1, 0),
        Text = name,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundColor3 = Color3.fromRGB(135, 25, 35),
    }, tabs)

    make("UICorner", {CornerRadius = UDim.new(0, 5)}, tab)

    tab.MouseButton1Click:Connect(function()
        for pageName, p in pairs(pages) do
            p.Visible = pageName == name
        end
    end)
end

pages.PERSONAGEM.Visible = true

local function button(pageName, text, callback)
    local b = make("TextButton", {
        Size = UDim2.new(1, -4, 0, 36),
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundColor3 = Color3.fromRGB(48, 48, 57),
    }, pages[pageName])

    make("UICorner", {CornerRadius = UDim.new(0, 6)}, b)
    b.MouseButton1Click:Connect(function()
        callback(b)
    end)
    return b
end

local function slider(pageName, label, min, max, initial, callback)
    local holder = make("Frame", {
        Size = UDim2.new(1, -4, 0, 62),
        BackgroundColor3 = Color3.fromRGB(40, 40, 47),
    }, pages[pageName])

    local caption = make("TextLabel", {
        Size = UDim2.new(1, -12, 0, 26),
        Position = UDim2.fromOffset(6, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = label .. ": " .. initial,
        Font = Enum.Font.Gotham,
        TextSize = 12,
    }, holder)

    local bar = make("TextButton", {
        Position = UDim2.fromOffset(8, 35),
        Size = UDim2.new(1, -16, 0, 13),
        Text = "",
        AutoButtonColor = false,
        BackgroundColor3 = Color3.fromRGB(75, 75, 83),
    }, holder)

    local fill = make("Frame", {
        Size = UDim2.new((initial-min)/(max-min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(230, 35, 50),
        BorderSizePixel = 0,
    }, bar)

    local dragging = false
    local value = initial

    local function update(x)
        local a = math.clamp(
            (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1
        )
        value = math.floor(min + (max-min)*a)
        fill.Size = UDim2.new(a, 0, 1, 0)
        caption.Text = label .. ": " .. value
        callback(value)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function toggle(pageName, label, key, callback)
    button(pageName, label .. ": OFF", function(b)
        state[key] = not state[key]
        b.Text = label .. (state[key] and ": ON" or ": OFF")
        b.BackgroundColor3 = state[key]
            and Color3.fromRGB(155, 30, 42)
            or Color3.fromRGB(48, 48, 57)
        callback(state[key])
    end)
end

-- Personagem
slider("PERSONAGEM", "Speed", 16, 50, 16, function(v)
    state.Speed = v
    local h = humanoid()
    if h then h.WalkSpeed = v end
end)

slider("PERSONAGEM", "Fly Speed", 10, 80, 30, function(v)
    state.FlySpeed = v
end)

slider("PERSONAGEM", "Spin Speed", 1, 30, 10, function(v)
    state.SpinSpeed = v
end)

toggle("PERSONAGEM", "Fly", "Fly", function() end)
toggle("PERSONAGEM", "Spin", "Spin", function() end)
toggle("PERSONAGEM", "Noclip", "Noclip", function() end)

-- Combate: mira de treino fica reservada para integração própria do jogo.
slider("COMBATE", "FOV", 30, 300, 100, function(v)
    state.FOV = v
end)

toggle("COMBATE", "Aimbot de treino", "Aimbot", function() end)

-- ESP dos jogadores
local drawings = {}

local function clearESP(p)
    if drawings[p] then
        for _, item in ipairs(drawings[p]) do
            item:Destroy()
        end
        drawings[p] = nil
    end
end

local function createESP(p)
    if p == player or drawings[p] then return end
    local c = p.Character
    local head = c and c:FindFirstChild("Head")
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local items = {}

    if state.Names or state.Health then
        local bb = make("BillboardGui", {
            Name = "RIP_ESP",
            Size = UDim2.fromOffset(150, 38),
            StudsOffset = Vector3.new(0, 2.8, 0),
            AlwaysOnTop = true,
            Adornee = head,
        }, gui)

        local label = make("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            TextStrokeTransparency = 0,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
        }, bb)

        local function refresh()
            if not bb.Parent then return end
            local lines = {}
            if state.Names then table.insert(lines, p.Name) end
            if state.Health then
                table.insert(lines, "HP: " .. math.floor(hum.Health))
            end
            label.Text = table.concat(lines, "\n")
        end

        refresh()
        table.insert(items, bb)

        table.insert(items, hum.HealthChanged:Connect(function()
            refresh()
        end))
    end

    if state.Box then
        local box = make("Highlight", {
            Name = "RIP_Box",
            Adornee = c,
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 45, 60),
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        }, gui)
        table.insert(items, box)
    end

    drawings[p] = items
end

local function refreshESP()
    for _, p in ipairs(Players:GetPlayers()) do
        clearESP(p)
        createESP(p)
    end
end

toggle("ESP", "ESP Box", "Box", refreshESP)
toggle("ESP", "ESP Name", "Names", refreshESP)
toggle("ESP", "ESP Vida", "Health", refreshESP)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        task.wait(1)
        createESP(p)
    end)
end)

Players.PlayerRemoving:Connect(clearESP)

-- Movimento local e restauração ao desativar.
local original = {}
local function remember(part)
    if original[part] == nil then
        original[part] = part.CanCollide
    end
end

local function restoreCollision()
    for part, canCollide in pairs(original) do
        if part.Parent then part.CanCollide = canCollide end
    end
    table.clear(original)
end

RunService.Heartbeat:Connect(function(dt)
    local c = character()
    local h = humanoid()
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not c or not h or not root then return end

    h.WalkSpeed = state.Speed

    if state.Noclip then
        for _, part in ipairs(c:GetDescendants()) do
            if part:IsA("BasePart") then
                remember(part)
                part.CanCollide = false
            end
        end
    else
        restoreCollision()
    end

    if state.Spin then
        root.AssemblyAngularVelocity = Vector3.new(
            0, state.SpinSpeed, 0
        )
    end

    if state.Fly then
        local camera = workspace.CurrentCamera
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

        root.AssemblyLinearVelocity =
            direction.Magnitude > 0
            and direction.Unit * state.FlySpeed
            or Vector3.zero
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    local h = humanoid()
    if h then h.WalkSpeed = state.Speed end
end)

print("PAINEL RIP_GB carregado")
