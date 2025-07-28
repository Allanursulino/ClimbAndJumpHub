-- Auto Coins para Climb and Jump Tower (usando RemoteEvent)
-- Desenvolvido para funcionar via GitHub (sem interface Rayfield)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Configuração
local delaySeconds = 1.5
local heightAmount = 10

local remote = ReplicatedStorage:WaitForChild("ProMsgs"):WaitForChild("RemoteEvent")

_G.AutoCoins = true

task.spawn(function()
    while _G.AutoCoins do
        pcall(function()
            remote:FireServer("JumpResults", os.time(), heightAmount)
            remote:FireServer("LandingResults", os.time())
        end)
        task.wait(delaySeconds)
    end
end)
