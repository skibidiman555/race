-- Muscle Legends Race Bot (Mobil / Delta Executor Uyumlu)
-- Mobile Touch Input & Minimize Button Edition

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- 1. MOBİL UYUMLU ULTRA COOL GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaceBotGui_Mobile"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true -- Tam ekran mobil uyum
screenGui.Parent = playerGui

-- Ana Çerçeve
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 190)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -95) -- Ekranın ortası
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Arka Plan Gradyanı
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 10, 35)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(10, 20, 40)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 10))
})
bgGradient.Rotation = 120
bgGradient.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(150, 0, 255)
uiStroke.Thickness = 3
uiStroke.Parent = mainFrame

-- Başlık
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 40)
titleLabel.Position = UDim2.new(0, 20, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ RACE BOT | MOBILE"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- ============================================================
-- 2. KÜÇÜLTME (MİNİMİZE) BUTONU
-- ============================================================
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 24
minimizeBtn.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

-- Ana Aç/Kapat Butonu
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.85, 0, 0, 80)
toggleButton.Position = UDim2.new(0.075, 0, 0.26, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
toggleButton.Text = "DURUM: KAPALI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.AutoButtonColor = false
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleButton

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
})
btnGradient.Rotation = 90
btnGradient.Parent = toggleButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255, 100, 100)
btnStroke.Thickness = 2
btnStroke.Parent = toggleButton

-- Script Owner (Rainbow)
local ownerLabel = Instance.new("TextLabel")
ownerLabel.Size = UDim2.new(1, 0, 0, 25)
ownerLabel.Position = UDim2.new(0, 0, 0.85, 0)
ownerLabel.BackgroundTransparency = 1
ownerLabel.Text = "ScriptOwner: PatrickJane"
ownerLabel.Font = Enum.Font.GothamBlack
ownerLabel.TextSize = 15
ownerLabel.Parent = mainFrame

local ownerGlow = Instance.new("UIStroke")
ownerGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
ownerGlow.Thickness = 2
ownerGlow.Transparency = 0.3
ownerGlow.Parent = ownerLabel

-- Rainbow Animasyonu
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.008) % 1
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    ownerLabel.TextColor3 = rainbowColor
    ownerGlow.Color = rainbowColor 
    if not isRunning then
        uiStroke.Color = Color3.fromHSV((hue + 0.5) % 1, 0.8, 1)
    end
end)

-- ============================================================
-- 3. KÜÇÜK MOD (SADECE AÇ/KAPAT BUTONU KALSIN)
-- ============================================================
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 160, 0, 50)
miniFrame.Position = UDim2.new(0, 20, 0.5, -25)
miniFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 10)
miniCorner.Parent = miniFrame

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(150, 0, 255)
miniStroke.Thickness = 2
miniStroke.Parent = miniFrame

local miniToggleBtn = Instance.new("TextButton")
miniToggleBtn.Size = UDim2.new(0, 110, 0, 40)
miniToggleBtn.Position = UDim2.new(0, 5, 0, 5)
miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
miniToggleBtn.Text = "KAPALI"
miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniToggleBtn.Font = Enum.Font.GothamBold
miniToggleBtn.TextSize = 16
miniToggleBtn.Parent = miniFrame

local miniBtnCorner = Instance.new("UICorner")
miniBtnCorner.CornerRadius = UDim.new(0, 8)
miniBtnCorner.Parent = miniToggleBtn

local maximizeBtn = Instance.new("TextButton")
maximizeBtn.Size = UDim2.new(0, 35, 0, 40)
maximizeBtn.Position = UDim2.new(1, -40, 0, 5)
maximizeBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
maximizeBtn.Text = "⬆"
maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
maximizeBtn.Font = Enum.Font.GothamBold
maximizeBtn.TextSize = 20
maximizeBtn.Parent = miniFrame

local maxBtnCorner = Instance.new("UICorner")
maxBtnCorner.CornerRadius = UDim.new(0, 8)
maxBtnCorner.Parent = maximizeBtn

-- Küçültme / Büyütme Mantığı
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)

maximizeBtn.MouseButton1Click:Connect(function()
    miniFrame.Visible = false
    mainFrame.Visible = true
end)

-- ============================================================
-- 4. DURUM & YARDIMCI FONKSİYONLAR
-- ============================================================
local isRunning = false
local botThread = nil

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoidRootPart()
    local char = getCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

local function teleportTo(position)
    local hrp = getHumanoidRootPart()
    hrp.CFrame = CFrame.new(position)
end

local function waitCancelable(seconds)
    local elapsed = 0
    while elapsed < seconds do
        if not isRunning then return false end
        task.wait(0.02)
        elapsed = elapsed + 0.02
    end
    return true
end

-- ============================================================
-- 5. MOBİL DOKUNMATİK TIKLAMA (Touch Simülasyonu)
-- ============================================================
local function simulateClick()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = math.floor(viewportSize.X / 2)
    local centerY = math.floor(viewportSize.Y / 2)

    -- 1. Dokunma Başlangıcı (Touch Begin)
    pcall(function()
        local touch = Instance.new("TouchInput")
        UserInputService:SendTouchEvent(touch, 0, true, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
    end)

    task.wait(0.01) -- Kısa basılı tutma

    -- 2. Dokunma Bitişi (Touch End)
    pcall(function()
        local touch = Instance.new("TouchInput")
        UserInputService:SendTouchEvent(touch, 0, false, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
    end)
end

local function spamClickFor(duration, minDelay, maxDelay)
    local elapsed = 0
    while elapsed < duration do
        if not isRunning then return false end
        simulateClick()

        local delay = minDelay + math.random() * (maxDelay - minDelay)
        if elapsed + delay > duration then delay = duration - elapsed end

        local waited = 0
        while waited < delay do
            if not isRunning then return false end
            local step = math.min(0.02, delay - waited)
            task.wait(step)
            waited = waited + step
        end
        elapsed = elapsed + delay
    end
    return true
end

-- ============================================================
-- 6. ANA BOT DÖNGÜSÜ
-- ============================================================
local function startBot()
    botThread = task.spawn(function()
        while isRunning do
            -- Aşama 1
            if not isRunning then break end
            teleportTo(Vector3.new(-12875.3, 6.4, -4157.5))
            if not waitCancelable(10) then break end

            -- Aşama 2
            if not isRunning then break end
            teleportTo(Vector3.new(-13373.0, 12.3, -4144.4))
            if not waitCancelable(13) then break end

            -- Aşama 3 (Mor: 19 sn bekle + 7 sn spam)
            if not isRunning then break end
            teleportTo(Vector3.new(-13803.8, 6.4, -4143.2))
            if not waitCancelable(19) then break end
            if not spamClickFor(7, 0.07, 0.08) then break end

            -- Aşama 4 (Kırmızı: 7 sn spam)
            if not isRunning then break end
            teleportTo(Vector3.new(-13962.5, 6.4, -4143.1))
            task.wait(0.2)
            if not spamClickFor(7, 0.02, 0.03) then break end

            -- Aşama 5
            if not isRunning then break end
            teleportTo(Vector3.new(-14550.8, 6.4, -4199.1))
            if not waitCancelable(4) then break end

            if not waitCancelable(0.3) then break end
        end
        if not isRunning then botThread = nil end
    end)
end

local function stopBot()
    isRunning = false
    if botThread then
        task.cancel(botThread)
        botThread = nil
    end
end

-- ============================================================
-- 7. BUTON MANTIKLARI & RENK GÜNCELLEMELERİ
-- ============================================================
local function updateUI(state)
    if state then
        -- Açık Durumu
        toggleButton.Text = "DURUM: AÇIK"
        miniToggleBtn.Text = "AÇIK"
        
        local greenGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 100)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 50)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 100))
        })
        btnGradient.Color = greenGradient
        btnStroke.Color = Color3.fromRGB(100, 255, 100)
        uiStroke.Color = Color3.fromRGB(0, 255, 0)
        
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        miniStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        -- Kapalı Durumu
        toggleButton.Text = "DURUM: KAPALI"
        miniToggleBtn.Text = "KAPALI"
        
        local redGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 0)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
        })
        btnGradient.Color = redGradient
        btnStroke.Color = Color3.fromRGB(255, 100, 100)
        uiStroke.Color = Color3.fromRGB(150, 0, 255)
        
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
        miniStroke.Color = Color3.fromRGB(150, 0, 255)
    end
end

-- Tıklama Fonksiyonu (Hem büyük hem küçük menü için ortak)
local function onToggleClick()
    isRunning = not isRunning
    updateUI(isRunning)
    
    -- Tıklama Animasyonu
    local function anim(btn, origSize)
        local pressedSize = UDim2.new(origSize.X.Scale * 0.9, origSize.X.Offset * 0.9, origSize.Y.Scale * 0.9, origSize.Y.Offset * 0.9)
        local pressTween = TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = pressedSize})
        local releaseTween = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize})
        pressTween:Play()
        pressTween.Completed:Connect(function() releaseTween:Play() end)
    end

    anim(toggleButton, UDim2.new(0.85, 0, 0, 80))
    anim(miniToggleBtn, UDim2.new(0, 110, 0, 40))

    if isRunning then
        startBot()
    else
        stopBot()
    end
end

toggleButton.MouseButton1Click:Connect(onToggleClick)
miniToggleBtn.MouseButton1Click:Connect(onToggleClick)

print("[Race Bot] Mobil (Delta) sürümü yüklendi. Dokunmatik tıklama aktif.")