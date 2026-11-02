-- Muscle Legends Race Bot (Chill, Halloween & Pure Horror Glitch Mode - Drag FIX)
-- Emoraldy için Patrick Jane Tarafından Özel Oluşturuldu

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- 0. MÜZİKLER
-- ============================================================
local chillMusic = Instance.new("Sound")
chillMusic.Name = "ChillMusic"
chillMusic.SoundId = "rbxassetid://133163424285039" 
chillMusic.Volume = 0.5
chillMusic.Looped = true
chillMusic.Parent = SoundService

local halloweenMusic = Instance.new("Sound")
halloweenMusic.Name = "HalloweenMusic"
halloweenMusic.SoundId = "rbxassetid://1836009626" 
halloweenMusic.Volume = 0.5
halloweenMusic.Looped = true
halloweenMusic.Parent = SoundService

local errorMusic = Instance.new("Sound")
errorMusic.Name = "ErrorMusic"
errorMusic.SoundId = "rbxassetid://127750570596967" 
errorMusic.Volume = 0.5
errorMusic.Looped = true
errorMusic.Parent = SoundService

-- ============================================================
-- 1. SEÇİM EKRANI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModeSelectionGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local selectionFrame = Instance.new("Frame")
selectionFrame.Size = UDim2.new(0, 320, 0, 220)
selectionFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
selectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
selectionFrame.BorderSizePixel = 0
selectionFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = selectionFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(150, 0, 255)
uiStroke.Thickness = 3
uiStroke.Parent = selectionFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Hangi Modu Seçmek İstersin?"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = selectionFrame

-- Chill Mode
local chillBtn = Instance.new("TextButton")
chillBtn.Size = UDim2.new(0.4, 0, 0, 45)
chillBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
chillBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
chillBtn.Text = "Chill Mode"
chillBtn.TextColor3 = Color3.fromRGB(50, 50, 50)
chillBtn.Font = Enum.Font.GothamBold
chillBtn.TextSize = 15
chillBtn.Parent = selectionFrame

local chillCorner = Instance.new("UICorner")
chillCorner.CornerRadius = UDim.new(0, 10)
chillCorner.Parent = chillBtn

-- Halloween Mode
local halloweenBtn = Instance.new("TextButton")
halloweenBtn.Size = UDim2.new(0.4, 0, 0, 45)
halloweenBtn.Position = UDim2.new(0.55, 0, 0.35, 0)
halloweenBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0) 
halloweenBtn.Text = "Halloween Mode"
halloweenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
halloweenBtn.Font = Enum.Font.GothamBold
halloweenBtn.TextSize = 14
halloweenBtn.Parent = selectionFrame

local halloweenCorner = Instance.new("UICorner")
halloweenCorner.CornerRadius = UDim.new(0, 10)
halloweenCorner.Parent = halloweenBtn

-- Glitch / Error Mode
local glitchBtn = Instance.new("TextButton")
glitchBtn.Size = UDim2.new(0.4, 0, 0, 45)
glitchBtn.Position = UDim2.new(0.3, 0, 0.75, 0)
glitchBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
glitchBtn.Text = "???"
glitchBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
glitchBtn.Font = Enum.Font.GothamBlack
glitchBtn.TextSize = 22
glitchBtn.AutoButtonColor = false
glitchBtn.Parent = selectionFrame

local glitchCorner = Instance.new("UICorner")
glitchCorner.CornerRadius = UDim.new(0, 5)
glitchCorner.Parent = glitchBtn

local glitchStroke = Instance.new("UIStroke")
glitchStroke.Color = Color3.fromRGB(255, 0, 0)
glitchStroke.Thickness = 1
glitchStroke.Transparency = 0.5
glitchStroke.Parent = glitchBtn

-- Seçim ekranı glitch animasyonu (Sadece yazı değişir)
local glitchTexts = {"???", "ERR0R", "FAIL", "NULL", "???_X", "LOST"}
task.spawn(function()
    while glitchBtn.Parent do
        task.wait(math.random(1, 3) / 10) 
        if math.random(1, 10) > 5 then
            glitchBtn.Text = glitchTexts[math.random(1, #glitchTexts)]
        else
            glitchBtn.Text = "???"
        end
        if math.random(1, 10) > 5 then
            glitchBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
            glitchBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
        else
            glitchBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            glitchBtn.TextColor3 = Color3.fromRGB(150, 0, 0)
        end
        glitchStroke.Transparency = math.random(0, 80) / 100
    end
end)

-- ============================================================
-- 2. ANA MENÜ VE EFEKT SİSTEMİ
-- ============================================================
local function createMainMenu(modeType)
    selectionFrame:Destroy()

    local isChillMode = (modeType == "chill")
    local isHalloweenMode = (modeType == "halloween")
    local isErrorMode = (modeType == "error")

    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "RaceBot_Main"
    mainGui.ResetOnSpawn = false
    mainGui.IgnoreGuiInset = true
    mainGui.Parent = playerGui

    -- YAĞIŞ EFEKTİ
    local isSnowing = true
    local effectContainer = nil

    local function startEffect()
        if effectContainer then return end
        effectContainer = Instance.new("Frame")
        effectContainer.Size = UDim2.new(1, 0, 1, 0)
        effectContainer.BackgroundTransparency = 1
        effectContainer.Parent = mainGui

        if isErrorMode then return end

        for i = 1, 50 do
            local particle = Instance.new("TextLabel")
            particle.BackgroundTransparency = 1
            
            if isChillMode then
                particle.Text = "❄"
                particle.TextColor3 = Color3.fromRGB(255, 255, 255)
                particle.TextSize = math.random(10, 20)
                particle.Font = Enum.Font.GothamBold
            else
                particle.Text = "🎃"
                particle.TextColor3 = Color3.fromRGB(255, 120, 0)
                particle.TextSize = math.random(15, 25)
                particle.Font = Enum.Font.GothamBold
            end
            
            particle.Size = UDim2.new(0, 20, 0, 20)
            local startX = math.random(0, 100) / 100
            local startY = math.random(-100, -10) / 100 
            particle.Position = UDim2.new(startX, 0, startY, 0)
            particle.Parent = effectContainer

            local speed = math.random(5, 15) 
            local targetY = 1.1 
            
            task.spawn(function()
                while particle.Parent do
                    if not isSnowing then break end 
                    local randomXOffset = (math.random(-10, 10) / 1000) 
                    local newX = particle.Position.X.Scale + randomXOffset
                    
                    local tween = TweenService:Create(particle, TweenInfo.new(speed, Enum.EasingStyle.Linear), {
                        Position = UDim2.new(newX, 0, targetY, 0)
                    })
                    tween:Play()
                    tween.Completed:Wait()
                    
                    if particle.Parent and isSnowing then
                        particle.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
                    end
                end
            end)
        end
    end

    local function stopEffect()
        if effectContainer then
            effectContainer:Destroy()
            effectContainer = nil
        end
    end

    startEffect() 

    -- ANA ÇERÇEVE
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 260, 0, 150)
    mainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
    
    local bgColor, strokeColor, textColor, btnClosedColor, btnClosedTextColor
    
    if isChillMode then
        bgColor = Color3.fromRGB(250, 250, 255)
        strokeColor = Color3.fromRGB(100, 200, 255)
        textColor = Color3.fromRGB(50, 50, 50)
        btnClosedColor = Color3.fromRGB(230, 235, 245)
        btnClosedTextColor = Color3.fromRGB(80, 100, 120)
    elseif isHalloweenMode then
        bgColor = Color3.fromRGB(25, 15, 30)
        strokeColor = Color3.fromRGB(255, 120, 0)
        textColor = Color3.fromRGB(255, 255, 255)
        btnClosedColor = Color3.fromRGB(60, 30, 20)
        btnClosedTextColor = Color3.fromRGB(255, 150, 50)
    else
        -- PURE HORROR THEME
        bgColor = Color3.fromRGB(5, 0, 0)
        strokeColor = Color3.fromRGB(255, 0, 0)
        textColor = Color3.fromRGB(255, 0, 0)
        btnClosedColor = Color3.fromRGB(20, 0, 0)
        btnClosedTextColor = Color3.fromRGB(150, 0, 0)
    end

    mainFrame.BackgroundColor3 = bgColor
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainGui

    local mCorner = Instance.new("UICorner")
    mCorner.CornerRadius = UDim.new(0, 12)
    mCorner.Parent = mainFrame

    if isChillMode then
        local bgGradient = Instance.new("UIGradient")
        bgGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),  
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(230, 245, 255)),  
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(210, 230, 255))     
        })
        bgGradient.Rotation = 45
        bgGradient.Parent = mainFrame
    elseif isHalloweenMode then
        local bgGradient = Instance.new("UIGradient")
        bgGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 10, 15)),  
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(15, 5, 10)),  
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))     
        })
        bgGradient.Rotation = 120
        bgGradient.Parent = mainFrame
    end

    local mStroke = Instance.new("UIStroke")
    mStroke.Color = strokeColor
    mStroke.Thickness = 2
    mStroke.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -45, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = isChillMode and "CHILL RACE BOT" or (isHalloweenMode and "HALLOWEEN RACE BOT" or "ERR0R_R4CE_B0T")
    titleLabel.TextColor3 = textColor
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 13
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = mainFrame

    -- İKON BUTONU
    if not isErrorMode then
        local effectIconBtn = Instance.new("TextButton")
        effectIconBtn.Size = UDim2.new(0, 20, 0, 20)
        effectIconBtn.Position = UDim2.new(0, 15, 0, 10) 
        effectIconBtn.BackgroundColor3 = isChillMode and Color3.fromRGB(200, 230, 255) or Color3.fromRGB(80, 30, 10)
        effectIconBtn.Text = isChillMode and "❄" or "🎃"
        effectIconBtn.TextColor3 = isChillMode and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(255, 150, 0)
        effectIconBtn.Font = Enum.Font.GothamBold
        effectIconBtn.TextSize = 12
        effectIconBtn.AutoButtonColor = false
        effectIconBtn.Parent = mainFrame
        
        local iconCorner = Instance.new("UICorner")
        iconCorner.CornerRadius = UDim.new(0, 4)
        iconCorner.Parent = effectIconBtn

        titleLabel.Position = UDim2.new(0, 40, 0, 5)

        effectIconBtn.MouseButton1Click:Connect(function()
            isSnowing = not isSnowing
            if isSnowing then
                startEffect()
                effectIconBtn.TextColor3 = isChillMode and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(255, 150, 0)
            else
                stopEffect()
                effectIconBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end)
    end

    -- MINIMIZE BUTONU
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    minimizeBtn.Position = UDim2.new(1, -30, 0, 5)
    
    if isErrorMode then
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        minimizeBtn.Text = "👁️" 
        minimizeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
        minimizeBtn.Font = Enum.Font.GothamBold
        minimizeBtn.TextSize = 16
        minimizeBtn.AutoButtonColor = false
        minimizeBtn.Parent = mainFrame
        
        local minCorner = Instance.new("UICorner")
        minCorner.CornerRadius = UDim.new(0, 4)
        minCorner.Parent = minimizeBtn
    else
        minimizeBtn.BackgroundColor3 = isChillMode and Color3.fromRGB(220, 220, 230) or Color3.fromRGB(200, 80, 20)
        minimizeBtn.Text = "−"
        minimizeBtn.TextColor3 = textColor
        minimizeBtn.Font = Enum.Font.GothamBold
        minimizeBtn.TextSize = 20
        minimizeBtn.AutoButtonColor = false
        minimizeBtn.Parent = mainFrame

        local minCorner = Instance.new("UICorner")
        minCorner.CornerRadius = UDim.new(0, 6)
        minCorner.Parent = minimizeBtn
    end

    -- AÇ/KAPAT BUTONU
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.85, 0, 0, 55)
    toggleButton.Position = UDim2.new(0.075, 0, 0.3, 0)
    toggleButton.BackgroundColor3 = btnClosedColor
    toggleButton.Text = isErrorMode and "SİSTEM: ÇÖKTÜ" or "DURUM: KAPALI"
    toggleButton.TextColor3 = btnClosedTextColor
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 18
    toggleButton.AutoButtonColor = false 
    toggleButton.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = toggleButton

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Parent = toggleButton

    -- ALT YAZI
    local ownerLabel = Instance.new("TextLabel")
    ownerLabel.Size = UDim2.new(1, 0, 0, 20)
    ownerLabel.Position = UDim2.new(0, 0, 0.82, 0)
    ownerLabel.BackgroundTransparency = 1
    ownerLabel.Text = isErrorMode and "Emoraldy PatrickJane Tarafından Katledildi" or "Emoraldy için Patrick Jane tarafından özel yapıldı"
    ownerLabel.Font = Enum.Font.GothamBold
    ownerLabel.TextSize = 10
    ownerLabel.TextColor3 = isChillMode and Color3.fromRGB(150, 160, 170) or (isHalloweenMode and Color3.fromRGB(255, 180, 100) or Color3.fromRGB(150, 0, 0))
    ownerLabel.Parent = mainFrame

    -- GLITCH YAZI SİSTEMİ (Sadece renk ve cümle değişir, harfler bozulmaz)
    if isErrorMode then
        local horrorTexts = {
            "Emoraldy PatrickJane Tarafından Katledildi",
            "Emoraldy Boğularak Öldü",
            "Emoraldy Yanarak Ateşe verildi"
        }
        
        task.spawn(function()
            while mainFrame.Parent do
                task.wait(0.3) -- Her 0.3 saniyede bir cümleyi değiştir
                
                -- Kenarlığı yakıp söndür (Glitch efekti)
                mStroke.Transparency = math.random(0, 80) / 100
                
                -- Cümleyi değiştir
                ownerLabel.Text = horrorTexts[math.random(1, #horrorTexts)]
                
                -- Rastgele renk değişimi (Kırmızı ve Koyu Kırmızı)
                if math.random(1, 10) > 5 then
                    ownerLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                else
                    ownerLabel.TextColor3 = Color3.fromRGB(100, 0, 0)
                end
            end
        end)
    end

    -- Minimize Frame
    local miniFrame = Instance.new("Frame")
    miniFrame.Size = UDim2.new(0, 130, 0, 40)
    miniFrame.Position = UDim2.new(0.5, -65, 0.8, 0)
    miniFrame.BackgroundColor3 = bgColor
    miniFrame.BorderSizePixel = 0
    miniFrame.Active = true
    miniFrame.Draggable = true
    miniFrame.Visible = false
    miniFrame.Parent = mainGui

    local miniCorner = Instance.new("UICorner")
    miniCorner.CornerRadius = UDim.new(0, 8)
    miniCorner.Parent = miniFrame

    local miniToggleBtn = Instance.new("TextButton")
    miniToggleBtn.Size = UDim2.new(0, 90, 0, 30)
    miniToggleBtn.Position = UDim2.new(0, 5, 0, 5)
    miniToggleBtn.BackgroundColor3 = btnClosedColor
    miniToggleBtn.Text = isErrorMode and "ÇÖKTÜ" or "KAPALI"
    miniToggleBtn.TextColor3 = btnClosedTextColor
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
    maximizeBtn.BackgroundColor3 = isErrorMode and Color3.fromRGB(100, 0, 0) or Color3.fromRGB(0, 150, 50)
    maximizeBtn.Text = "⬆"
    maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeBtn.Font = Enum.Font.GothamBold
    maximizeBtn.TextSize = 16
    maximizeBtn.AutoButtonColor = false
    maximizeBtn.Parent = miniFrame

    local maxBtnCorner = Instance.new("UICorner")
    maxBtnCorner.CornerRadius = UDim.new(0, 6)
    maxBtnCorner.Parent = maximizeBtn

    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        miniFrame.Visible = true
    end)

    maximizeBtn.MouseButton1Click:Connect(function()
        miniFrame.Visible = false
        mainFrame.Visible = true
    end)

    -- Normal Modlar için Renk Animasyonu
    if not isErrorMode then
        local t = 0
        RunService.RenderStepped:Connect(function()
            t = (t + 0.01) % 1
            local lerpValue = (math.sin(t * math.pi * 2) + 1) / 2 
            
            if isChillMode then
                local r = 150 + (105 * lerpValue)
                local g = 200 + (55 * lerpValue)
                local b = 255
                ownerLabel.TextColor3 = Color3.fromRGB(r, g, b)
            elseif isHalloweenMode then
                local r = 200 + (55 * lerpValue)
                local g = 100 + (50 * lerpValue)
                local b = 0
                ownerLabel.TextColor3 = Color3.fromRGB(r, g, b)
            end
        end)
    end

    -- DURUM & YARDIMCI FONKSİYONLAR
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

    local function simulateClick()
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local centerX = math.floor(viewportSize.X / 2)
        local centerY = math.floor(viewportSize.Y / 2)

        pcall(function()
            local touch = Instance.new("TouchInput")
            UserInputService:SendTouchEvent(touch, 0, true, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
            task.wait(0.005)
            UserInputService:SendTouchEvent(touch, 0, false, Vector2.new(centerX, centerY), Vector2.new(centerX, centerY), Vector2.new(0,0), false)
        end)
        pcall(function()
            if type(is_mobile) == "function" then is_mobile() end
        end)
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

    local function startBot()
        botThread = task.spawn(function()
            while isRunning do
                if not isRunning then break end
                teleportTo(Vector3.new(-12875.3, 6.4, -4157.5))
                if not waitCancelable(10) then break end

                if not isRunning then break end
                teleportTo(Vector3.new(-13373.0, 12.3, -4144.4))
                if not waitCancelable(13) then break end

                if not isRunning then break end
                teleportTo(Vector3.new(-13803.8, 6.4, -4143.2))
                if not waitCancelable(19) then break end
                if not spamClickFor(7, 0.07, 0.08) then break end

                if not isRunning then break end
                teleportTo(Vector3.new(-13962.5, 6.4, -4143.1))
                task.wait(0.2)
                if not spamClickFor(7, 0.02, 0.03) then break end

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

    local function updateUI(state)
        if state then
            toggleButton.Text = isErrorMode and "SİSTEM: AKTİF" or "DURUM: AÇIK"
            miniToggleBtn.Text = isErrorMode and "AKTİF" or "AÇIK"
            if isChillMode then
                toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
                toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                miniToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
                miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                mStroke.Color = Color3.fromRGB(100, 200, 255)
            else
                btnGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 100)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 100))
                })
                miniToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
                miniToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                mStroke.Color = Color3.fromRGB(0, 255, 0)
            end
        else
            toggleButton.Text = isErrorMode and "SİSTEM: ÇÖKTÜ" or "DURUM: KAPALI"
            miniToggleBtn.Text = isErrorMode and "ÇÖKTÜ" or "KAPALI"
            if isChillMode then
                toggleButton.BackgroundColor3 = btnClosedColor
                toggleButton.TextColor3 = btnClosedTextColor
                miniToggleBtn.BackgroundColor3 = btnClosedColor
                miniToggleBtn.TextColor3 = btnClosedTextColor
                mStroke.Color = Color3.fromRGB(100, 200, 255)
            else
                btnGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 50, 50)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 50, 50))
                })
                miniToggleBtn.BackgroundColor3 = btnClosedColor
                miniToggleBtn.TextColor3 = btnClosedTextColor
                mStroke.Color = Color3.fromRGB(255, 0, 0)
            end
        end
    end

    local function onToggleClick()
        isRunning = not isRunning
        updateUI(isRunning)

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
    
    updateUI(false)
end

-- SEÇİM BUTONLARININ MANTIĞI
chillBtn.MouseButton1Click:Connect(function()
    chillMusic:Play()
    halloweenMusic:Stop()
    errorMusic:Stop()
    selectionFrame:Destroy()
    createMainMenu("chill")
end)

halloweenBtn.MouseButton1Click:Connect(function()
    halloweenMusic:Play()
    chillMusic:Stop()
    errorMusic:Stop()
    selectionFrame:Destroy()
    createMainMenu("halloween")
end)

glitchBtn.MouseButton1Click:Connect(function()
    errorMusic:Play()
    chillMusic:Stop()
    halloweenMusic:Stop()
    selectionFrame:Destroy()
    createMainMenu("error")
end)

print("[Race Bot] Pure Horror Glitch Modu (Drag Fix) Yüklendi! (Emoraldy Edition)")
