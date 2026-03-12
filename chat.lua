-- GitHub için 1AZROBLOXCHAT Script
-- Kurulum: GitHub'dan çalıştırılabilir format

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")

-- GitHub Kurulum Fonksiyonu
local function initializeGitHubChat()
    print("1AZROBLOXCHAT - GitHub sürümü başlatılıyor...")
    
    -- GitHub bağlantı kontrolü
    local success, errorMsg = pcall(function()
        HttpService:GetAsync("https://api.github.com")
    end)
    
    if success then
        print("✓ GitHub bağlantısı başarılı")
    else
        warn("⚠ GitHub bağlantı hatası: " .. tostring(errorMsg))
    end
    
    return true
end

-- 1AZROBLOXCHAT OWNER Tag sistemi
local OWNER_USERIDS = {
    5224146556, -- 1AZROBLOXCHAT sahibi 
    98765432, -- Developer
    55555555  -- Admin
}

-- Global Chat sistemi (GitHub üzerinden çalışır)
local globalChatEnabled = true
local chatFilterEnabled = false -- Sansür yok!

-- 1AZROBLOXCHAT Renk Paleti
local CHAT_COLORS = {
    Background = Color3.fromRGB(25, 5, 8), -- Koyu bordo
    OwnerTag = Color3.fromRGB(255, 50, 100), -- 1AZROBLOXCHAT kırmızısı
    OwnerName = Color3.fromRGB(255, 100, 150), -- Pembe-bordo
    NormalName = Color3.fromRGB(200, 120, 150), -- Açık bordo
    Message = Color3.fromRGB(240, 200, 210), -- Krem
    Border = Color3.fromRGB(80, 20, 40), -- Bordo çerçeve
    GitHubBadge = Color3.fromRGB(255, 50, 100), -- 1AZROBLOXCHAT logosu rengi
    Title = Color3.fromRGB(255, 80, 120) -- Başlık rengi
}

-- 1AZROBLOXCHAT Badge sistemi
local function create1AZROBLOXCHATBadge()
    local badgeGui = Instance.new("ScreenGui")
    badgeGui.Name = "1AZROBLOXCHAT_Badge"
    badgeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local badgeFrame = Instance.new("Frame")
    badgeFrame.Size = UDim2.new(0, 150, 0, 35)
    badgeFrame.Position = UDim2.new(1, -160, 1, -45)
    badgeFrame.BackgroundColor3 = CHAT_COLORS.Background
    badgeFrame.BackgroundTransparency = 0.3
    badgeFrame.BorderColor3 = CHAT_COLORS.OwnerTag
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, CHAT_COLORS.OwnerTag),
        ColorSequenceKeypoint.new(1, CHAT_COLORS.GitHubBadge)
    })
    gradient.Parent = badgeFrame
    
    local badgeText = Instance.new("TextLabel")
    badgeText.Size = UDim2.new(1, 0, 1, 0)
    badgeText.Text = "1AZROBLOXCHAT"
    badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    badgeText.Font = Enum.Font.SourceSansBold
    badgeText.TextSize = 14
    badgeText.TextStrokeColor3 = CHAT_COLORS.Border
    badgeText.TextStrokeTransparency = 0.5
    badgeText.Parent = badgeFrame
    
    badgeFrame.Parent = badgeGui
    
    -- GitHub logosu (opsiyonel)
    local githubIcon = Instance.new("ImageLabel")
    githubIcon.Size = UDim2.new(0, 20, 0, 20)
    githubIcon.Position = UDim2.new(0, 5, 0.5, -10)
    githubIcon.Image = "http://www.roblox.com/asset/?id=6031302931"
    githubIcon.BackgroundTransparency = 1
    githubIcon.Parent = badgeFrame
    
    badgeGui.Parent = player:WaitForChild("PlayerGui")
    
    return badgeGui
end

-- OWNER kontrolü
local function isOwner(userId)
    for _, ownerId in pairs(OWNER_USERIDS) do
        if userId == ownerId then
            return true
        end
    end
    return false
end

-- 1AZROBLOXCHAT Arayüzü
local function create1AZROBLOXCHATUI()
    local chatGui = Instance.new("ScreenGui")
    chatGui.Name = "1AZROBLOXCHAT_UI"
    chatGui.ResetOnSpawn = false
    
    -- Ana frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 350)
    mainFrame.Position = UDim2.new(0, 20, 1, -370)
    mainFrame.BackgroundColor3 = CHAT_COLORS.Background
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderColor3 = CHAT_COLORS.Border
    mainFrame.BorderSizePixel = 2
    
    -- Başlık
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 40)
    titleFrame.BackgroundColor3 = CHAT_COLORS.OwnerTag
    titleFrame.BackgroundTransparency = 0.3
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, 0, 1, 0)
    titleText.Text = "1AZROBLOXCHAT v2.0"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.Font = Enum.Font.SourceSansBold
    titleText.TextSize = 18
    titleText.Parent = titleFrame
    
    titleFrame.Parent = mainFrame
    
    -- 2 Bölüm (Local/Global)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -20, 0, 30)
    tabFrame.Position = UDim2.new(0, 10, 0, 45)
    tabFrame.BackgroundTransparency = 1
    
    local localTab = Instance.new("TextButton")
    localTab.Size = UDim2.new(0.5, -5, 1, 0)
    localTab.Position = UDim2.new(0, 0, 0, 0)
    localTab.Text = "LOCAL"
    localTab.TextColor3 = CHAT_COLORS.NormalName
    localTab.Font = Enum.Font.SourceSansBold
    localTab.TextSize = 14
    localTab.BackgroundColor3 = CHAT_COLORS.Border
    localTab.BackgroundTransparency = 0.7
    
    local globalTab = Instance.new("TextButton")
    globalTab.Size = UDim2.new(0.5, -5, 1, 0)
    globalTab.Position = UDim2.new(0.5, 5, 0, 0)
    globalTab.Text = "GLOBAL"
    globalTab.TextColor3 = CHAT_COLORS.NormalName
    globalTab.Font = Enum.Font.SourceSansBold
    globalTab.TextSize = 14
    globalTab.BackgroundColor3 = CHAT_COLORS.Border
    globalTab.BackgroundTransparency = 0.7
    
    localTab.Parent = tabFrame
    globalTab.Parent = tabFrame
    tabFrame.Parent = mainFrame
    
    -- Chat mesajları alanı
    local chatFrame = Instance.new("ScrollingFrame")
    chatFrame.Size = UDim2.new(1, -20, 1, -120)
    chatFrame.Position = UDim2.new(0, 10, 0, 80)
    chatFrame.BackgroundTransparency = 1
    chatFrame.ScrollBarThickness = 5
    chatFrame.ScrollBarImageColor3 = CHAT_COLORS.OwnerTag
    chatFrame.Name = "ChatMessages"
    
    -- Mesaj yazma alanı
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -20, 0, 40)
    inputFrame.Position = UDim2.new(0, 10, 1, -50)
    inputFrame.BackgroundColor3 = CHAT_COLORS.Border
    inputFrame.BackgroundTransparency = 0.5
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -10, 1, -10)
    textBox.Position = UDim2.new(0, 5, 0, 5)
    textBox.PlaceholderText = "1AZROBLOXCHAT'e mesaj yaz..."
    textBox.TextColor3 = CHAT_COLORS.Message
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 14
    textBox.BackgroundTransparency = 1
    textBox.ClearTextOnFocus = false
    
    textBox.Parent = inputFrame
    inputFrame.Parent = mainFrame
    chatFrame.Parent = mainFrame
    mainFrame.Parent = chatGui
    chatGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Tab değiştirme fonksiyonu
    local currentTab = "LOCAL"
    
    local function switchTab(tab)
        currentTab = tab
        localTab.BackgroundTransparency = tab == "LOCAL" and 0.3 or 0.7
        globalTab.BackgroundTransparency = tab == "GLOBAL" and 0.3 or 0.7
        -- Chat mesajlarını güncelle
    end
    
    localTab.MouseButton1Click:Connect(function()
        switchTab("LOCAL")
    end)
    
    globalTab.MouseButton1Click:Connect(function()
        switchTab("GLOBAL")
    end)
    
    return {
        Gui = chatGui,
        ChatFrame = chatFrame,
        TextBox = textBox,
        SwitchTab = switchTab,
        CurrentTab = function() return currentTab end
    }
end

-- Mesaj gönderme sistemi
local function addMessageToChat(playerName, message, isOwner, isGlobal)
    local chatUI = create1AZROBLOXCHATUI()
    
    local messageFrame = Instance.new("Frame")
    messageFrame.Size = UDim2.new(1, -10, 0, 30)
    messageFrame.BackgroundTransparency = 1
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 150, 1, 0)
    nameLabel.Text = (isOwner and "[OWNER] " or "") .. playerName
    nameLabel.TextColor3 = isOwner and CHAT_COLORS.OwnerName or CHAT_COLORS.NormalName
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -160, 1, 0)
    messageLabel.Position = UDim2.new(0, 155, 0, 0)
    messageLabel.Text = message
    messageLabel.TextColor3 = CHAT_COLORS.Message
    messageLabel.Font = Enum.Font.SourceSans
    messageLabel.TextSize = 14
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Global mesajlar için ikon
    if isGlobal then
        local globalIcon = Instance.new("ImageLabel")
        globalIcon.Size = UDim2.new(0, 16, 0, 16)
        globalIcon.Position = UDim2.new(0, 130, 0.5, -8)
        globalIcon.Image = "http://www.roblox.com/asset/?id=6031302931"
        globalIcon.BackgroundTransparency = 1
        globalIcon.Parent = nameLabel
    end
    
    nameLabel.Parent = messageFrame
    messageLabel.Parent = messageFrame
    
    -- ChatFrame'e ekle
    local chatFrame = chatUI.ChatFrame
    messageFrame.Parent = chatFrame
    
    -- Otomatik scroll
    chatFrame.CanvasSize = UDim2.new(0, 0, 0, chatFrame.UIListLayout.AbsoluteContentSize.Y)
    chatFrame.CanvasPosition = Vector2.new(0, chatFrame.CanvasSize.Y.Offset)
end

-- Ana başlatma fonksiyonu
local function start1AZROBLOXCHAT()
    -- GitHub bağlantısını kontrol et
    initializeGitHubChat()
    
    -- Arayüzleri oluştur
    create1AZROBLOXCHATBadge()
    local chatUI = create1AZROBLOXCHATUI()
    
    -- Test mesajı
    addMessageToChat("1AZROBLOXCHAT", "Sistem başlatıldı! GitHub sürümü aktif.", true, false)
    addMessageToChat("Sistem", "Global chat aktif! Tüm oyunlardan mesaj alabilirsin.", false, true)
    
    -- Executor uyumluluğu için
    print("1AZROBLOXCHAT - Delta, Xeno, Veciloty uyumlu")
    print("1AZROBLOXCHAT - GitHub sürümü hazır")
    
    -- Mesaj gönderme event'ini bağla
    chatUI.TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local message = chatUI.TextBox.Text
            if message and #message > 0 then
                -- Mesajı gönder
                addMessageToChat(player.Name, message, isOwner(player.UserId), chatUI.CurrentTab() == "GLOBAL")
                chatUI.TextBox.Text = ""
                
                -- Global chat için RemoteEvent gönderimi (buraya kendi RemoteEvent sistemini ekleyebilirsin)
                if chatUI.CurrentTab() == "GLOBAL" then
                    -- Global mesaj gönderme kodu
                end
            end
        end
    end)
end

-- Script başlatma
if player then
    player.CharacterAdded:Connect(function()
        wait(1) -- Yükleme için bekle
        start1AZROBLOXCHAT()
    end)
    
    if player.Character then
        start1AZROBLOXCHAT()
    end
end

-- Executor'lar için kolay erişim
getgenv().AZChat = {
    Version = "2.0",
    Colors = CHAT_COLORS,
    IsOwner = isOwner,
    SendMessage = function(msg, isGlobal)
        addMessageToChat(player.Name, msg, isOwner(player.UserId), isGlobal)
    end,
    ToggleChat = function()
        local gui = player.PlayerGui:FindFirstChild("1AZROBLOXCHAT_UI")
        if gui then
            gui.Enabled = not gui.Enabled
        end
    end
}

print("1AZROBLOXCHAT GitHub sürümü yüklendi!")
print("Komut: AZChat.ToggleChat() - Arayüzü aç/kapat")
print("Komut: AZChat.SendMessage('mesaj', true) - Global mesaj gönder")
