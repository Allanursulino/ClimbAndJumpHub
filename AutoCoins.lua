-- Interface personalizada com Auto Coins funcional configurável

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Allanursulino/UILibs/main/Interface.lua"))()
local Window = Library:CreateWindow("MultiHub - Auto Coins")
local Tab = Window:CreateTab("Farm")

-- Variáveis ajustáveis
local autoCoins = false
local heightAmount = 15000
local delaySeconds = 5

local remote = game:GetService("ReplicatedStorage"):WaitForChild("ProMsgs"):WaitForChild("RemoteEvent")
local coinID = 8270931980779 -- ID do objeto para coleta

-- Loop Auto Coins
local function startAutoCoins()
    while autoCoins and task.wait(delaySeconds) do
        pcall(function()
            remote:FireServer("JumpResults", coinID, heightAmount)
        end)
    end
end

-- Toggle Auto Coins
Tab:CreateToggle("Ativar Auto Coins", false, function(state)
    autoCoins = state
    if state then
        startAutoCoins()
    end
end)

-- Slider para altura
Tab:CreateSlider("Height Amount", 0, 30000, heightAmount, function(val)
    heightAmount = val
end)

-- Slider para delay
Tab:CreateSlider("Delay (segundos)", 1, 30, delaySeconds, function(val)
    delaySeconds = val
end)
