local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Allanursulino/ClimbAndJumpHub/main/MultiHubUILib.lua"))()

local Window = Library:CreateWindow({
    Title = "MultiHub - Climb And Jump Tower",
    Center = true,
    AutoShow = true
})

local Tabs = {
    Farming = Window:AddTab("Farming"),
}

-- Variáveis
local autoCoins = false
local heightAmount = 15000
local delaySeconds = 5

-- Input da Altura
Tabs.Farming:AddInput("HeightAmount", {
    Default = "15000",
    Numeric = true,
    Finished = true,
    Text = "Height Amount",
    Callback = function(value)
        heightAmount = tonumber(value)
    end
})

-- Slider de Delay
Tabs.Farming:AddSlider("AutoCoinsDelay", {
    Text = "Auto Coins Delay (s)",
    Min = 1,
    Max = 10,
    Default = 5,
    Rounding = 0,
    Callback = function(value)
        delaySeconds = value
    end
})

-- Toggle para ativar/desativar Auto Coins
Tabs.Farming:AddToggle("AutoCoins", {
    Text = "Auto Coins",
    Default = false,
    Callback = function(value)
        autoCoins = value
    end
})

-- Execução do Auto Coins
task.spawn(function()
    local remotePath = game:GetService("ReplicatedStorage"):WaitForChild("ProMsgs"):WaitForChild("RemoteEvent")
    local coinID = 8270931980779 -- ID real usado ao detectar JumpResults
    while true do
        if autoCoins then
            pcall(function()
                remotePath:FireServer("JumpResults", coinID, heightAmount)
            end)
        end
        task.wait(delaySeconds)
    end
end)
