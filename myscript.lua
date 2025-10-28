--[[
    UltimateRobloxHack.lua - Скрипт для создания хаоса с меню!
    ВНИМАНИЕ: Это концептуальный скрипт. Он требует доработки
    для конкретной игры и обхода анти-чита. Использование на свой страх и риск!

    Этот блок кода предназначен для вставки в конец другого скрипта.
    Он является самодостаточным и не должен конфликтовать с большинством
    других скриптов, если они не используют те же имена локальных переменных
    или не переопределяют глобальные сервисы Roblox.
]]--

-- /////////////////////////////////////////////////////////////////////////////
-- // ИНИЦИАЛИЗАЦИЯ СЕРВИСОВ И ПЕРСОНАЖА (для этого скрипта) //
-- // Это нужно, чтобы скрипт работал независимо, даже если основной скрипт
-- // не передает эти переменные.
-- /////////////////////////////////////////////////////////////////////////////
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- Ожидаем загрузки персонажа, если он еще не появился
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")

-- /////////////////////////////////////////////////////////////////////////////
-- // ПЕРЕМЕННЫЕ СОСТОЯНИЯ ДЛЯ ФУНКЦИЙ ХАКА //
-- /////////////////////////////////////////////////////////////////////////////
local menuEnabled = false -- Изначально меню выключено
local flyEnabled = false
local aimbotEnabled = false
local rapidFireEnabled = false
local flySpeed = 50 -- Скорость полета

-- /////////////////////////////////////////////////////////////////////////////
-- // ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ ДЛЯ СОЗДАНИЯ КНОПОК МЕНЮ //
-- /////////////////////////////////////////////////////////////////////////////
local function createButton(frame, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.1, 0)
    -- Используем UIListLayout для автоматического размещения кнопок
    local layout = frame:FindFirstChildOfClass("UIListLayout")
    if not layout then
        layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Padding = UDim.new(0, 5) -- Небольшой отступ между кнопками
        layout.Parent = frame
    end
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
-- // ФУНКЦИИ ХАКА (ПОЛЕТ, АВТОНАВОДКА, БЫСТРАЯ СТРЕЛЬБА) //
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
local maxDistance = 300 -- Максимальная дистанция для автонаводки

local function findNearestEnemy()
    local nearestEnemy = nil
    local minDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
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
        -- Здесь нужно найти скрипт оружия и изменить его задержку стрельбы (очень сложно и зависит от игры!)
        -- Это требует глубокого анализа конкретного скрипта оружия в игре.
    else
        print("Быстрая стрельба деактивирована. Снова как обычный смертный. 😠")
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ ДЛЯ СОЗДАНИЯ ГРАФИЧЕСКОГО ИНТЕРФЕЙСА МЕНЮ //
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
    mainFrame.Draggable = true -- Делаем меню перетаскиваемым

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "UltimateHack Menu"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    title
    Label.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Parent = mainFrame

    -- Добавляем UIListLayout для автоматического размещения кнопок под заголовком
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 5) -- Отступ 5 пикселей
    layout.Parent = mainFrame
    -- Устанавливаем отступ для первого элемента (кнопок) от заголовка
    layout.AbsoluteContentOffset = Vector2.new(0, titleLabel.AbsoluteSize.Y + 5)


    -- Кнопка для полета
    local flyButton = createButton(mainFrame, "Fly: OFF", function()
        toggleFly()
        flyButton.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    end)

    -- Кнопка для автонаводки
    local aimbotButton = createButton(mainFrame, "Aimbot: OFF", function()
        toggleAimbot()
        aimbotButton.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    end)

    -- Кнопка для быстрой стрельбы
    local rapidFireButton = createButton(mainFrame, "Rapid Fire: OFF", function()
        toggleRapidFire()
        rapidFireButton.Text = "Rapid Fire: " .. (rapidFireEnabled and "ON" or "OFF")
    end)

    return screenGui -- Возвращаем GUI, чтобы можно было его управлять
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ ВКЛЮЧЕНИЯ/ВЫКЛЮЧЕНИЯ ВИДИМОСТИ МЕНЮ //
-- /////////////////////////////////////////////////////////////////////////////
local hackMenu = nil -- Храним ссылку на созданное меню
local function toggleMenu()
    menuEnabled = not menuEnabled
    if menuEnabled then
        print("Меню активировано!")
        if not hackMenu then -- Если меню еще не создано, создаем его
            hackMenu = createMenu()
        else
            hackMenu.Enabled = true -- Если создано, просто делаем видимым
        end
    else
        print("Меню деактивировано!")
        if hackMenu then
            hackMenu.Enabled = false -- Делаем невидимым
        end
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ОБРАБОТКА ВВОДА ПОЛЬЗОВАТЕЛЯ (Кнопка для меню) //
-- /////////////////////////////////////////////////////////////////////////////

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    -- Кнопка "Insert" для включения/выключения меню
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleMenu()
    end
end)

-- /////////////////////////////////////////////////////////////////////////////
-- // ГЛАВНЫЙ ЦИКЛ ОБНОВЛЕНИЯ ФУНКЦИЙ ХАКА //
-- /////////////////////////////////////////////////////////////////////////////

game:GetService("RunService").RenderStepped:Connect(function()
    if flyEnabled then
        -- Перемещаем персонажа вверх, если полет активен
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, flySpeed * 0.01, 0)
    end
    if aimbotEnabled then
        updateAimbot() -- Обновляем автонаводку каждый кадр, если активна
    end
end)

print("Скрипт загружен. Да начнется хаос! 😈")
