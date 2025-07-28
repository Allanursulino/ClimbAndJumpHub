-- Auto Coins com interface própria (sem Rayfield / sem key)

-- Interface
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AutoCoinsUI"

Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 200, 0, 120)
Main.Position = UDim2.new(0, 10, 0, 200)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

UICorner.Parent = Main

Title.Parent = Main
Title.Text = "MultiHub - Auto Coins"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 14

Toggle.Parent = Main
Toggle.Text = "Ativar Auto Coins"
Toggle.Size = UDim2.new(0, 160, 0, 40)
Toggle.Position = UDim2.new(0, 20, 0, 50)
Toggle.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 14

-- Lógica do Auto Coins
local ativo = false
local remotePath = game:GetService("ReplicatedStorage"):WaitForChild("ProMsgs"):WaitForChild("RemoteEvent")
local coinID = 144225483827
local altura = 120

local function autoCoins()
    while ativo and task.wait(2) do
        pcall(function()
            remotePath:FireServer("JumpResults", coinID, altura)
        end)
    end
end

Toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    Toggle.Text = ativo and "Desativar Auto Coins" or "Ativar Auto Coins"
    Toggle.BackgroundColor3 = ativo and Color3.fromRGB(239, 68, 68) or Color3.fromRGB(34, 197, 94)
    if ativo then
        autoCoins()
    end
end)
