-- Key System com interface + carregamento do Auto Coins via GitHub
local function createKeyUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local KeyInput = Instance.new("TextBox")
    local SubmitButton = Instance.new("TextButton")
    local GetKeyButton = Instance.new("TextButton")
    local StatusLabel = Instance.new("TextLabel")

    ScreenGui.Name = "KeySystemUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainFrame.Size = UDim2.new(0, 300, 0, 200)

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = "Script Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16.000

    KeyInput.Name = "KeyInput"
    KeyInput.Parent = MainFrame
    KeyInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
    KeyInput.BorderSizePixel = 0
    KeyInput.Position = UDim2.new(0.5, -125, 0.3, 0)
    KeyInput.Size = UDim2.new(0, 250, 0, 30)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "Enter your key here..."
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 14.000

    SubmitButton.Name = "SubmitButton"
    SubmitButton.Parent = MainFrame
    SubmitButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Position = UDim2.new(0.5, -60, 0.55, 0)
    SubmitButton.Size = UDim2.new(0, 120, 0, 30)
    SubmitButton.Font = Enum.Font.GothamSemibold
    SubmitButton.Text = "Submit Key"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 14.000

    GetKeyButton.Name = "GetKeyButton"
    GetKeyButton.Parent = MainFrame
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
    GetKeyButton.BorderSizePixel = 0
    GetKeyButton.Position = UDim2.new(0.5, -60, 0.75, 0)
    GetKeyButton.Size = UDim2.new(0, 120, 0, 30)
    GetKeyButton.Font = Enum.Font.GothamSemibold
    GetKeyButton.Text = "Get Key"
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.TextSize = 14.000

    StatusLabel.Name = "StatusLabel"
    StatusLabel.Parent = MainFrame
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Position = UDim2.new(0, 0, 0.9, 0)
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.TextSize = 12.000

    return {
        ScreenGui = ScreenGui,
        KeyInput = KeyInput,
        SubmitButton = SubmitButton,
        GetKeyButton = GetKeyButton,
        StatusLabel = StatusLabel
    }
end

local function verifyKey(key)
    local url = "https://luarmor.org/?verify=1&key=" .. key
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        return response == "valid", response
    else
        return false, "error"
    end
end

local function runMainScript()
    local url = "https://raw.githubusercontent.com/SEU_USUARIO/ClimbAndJumpHub/main/AutoCoins.lua"
    loadstring(game:HttpGet(url))()
end

local function initKeySystem()
    local ui = createKeyUI()

    ui.GetKeyButton.MouseButton1Click:Connect(function()
        setclipboard("https://luarmor.org/")
        ui.StatusLabel.Text = "Key URL copiada! Acesse no navegador."
        ui.StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    end)

    ui.SubmitButton.MouseButton1Click:Connect(function()
        local key = ui.KeyInput.Text
        if key == "" then
            ui.StatusLabel.Text = "Digite uma key válida!"
            ui.StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            return
        end

        ui.StatusLabel.Text = "Verificando key..."
        ui.StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

        task.delay(1.5, function()
            local valid, status = verifyKey(key)
            if valid then
                ui.StatusLabel.Text = "Key válida!"
                ui.StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                task.wait(1)
                ui.ScreenGui:Destroy()
                runMainScript()
            else
                ui.StatusLabel.Text = "Key inválida ou " .. status
                ui.StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end)
end

initKeySystem()
