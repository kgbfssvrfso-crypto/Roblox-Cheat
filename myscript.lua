--[[
    UltimateRobloxHack.lua - Скрипт для создания хаоса в Roblox
    ВНИМАНИЕ: Это концептуальный скрипт. Он требует доработки
    для конкретной игры и обхода анти-чита. Использование на свой страх и риск!
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ ПОЛЕТА (Fly) //
-- /////////////////////////////////////////////////////////////////////////////
local flying = false
local flySpeed = 50 -- Скорость полета, можешь менять, ублюдок!

local function toggleFly()
    flying = not flying
    if flying then
        Humanoid.PlatformStand = true
        RootPart.Anchored = true
        print("Полет активирован! Лети и сеешь хаос! 😈")
    else
        Humanoid.PlatformStand = false
        RootPart.Anchored = false
        print("Полет деактивирован. Возвращайся на грешную землю. 😠")
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ АВТОНАВОДКИ (Aimbot) //
-- /////////////////////////////////////////////////////////////////////////////
local aimbotEnabled = false
local aimbotTarget = nil
local maxDistance = 300 -- Максимальная дистанция для автонаводки, меняй!

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

-- /////////////////////////////////////////////////////////////////////////////
-- // ФУНКЦИЯ БЫСТРОЙ СТРЕЛЬБЫ (Rapid Fire) //
-- /////////////////////////////////////////////////////////////////////////////
local rapidFireEnabled = false

local function toggleRapidFire()
    rapidFireEnabled = not rapidFireEnabled
    if rapidFireEnabled then
        print("Быстрая стрельба активирована! Залей их свинцом! 😈")
        -- Здесь нужно найти скрипт оружия и изменить его задержку стрельбы (очень сложно и зависит от игры!)
        -- Например, если у оружия есть свойство Cooldown или FireRate, его можно попытаться изменить.
        -- Это требует глубокого анализа конкретного скрипта оружия в игре.
    else
        print("Быстрая стрельба деактивирована. Снова как обычный смертный. 😠")
    end
end

-- /////////////////////////////////////////////////////////////////////////////
-- // УПРАВЛЕНИЕ (Привязка к кнопкам) //
-- /////////////////////////////////////////////////////////////////////////////
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    -- Пример: Кнопка "F" для полета
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end

    -- Пример: Кнопка "E" для автонаводки
    if input.KeyCode == Enum.KeyCode.E then
        toggleAimbot()
    end

    -- Пример: Кнопка "R" для быстрой стрельбы
    if input.KeyCode == Enum.KeyCode.R then
        toggleRapidFire()
    end
end)

-- /////////////////////////////////////////////////////////////////////////////
-- // ГЛАВНЫЙ ЦИКЛ //
-- /////////////////////////////////////////////////////////////////////////////
game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        -- Перемещаем персонажа вверх
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, flySpeed * 0.01, 0)
    end
    updateAimbot() -- Обновляем автонаводку каждый кадр
end)

print("Скрипт загружен. Да начнется хаос! 😈")
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
