-- Muscle Legends Race Bot (Delta Emülatör Fix - Ultimate Edition)
-- Mobile Touch & Mouse & Delta Bypasss

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HapticService = game:GetService("HapticService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- 1. MOBİL İÇİN 500x GELİŞMİŞ ARAYÜZ (GUI)
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaceBotGui_Mobile_Ultimate"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true 
screenGui.Parent = playerGui

-- ==== ANA MENÜ ÇERÇEVESİ ====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 10, 45)), 
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(10, 25, 45)), 
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 10))     
})
bgGradient.Rotation = 135
bgGradient.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(150, 0, 255) 
uiStroke.Thickness = 3
uiStroke.Parent = mainFrame

local innerStroke = Instance.new("UIStroke")
innerStroke.Color = Color3.fromRGB(0, 255, 255) 
innerStroke.Thickness = 1
innerStroke.Transparency = 0.6
innerStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 0, 45)
titleLabel.Position = UDim2.new(0, 20, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ ULTIMATE RACE BOT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -45, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 60)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 28
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.85, 0, 0, 90)
toggleButton.Position = UDim2.new(0.075, 0, 0.28, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 20, 50)
toggleButton.Text = "SİSTEM: KAPALI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBlack
toggleButton.TextSize = 24
toggleButton.AutoButtonColor = false
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = toggleButton

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(120, 0, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
})
btnGradient.Rotation = 90
btnGradient.Parent = toggleButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255, 100, 100)
btnStroke.Thickness = 2
btnStroke.Parent = toggleButton

local ownerFrame = Instance.new("Frame")
ownerFrame.Size = UDim2.new(0.85, 0, 0, 25)
ownerFrame.Position = UDim2.new(0.075, 0, 0.88, 0)
ownerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ownerFrame.BackgroundTransparency = 0.5
ownerFrame.Parent = mainFrame

local ownerCorner = Instance.new("UICorner")
ownerCorner.CornerRadius = UDim.new(0, 6)
ownerCorner.Parent = ownerFrame

local ownerLabel = Instance.new("TextLabel")
ownerLabel.Size = UDim2.new(1, 0, 1, 0)
ownerLabel.BackgroundTransparency = 1
ownerLabel.Text = "ScriptOwner: PatrickJane"
ownerLabel.Font = Enum.Font.GothamBold
ownerLabel.TextSize = 16
ownerLabel.Parent = ownerFrame

local ownerGlow = Instance.new("UIStroke")
ownerGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
ownerGlow.Thickness = 2
ownerGlow.Transparency = 0.2
ownerGlow.Parent = ownerLabel

-- ============================================================
-- 2. YÜZEN MİNİ KONTROLCÜ
-- ============================================================
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 180, 0, 55)
miniFrame.Position = UDim2.new(0, 20, 0.5, -27)
miniFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
miniFrame.BackgroundTransparency = 0.2
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 12)
miniCorner.Parent = miniFrame

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(150, 0, 255)
miniStroke.Thickness = 2
miniStroke.Parent = miniFrame

local miniToggleBtn = Instance.new("TextButton")
miniToggleBtn.Size = UDim2.new(0, 125, 0, 45)
miniToggleBtn.Position = UDim2.new(0, 5, 0, 5)
miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 50)
miniToggleBtn.Text = "KAPALI"
miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniToggleBtn.Font = Enum.Font.GothamBlack
miniToggleBtn.TextSize = 18
miniToggleBtn.AutoButtonColor = false
miniToggleBtn.Parent = miniFrame

local miniBtnCorner = Instance.new("UICorner")
miniBtnCorner.CornerRadius = UDim.new(0, 8)
miniBtnCorner.Parent = miniToggleBtn

local maximizeBtn = Instance.new("TextButton")
maximizeBtn.Size = UDim2.new(0, 40, 0, 45)
maximizeBtn.Position = UDim2.new(1, -45, 0, 5)
maximizeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
maximizeBtn.Text = "⬆"
maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
maximizeBtn.Font = Enum.Font.GothamBold
maximizeBtn.TextSize = 22
maximizeBtn.AutoButtonColor = false
maximizeBtn.Parent = miniFrame

local maxBtnCorner = Instance.new("UICorner")
maxBtnCorner.CornerRadius = UDim.new(0, 8)
maxBtnCorner.Parent = maximizeBtn

local function toggleMenuVisibility(showMain)
    if showMain then
        miniFrame.Visible = false
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 320, 0, 220)}):Play()
    else
        mainFrame.Visible = false
        miniFrame.Visible = true
        miniFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(miniFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 180, 0, 55)}):Play()
    end
end

minimizeBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(false) end)
maximizeBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(true) end)

local function vibrate()
    pcall(function()
        if HapticService:IsVibrationSupported(Enum.UserInputType.Touch) then
            HapticService:SetMotor(Enum.UserInputType.Touch, Enum.VibrationMotor.Small, 0.5)
            task.wait(0.1)
            HapticService:SetMotor(Enum.UserInputType.Touch, Enum.VibrationMotor.Small, 0)
        end
    end)
end

-- ============================================================
-- 3. DURUM & YARDIMCI FONKSİYONLAR
-- ============================================================
local isRunning = false
local botThread = nil
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
-- 4. ULTIMATE TIKLAMA (Emülatörler ve Delta İçin 3'lü Sistem)
-- ============================================================
local function simulateClick()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = math.floor(viewportSize.X / 2)
    local centerY = math.floor(viewportSize.Y / 2)

    -- Yöntem 1: VirtualInputManager (Fare Tıklaması) - Emülatörlerde en garanti yöntem
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
        task.wait(0.01)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
    end)

    -- Yöntem 2: Touch Event (Mobil Dokunmatik) - Fare çalışmazsa yedek
    pcall(function()
        local touch = Instance.new("TouchInput")
        UserInputService:SendTouchEvent(touch, 0, true, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
        task.wait(0.01)
        UserInputService:SendTouchEvent(touch, 0, false, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
    end)

    -- Yöntem 3: Delta'nın kendi mobil tıklama motoru (Eğer varsa)
    pcall(function()
        if type(is_mobile) == "function" then
            is_mobile()
        end
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
-- 5. ANA BOT DÖNGÜSÜ
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
-- 6. BUTON MANTIKLARI & ANİMASYONLAR
-- ============================================================
local function updateUI(state)
    if state then
        toggleButton.Text = "SİSTEM: AÇIK"
        miniToggleBtn.Text = "AÇIK"
        
        local greenGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 100)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 50)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 100))
        })
        btnGradient.Color = greenGradient
        btnStroke.Color = Color3.fromRGB(100, 255, 100)
        uiStroke.Color = Color3.fromRGB(0, 255, 0)
        
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        miniStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        toggleButton.Text = "SİSTEM: KAPALI"
        miniToggleBtn.Text = "KAPALI"
        
        local redGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(120, 0, 0)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
        })
        btnGradient.Color = redGradient
        btnStroke.Color = Color3.fromRGB(255, 100, 100)
        uiStroke.Color = Color3.fromRGB(150, 0, 255)
        
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 50)
        miniStroke.Color = Color3.fromRGB(150, 0, 255)
    end
end

local function onToggleClick(btn, origSize)
    isRunning = not isRunning
    updateUI(isRunning)
    vibrate()

    local pressedSize = UDim2.new(origSize.X.Scale * 0.85, origSize.X.Offset * 0.85, origSize.Y.Scale * 0.85, origSize.Y.Offset * 0.85)
    local pressTween = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = pressedSize})
    local releaseTween = TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = origSize})
    
    pressTween:Play()
    pressTween.Completed:Connect(function() releaseTween:Play() end)

    if isRunning then
        startBot()
    else
        stopBot()
    end
end

toggleButton.MouseButton1Click:Connect(function() onToggleClick(toggleButton, UDim2.new(0.85, 0, 0, 90)) end)
miniToggleBtn.MouseButton1Click:Connect(function() onToggleClick(miniToggleBtn, UDim2.new(0, 125, 0, 45)) end)

mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 320, 0, 220)}):Play()

print("[Race Bot] Delta Emülatör Fix Yüklendi! (3'lü Tıklama Motoru Aktif)")
