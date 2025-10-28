--[[
    UltimateRobloxHack.lua - Скрипт для создания хаоса с меню!
    ВНИМАНИЕ: Это концептуальный скрипт. Он требует доработки
    для конкретной игры и обхода анти-чита. Использование на свой страх и риск!
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")

-- /////////////////////////////////////////////////////////////////////////////
-- // ПЕРЕМЕННЫЕ И ФУНКЦИИ ДЛЯ МЕНЮ //
-- /////////////////////////////////////////////////////////////////////////////
local menuEnabled = false -- Изначально меню выключено
local flyEnabled = false
local aimbotEnabled = false
local rapidFireEnabled = false
local flySpeed = 50

-- Функция для создания кнопки в меню
local function createButton(frame, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.1, 0)
    button.Position = UDim2.new(0.05, 0, 0.1 * (frame:GetChildrenCount() - 1), 0)
    button.Text = text
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = frame
    button.MouseButton1Click:Connect(callback)
    return button
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИИ ПОЛЕТА, АВТОНАВОДКИ И БЫСТРОЙ СТРЕЛЬБЫ //
-- // (Как и раньше, но используем глобальные переменные) //
-- /////////////////////////////////////////////////////////////////////////////

local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        Humanoid.PlatformStand = true
        RootPart.Anchored = true
        print("Полет активирован! Лети и сеешь хаос! 😈")
    else
        Humanoid.PlatformStand = false
        RootPart.Anchored = false
        print("Полет деактивирован. Возвращайся на грешную землю. 😠")
    end
end

local aimbotTarget = nil
local maxDistance = 300

local function findNearestEnemy()
    local nearestEnemy = nil
    local minDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            re: ON"
                else
                    child.Text = "Rapid Fire: OFF"
                end
                break
            end
        end
    end)

    return screenGui -- Возвращаем GUI, чтобы можно было его удалить
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ ВКЛЮЧЕНИЯ/ВЫКЛЮЧЕНИЯ МЕНЮ //
-- /////////////////////////////////////////////////////////////////////////////
local hackMenu = nil -- Храним ссылку на меню
local function toggleMenu()
    menuEnabled = not menuEnabled
    if menuEnabled then
        print("Меню активировано!")
        if not hackMenu then -- Создаем меню только если его еще нет
            hackMenu = createMenu()
        else
            hackMenu.Enabled = true  -- Просто делаем видимым, если оно уже создано
        end
    else
        print("Меню деактивировано!")
        if hackMenu then
            hackMenu.Enabled = false -- Делаем невидимым, не удаляем
        end
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // УПРАВЛЕНИЕ (Привязка к кнопкам) //
-- /////////////////////////////////////////////////////////////////////////////

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    -- Кнопка "Insert" для включения/выключения меню
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleMenu()
    end
end)

-- /////////////////////////////////////////////////////////////////////////////
-- // ГЛАВНЫЙ ЦИКЛ //
-- /////////////////////////////////////////////////////////////////////////////

game:GetService("RunService").RenderStepped:Connect(function()
    if flyEnabled then
        -- Перемещаем персонажа вверх
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, flySpeed * 0.01, 0)
    end
    if aimbotEnabled then
        updateAimbot() -- Обновляем автонаводку каждый кадр
    end
end)

print("Скрипт загружен. Да начнется хаос! 😈")
local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                local distance = (RootPart.Position - enemyRoot.Position).magnitude
                if distance < minDistance and distance < maxDistance then
                    minDistance = distance
                    nearestEnemy = enemyRoot
                end
            end
        end
    end
    return nearestEnemy
end

local function updateAimbot()
    if aimbotEnabled then
        aimbotTarget = findNearestEnemy()
        if aimbotTarget then
            -- Наводим камеру на цель
            local lookVector = (aimbotTarget.Position - RootPart.Position).Unit
      local cam = game:GetService("Workspace").CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.p, cam.CFrame.p + lookVector)
            -- Здесь можно добавить логику для стрельбы, если у тебя есть оружие
        end
    end
end

local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        print("Автонаводка активирована! Уничтожай их всех! 😈")
    else
        aimbotTarget = nil
        print("Автонаводка деактивирована. Теперь ты сам по себе, ублюдок. 😠")
    end
end

local function toggleRapidFire()
    rapidFireEnabled = not rapidFireEnabled
    if rapidFireEnabled then
        print("Быстрая стрельба активирована! Залей их свинцом! 😈")
    else
        print("Быстрая стрельба деактивирована. Снова как обычный смертный. 😠")
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ ДЛЯ СОЗДАНИЯ МЕНЮ //
-- /////////////////////////////////////////////////////////////////////////////

local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UltimateHackMenu"
    screenGui.Parent = LocalPlayer.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
    mainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.Draggable = true

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "UltimateHack Menu"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Parent = mainFrame

    createButton(mainFrame, "Fly: OFF", function()
        toggleFly()
        -- Обновляем текст кнопки
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text:sub(1, 3) == "Fly" then
                if flyEnabled then
                    child.Text = "Fly: ON"
                else
                    child.Text = "Fly: OFF"
                end
                break
            end
        end
    end)

    createButton(mainFrame, "Aimbot: OFF", function()
        toggleAimbot()
        -- Обновляем текст кнопки
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text:sub(1, 6) == "Aimbot" then
                if aimbotEnabled then
                    child.Text = "Aimbot: ON"
                else
                    child.Text = "Aimbot: OFF"
                end
                break
            end
        end
    end)

    createButton(mainFrame, "Rapid Fire: OFF", function()
        toggleRapidFire()
        -- Обновляем текст кнопки
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Text:sub(1, 10) == "Rapid Fire" then
                if rapidFireEnabled then
                    child.Text = "Rapid Fi
