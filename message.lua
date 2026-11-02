-- Muscle Legends Race Bot (PREMIUM EDITION - 1000x UI)
-- Delta Executor / Emülatör Uyumlu

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HapticService = game:GetService("HapticService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- 1. PREMIUM TASARIM (GLASSMORPHISM)
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaceBot_Premium"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true 
screenGui.Parent = playerGui

-- ==== ANA MENÜ ====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 310, 0, 200) -- Daha kompakt ve şık
mainFrame.Position = UDim2.new(0.5, -155, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BackgroundTransparency = 0.15 -- Buzlu cam efekti
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = mainFrame

-- Yumuşak Geçişli Arka Plan
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 35)), 
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 20))     
})
bgGradient.Rotation = 45
bgGradient.Parent = mainFrame

-- İnce ve Şık Çerçeve
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(80, 80, 90) 
uiStroke.Thickness = 1.5
uiStroke.Transparency = 0.3
uiStroke.Parent = mainFrame

-- ==== BAŞLIK ====
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 0, 40)
titleLabel.Position = UDim2.new(0, 20, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Race Bot"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
titleLabel.Font = Enum.Font.GothamMedium
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- ==== KÜÇÜLTME BUTONU (Daha zarif) ====
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

-- ==== ANA TIKLAMA BUTONU ====
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.85, 0, 0, 75)
toggleButton.Position = UDim2.new(0.075, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.Text = "DURUM: KAPALI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.AutoButtonColor = false
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = toggleButton

-- Butonun göz almayan yumuşak gölgesi
local btnShadow = Instance.new("UIStroke")
btnShadow.Color = Color3.fromRGB(0, 0, 0)
btnShadow.Thickness = 2
btnShadow.Transparency = 0.5
btnShadow.Parent = toggleButton

-- ==== PREMIUM PATRICKJANE (Yumuşak Gökkuşağı) ====
local ownerFrame = Instance.new("Frame")
ownerFrame.Size = UDim2.new(0.85, 0, 0, 25)
ownerFrame.Position = UDim2.new(0.075, 0, 0.82, 0)
ownerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ownerFrame.BackgroundTransparency = 0.7
ownerFrame.Parent = mainFrame

local ownerCorner = Instance.new("UICorner")
ownerCorner.CornerRadius = UDim.new(0, 6)
ownerCorner.Parent = ownerFrame

local ownerLabel = Instance.new("TextLabel")
ownerLabel.Size = UDim2.new(1, 0, 1, 0)
ownerLabel.BackgroundTransparency = 1
ownerLabel.Text = "Developer: PatrickJane"
ownerLabel.Font = Enum.Font.GothamMedium
ownerLabel.TextSize = 13
ownerLabel.Parent = ownerFrame

local ownerGlow = Instance.new("UIStroke")
ownerGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
ownerGlow.Thickness = 1
ownerGlow.Transparency = 0.3
ownerGlow.Parent = ownerLabel

-- Yumuşak Gökkuşağı Döngüsü (Hızlı değil, göz yormayan)
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.003) % 1 -- Yavaş ve rahatsız etmeyen hız
    -- Pastel tonlar (Doygunluk düşürüldü: 0.6)
    local rainbowColor = Color3.fromHSV(hue, 0.6, 1) 
    ownerLabel.TextColor3 = rainbowColor
    ownerGlow.Color = rainbowColor 
end)

-- ============================================================
-- 2. YÜZEN MİNİ KONTROLCÜ (Ultra Şeffaf)
-- ============================================================
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 160, 0, 45)
miniFrame.Position = UDim2.new(0, 20, 0.5, -22)
miniFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
miniFrame.BackgroundTransparency = 0.3
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 15)
miniCorner.Parent = miniFrame

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(80, 80, 90)
miniStroke.Thickness = 1
miniStroke.Transparency = 0.5
miniStroke.Parent = miniFrame

local miniToggleBtn = Instance.new("TextButton")
miniToggleBtn.Size = UDim2.new(0, 110, 0, 35)
miniToggleBtn.Position = UDim2.new(0, 5, 0, 5)
miniToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
miniToggleBtn.Text = "KAPALI"
miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniToggleBtn.Font = Enum.Font.GothamBold
miniToggleBtn.TextSize = 15
miniToggleBtn.AutoButtonColor = false
miniToggleBtn.Parent = miniFrame

local miniBtnCorner = Instance.new("UICorner")
miniBtnCorner.CornerRadius = UDim.new(0, 10)
miniBtnCorner.Parent = miniToggleBtn

local maximizeBtn = Instance.new("TextButton")
maximizeBtn.Size = UDim2.new(0, 35, 0, 35)
maximizeBtn.Position = UDim2.new(1, -40, 0, 5)
maximizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
maximizeBtn.Text = "⬆"
maximizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
maximizeBtn.Font = Enum.Font.GothamBold
maximizeBtn.TextSize = 18
maximizeBtn.AutoButtonColor = false
maximizeBtn.Parent = miniFrame

local maxBtnCorner = Instance.new("UICorner")
maxBtnCorner.CornerRadius = UDim.new(0, 10)
maxBtnCorner.Parent = maximizeBtn

-- Menü Geçiş Animasyonları (Yumuşak Yaylanma)
local function toggleMenuVisibility(showMain)
    if showMain then
        miniFrame.Visible = false
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 280, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 310, 0, 200)}):Play()
    else
        mainFrame.Visible = false
        miniFrame.Visible = true
        miniFrame.Size = UDim2.new(0, 100, 0, 0)
        TweenService:Create(miniFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 160, 0, 45)}):Play()
    end
end

minimizeBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(false) end)
maximizeBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(true) end)

-- Dokunmatik Titreşim
local function vibrate()
    pcall(function()
        if HapticService:IsVibrationSupported(Enum.UserInputType.Touch) then
            HapticService:SetMotor(Enum.UserInputType.Touch, Enum.VibrationMotor.Small, 0.4)
            task.wait(0.05)
            HapticService:SetMotor(Enum.UserInputType.Touch, Enum.VibrationMotor.Small, 0)
        end
    end)
end

-- ============================================================
-- 3. BOT MANTIĞI & TIKLAMA
-- ============================================================
local isRunning = false
local botThread = nil

local function getCharacter() return player.Character or player.CharacterAdded:Wait() end
local function getHumanoidRootPart() return getCharacter():WaitForChild("HumanoidRootPart") end
local function teleportTo(position) getHumanoidRootPart().CFrame = CFrame.new(position) end

local function waitCancelable(seconds)
    local elapsed = 0
    while elapsed < seconds do
        if not isRunning then return false end
        task.wait(0.02)
        elapsed = elapsed + 0.02
    end
    return true
end

-- EMÜLATÖR & MOBİL İÇİN 3'LÜ TIKLAMA SİSTEMİ
local function simulateClick()
    local vp = workspace.CurrentCamera.ViewportSize
    local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)

    -- 1. Fare (Emülatör)
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
        task.wait(0.01)
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
    end)
    -- 2. Dokunmatik (Mobil)
    pcall(function()
        local touch = Instance.new("TouchInput")
        UserInputService:SendTouchEvent(touch, 0, true, Vector2.new(x, y), Vector2.new(x, y), Vector2.new(0,0), false)
        task.wait(0.01)
        UserInputService:SendTouchEvent(touch, 0, false, Vector2.new(x, y), Vector2.new(x, y), Vector2.new(0,0), false)
    end)
    -- 3. Delta Bypass
    pcall(function()
        if type(is_mobile) == "function" then is_mobile() end
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

local function startBot()
    botThread = task.spawn(function()
        while isRunning do
            -- 1. Başlangıç
            if not isRunning then break end
            teleportTo(Vector3.new(-12875.3, 6.4, -4157.5))
            if not waitCancelable(10) then break end

            -- 2. Arabaya Gitme
            if not isRunning then break end
            teleportTo(Vector3.new(-13373.0, 12.3, -4144.4))
            if not waitCancelable(13) then break end

            -- 3. Mor Alan (19 sn bekle + 7 sn tıkla)
            if not isRunning then break end
            teleportTo(Vector3.new(-13803.8, 6.4, -4143.2))
            if not waitCancelable(19) then break end
            if not spamClickFor(7, 0.07, 0.08) then break end

            -- 4. Kırmızı Alan (7 sn tıkla)
            if not isRunning then break end
            teleportTo(Vector3.new(-13962.5, 6.4, -4143.1))
            task.wait(0.2)
            if not spamClickFor(7, 0.02, 0.03) then break end

            -- 5. Bitiş
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
-- 4. BUTON DURUMLARI & ANİMASYON
-- ============================================================
local function updateUI(state)
    if state then
        toggleButton.Text = "DURUM: AÇIK"
        miniToggleBtn.Text = "AÇIK"
        
        -- Yumuşak Yeşil
        TweenService:Create(toggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 160, 90)}):Play()
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 90)
        uiStroke.Color = Color3.fromRGB(45, 160, 90) -- Çerçeve yeşil olur
    else
        toggleButton.Text = "DURUM: KAPALI"
        miniToggleBtn.Text = "KAPALI"
        
        -- Yumuşak Kırmızı
        TweenService:Create(toggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        uiStroke.Color = Color3.fromRGB(80, 80, 90) -- Çerçeve griye döner
    end
end

local function onToggleClick(btn, origSize)
    isRunning = not isRunning
    updateUI(isRunning)
    vibrate()

    -- Tıklama "Press" Animasyonu
    local pressedSize = UDim2.new(origSize.X.Scale * 0.92, origSize.X.Offset * 0.92, origSize.Y.Scale * 0.92, origSize.Y.Offset * 0.92)
    local pressTween = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = pressedSize})
    local releaseTween = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize})
    
    pressTween:Play()
    pressTween.Completed:Connect(function() releaseTween:Play() end)

    if isRunning then startBot() else stopBot() end
end

toggleButton.MouseButton1Click:Connect(function() onToggleClick(toggleButton, UDim2.new(0.85, 0, 0, 75)) end)
miniToggleBtn.MouseButton1Click:Connect(function() onToggleClick(miniToggleBtn, UDim2.new(0, 110, 0, 35)) end)

-- Açılış Animasyonu (Ekrana tatlı bir şekilde oturur)
mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 310, 0, 200)}):Play()

print("[Race Bot] PREMIUM EDITION (1000x UI) Yüklendi! (PatrickJane)")
