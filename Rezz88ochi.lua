local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))() local Window = OrionLib:MakeWindow({Name = "Ochi Hub | Blox Fruits", HidePremium = false, SaveConfig = true, ConfigFolder = "OchiBF", IntroText = "Script by Ochi"})

local plr = game.Players.LocalPlayer local rs = game.ReplicatedStorage

local farmTab = Window:MakeTab({Name = "Auto Farm", Icon = "", PremiumOnly = false}) _G.AutoFarmLevel = false _G.AutoFarmBoss = false

farmTab:AddToggle({Name = "Auto Farm Level", Default = false, Callback = function(v) _G.AutoFarmLevel = v end}) farmTab:AddToggle({Name = "Auto Farm Boss", Default = false, Callback = function(v) _G.AutoFarmBoss = v end})

_G.AutoFarmKata = false _G.AutoFarmBones = false farmTab:AddToggle({Name = "Auto Farm Katakuri", Default = false, Callback = function(v) _G.AutoFarmKata = v end}) farmTab:AddToggle({Name = "Auto Farm Bones", Default = false, Callback = function(v) _G.AutoFarmBones = v end})

_G.AutoMastery = false farmTab:AddToggle({Name = "Auto Mastery", Default = false, Callback = function(v) _G.AutoMastery = v end})

local seaTab = Window:MakeTab({Name = "Sea Event", Icon = "", PremiumOnly = false}) _G.AutoSeaEvent = false seaTab:AddToggle({Name = "Auto Sea Event", Default = false, Callback = function(v) _G.AutoSeaEvent = v end}) _G.AutoDodgeSeaEvent = true seaTab:AddToggle({Name = "Tự bay lên khi máu < 3000", Default = true, Callback = function(v) _G.AutoDodgeSeaEvent = v end})

spawn(function() while wait(0.5) do if _G.AutoSeaEvent and _G.AutoDodgeSeaEvent then local char = plr.Character local humanoid = char and char:FindFirstChild("Humanoid") local root = char and char:FindFirstChild("HumanoidRootPart") if humanoid and humanoid.Health < 3000 and root then root.Velocity = Vector3.new(0, 120, 0) wait(1.2) end end end end)

local v4Tab = Window:MakeTab({Name = "Auto V4", Icon = "", PremiumOnly = false}) _G.AutoV4 = false v4Tab:AddToggle({Name = "Tự động vào máy V4 (Awaken)", Default = false, Callback = function(v) _G.AutoV4 = v end})

spawn(function() while wait(1) do if _G.AutoV4 then local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") local altar = workspace:FindFirstChild("AwakeningAltar") or workspace:FindFirstChild("AwakeningSpot") if altar and root then root.CFrame = altar.CFrame * CFrame.new(0, 5, 0) fireclickdetector(altar:FindFirstChildWhichIsA("ClickDetector")) end end end end)

_G.EnableESP = false local espTab = Window:MakeTab({Name = "ESP", Icon = "", PremiumOnly = false}) espTab:AddToggle({Name = "Bật ESP (Fruit, Chest, Player)", Default = false, Callback = function(v) _G.EnableESP = v end})

function addESP(obj, labelText, color) if obj:FindFirstChild("ESP_M") then return end local esp = Instance.new("BillboardGui", obj) esp.Name = "ESP_M" esp.Size = UDim2.new(0, 100, 0, 40) esp.Adornee = obj esp.AlwaysOnTop = true esp.StudsOffset = Vector3.new(0, 2, 0) local label = Instance.new("TextLabel", esp) label.Size = UDim2.new(1, 0, 1, 0) label.BackgroundTransparency = 1 label.Text = "M | " .. labelText label.TextColor3 = color label.TextStrokeTransparency = 0.2 label.Font = Enum.Font.GothamBold label.TextScaled = true end

spawn(function() while wait(2) do if _G.EnableESP then for _,v in pairs(workspace:GetDescendants()) do if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then if v.Name == "Chest" then addESP(v.HumanoidRootPart, "Chest", Color3.fromRGB(255,255,0)) elseif v.Name:lower():find("fruit") then addESP(v.HumanoidRootPart, "Fruit", Color3.fromRGB(255,125,0)) elseif game.Players:FindFirstChild(v.Name) then addESP(v.HumanoidRootPart, v.Name, Color3.fromRGB(255,0,0)) end end end end end end)

_G.AutoStats = false _G.Stats = {Melee=true, Defense=true, Sword=false, BloxFruit=false} local statsTab = Window:MakeTab({Name = "Auto Stats", Icon = "", PremiumOnly = false})

statsTab:AddToggle({Name = "Bật Auto Stats", Default = false, Callback = function(v) _G.AutoStats = v end}) statsTab:AddToggle({Name = "Melee", Default = true, Callback = function(v) _G.Stats.Melee = v end}) statsTab:AddToggle({Name = "Defense", Default = true, Callback = function(v) _G.Stats.Defense = v end}) statsTab:AddToggle({Name = "Sword", Default = false, Callback = function(v) _G.Stats.Sword = v end}) statsTab:AddToggle({Name = "Blox Fruit", Default = false, Callback = function(v) _G.Stats.BloxFruit = v end})

spawn(function() while wait(1) do if _G.AutoStats then for stat, enabled in pairs(G.Stats) do if enabled then rs.Remotes.CommF:InvokeServer("AddPoint", stat, 1) end end end end end)

local teleportTab = Window:MakeTab({Name = "Teleport", Icon = "", PremiumOnly = false}) local teleportPoints = { ["Start Island"] = Vector3.new(1072, 16, 1560), ["Marine Fortress"] = Vector3.new(-4500, 20, 4000), ["Skylands"] = Vector3.new(-500, 750, -2000), ["Colosseum"] = Vector3.new(-1500, 15, 5500) }

teleportTab:AddDropdown({ Name = "Chọn địa điểm", Options = {"Start Island", "Marine Fortress", "Skylands", "Colosseum"}, Callback = function(v) if teleportPoints[v] then plr.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPoints[v]) end end })

local hakiTab = Window:MakeTab({Name = "Auto Haki", Icon = "", PremiumOnly = false}) hakiTab:AddButton({Name = "Auto Bật Ken/Haki", Callback = function() pcall(function() rs.Remotes.CommF_:InvokeServer("Buso") rs.Remotes.CommF_:InvokeServer("Ken") end) end})

local miscTab = Window:MakeTab({Name = "Misc", Icon = "", PremiumOnly = false}) _G.AutoCollectFruit = false miscTab:AddToggle({Name = "Auto Collect Fruit", Default = false, Callback = function(v) _G.AutoCollectFruit = v end}) miscTab:AddParagraph("Anti AFK & Anti Ban", "Đã bật mặc định khi chạy script.")

spawn(function() while wait(2) do if _G.AutoCollectFruit then for _, fruit in pairs(workspace:GetChildren()) do if fruit:IsA("Tool") and fruit.Name:find("Fruit") then firetouchinterest(plr.Character.HumanoidRootPart, fruit.Handle, 0) wait(0.2) firetouchinterest(plr.Character.HumanoidRootPart, fruit.Handle, 1) end end end end end)

plr.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)

setreadonly(getrawmetatable(game), false) local old = getrawmetatable(game).__namecall getrawmetatable(game).__namecall = newcclosure(function(...) local args = {...} if tostring(args[2]) == "Ban" or tostring(args[2]):lower():find("kick") then return wait(9e9) end return old(...) end)

OrionLib:Init()