-- Muscle Legends Race Bot (Mobile/Delta/Emulator Fix)
-- Emoraldy için Patrick Jane Tarafından Özel Oluşturuldu

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- 1. KÜÇÜK VE ŞIK MOBİL GUI (Göz Kapatmayan)
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaceBot_Mobile_Fix"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- ==== ANA MENÜ (Küçültüldü) ====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 150) -- Mobil için daha küçük boyut
mainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

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
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Başlık ve Küçültme Butonu Yan Yana
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -45, 0, 30)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ RACE BOT | MOBILE"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 13
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- KÜÇÜLTME BUTONU (Göz kapatmasın diye)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -30, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- ==== KÜÇÜK AÇ/KAPAT BUTONU ====
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.85, 0, 0, 55)
toggleButton.Position = UDim2.new(0.075, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 30, 60) 
toggleButton.Text = "DURUM: KAPALI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.AutoButtonColor = false 
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
})
btnGradient.Rotation = 90
btnGradient.Parent = toggleButton

-- ==== YAZI (Mavi-Kırmızı Neon Geçişi) ====
local ownerLabel = Instance.new("TextLabel")
ownerLabel.Size = UDim2.new(1, 0, 0, 20)
ownerLabel.Position = UDim2.new(0, 0, 0.82, 0)
ownerLabel.BackgroundTransparency = 1
ownerLabel.Text = "Emoraldy için Patrick Jane tarafından özel yapıldı"
ownerLabel.Font = Enum.Font.GothamBold
ownerLabel.TextSize = 10
ownerLabel.Parent = mainFrame

-- Mavi ve Kırmızı Arası Geçiş Animasyonu
local t = 0
RunService.RenderStepped:Connect(function()
    t = (t + 0.01) % 1
    -- Sinüs dalgası ile 0 ve 1 arasında gidip gelir (Mavi <-> Kırmızı)
    local lerpValue = (math.sin(t * math.pi * 2) + 1) / 2 
    
    -- Neon Mavi: Color3.fromRGB(0, 150, 255)
    -- Neon Kırmızı: Color3.fromRGB(255, 20, 20)
    local neonColor = Color3.fromRGB(
        255 * lerpValue, 
        20 + (130 * (1 - lerpValue)), 
        255 * (1 - lerpValue)
    )
    
    ownerLabel.TextColor3 = neonColor
end)

-- ============================================================
-- 2. MİNİMİZE EDİLMİŞ HAL (Sadece Buton Kalır)
-- ============================================================
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 130, 0, 40)
miniFrame.Position = UDim2.new(0.5, -65, 0.8, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 8)
miniCorner.Parent = miniFrame

local miniToggleBtn = Instance.new("TextButton")
miniToggleBtn.Size = UDim2.new(0, 90, 0, 30)
miniToggleBtn.Position = UDim2.new(0, 5, 0, 5)
miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
miniToggleBtn.Text = "KAPALI"
miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniToggleBtn.Font = Enum.Font.GothamBold
miniToggleBtn.TextSize = 14
miniToggleBtn.AutoButtonColor = false
miniToggleBtn.Parent = miniFrame

local miniBtnCorner = Instance.new("UICorner")
miniBtnCorner.CornerRadius = UDim.new(0, 6)
miniBtnCorner.Parent = miniToggleBtn

local maximizeBtn = Instance.new("TextButton")
maximizeBtn.Size = UDim2.new(0, 30, 0, 30)
maximizeBtn.Position = UDim2.new(1, -35, 0, 5)
maximizeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
maximizeBtn.Text = "⬆"
maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
maximizeBtn.Font = Enum.Font.GothamBold
maximizeBtn.TextSize = 16
maximizeBtn.AutoButtonColor = false
maximizeBtn.Parent = miniFrame

local maxBtnCorner = Instance.new("UICorner")
maxBtnCorner.CornerRadius = UDim.new(0, 6)
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
-- 3. DURUM KONTROLÜ & YARDIMCI FONKSİYONLAR
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

-- ============================================================
-- 4. EMÜLATÖR & DELTA İÇİN GELİŞMİŞ TIKLAMA (Mor/Kırmızı Fix)
-- ============================================================
local function simulateClick()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = math.floor(viewportSize.X / 2)
    local centerY = math.floor(viewportSize.Y / 2)

    -- 1. Delta/Mobil Dokunmatik Tıklama
    pcall(function()
        local touch = Instance.new("TouchInput")
        UserInputService:SendTouchEvent(touch, 0, true, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
        task.wait(0.005)
        UserInputService:SendTouchEvent(touch, 0, false, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
    end)

    -- 2. Delta "is_mobile" bypass (Bazı executorlarda dokunmayı zorlar)
    pcall(function()
        if type(is_mobile) == "function" then
            is_mobile()
        end
    end)

    -- 3. EMÜLATÖR İÇİN FARE TIKLAMASI (En garantili yöntem)
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
        task.wait(0.005)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
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
-- 5. ANA BOT DÖNGÜSÜ (Mor ve Kırmızı Alanlar)
-- ============================================================
local function startBot()
    botThread = task.spawn(function()
        while isRunning do
            -- Aşama 1: Başlangıç
            if not isRunning then break end
            teleportTo(Vector3.new(-12875.3, 6.4, -4157.5))
            if not waitCancelable(10) then break end

            -- Aşama 2: Arabaya Gitme
            if not isRunning then break end
            teleportTo(Vector3.new(-13373.0, 12.3, -4144.4))
            if not waitCancelable(13) then break end

            -- Aşama 3: Mor Alan (19 sn bekle + 7 sn tıkla)
            if not isRunning then break end
            teleportTo(Vector3.new(-13803.8, 6.4, -4143.2))
            if not waitCancelable(19) then break end
            if not spamClickFor(7, 0.07, 0.08) then break end

            -- Aşama 4: Kırmızı Alan (7 sn tıkla)
            if not isRunning then break end
            teleportTo(Vector3.new(-13962.5, 6.4, -4143.1))
            task.wait(0.2) -- Karakterin oturması için kısa bekleme
            if not spamClickFor(7, 0.02, 0.03) then break end

            -- Aşama 5: Bitiş
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
-- 6. BUTON MANTIĞI (Animasyonlu)
-- ============================================================
local function updateUI(state)
    if state then
        toggleButton.Text = "DURUM: AÇIK"
        miniToggleBtn.Text = "AÇIK"
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 100)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 50)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 100))
        })
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        uiStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        toggleButton.Text = "DURUM: KAPALI"
        miniToggleBtn.Text = "KAPALI"
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 0)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
        })
        miniToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
        uiStroke.Color = Color3.fromRGB(150, 0, 255)
    end
end

local function onToggleClick()
    isRunning = not isRunning
    updateUI(isRunning)

    -- Buton Animasyonları
    local function animate(btn, origSize)
        local pressedSize = UDim2.new(origSize.X.Scale * 0.9, origSize.X.Offset * 0.9, origSize.Y.Scale * 0.9, origSize.Y.Offset * 0.9)
        local pressTween = TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = pressedSize})
        local releaseTween = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize})
        pressTween:Play()
        pressTween.Completed:Connect(function() releaseTween:Play() end)
    end

    animate(toggleButton, UDim2.new(0.85, 0, 0, 55))
    animate(miniToggleBtn, UDim2.new(0, 90, 0, 30))

    if isRunning then startBot() else stopBot() end
end

toggleButton.MouseButton1Click:Connect(onToggleClick)
miniToggleBtn.MouseButton1Click:Connect(onToggleClick)

print("[Race Bot] Emülatör Fix & Mobil Boyutlar Yüklendi! (Emoraldy Edition)")
