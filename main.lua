

local TweenService = game:GetService("TweenService")

local Shop = Instance.new("ScreenGui")
local MainFrame = Instance.new("ImageLabel")
local Banner = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Icon = Instance.new("ImageLabel")
local UIGradient = Instance.new("UIGradient")
local Description = Instance.new("TextLabel")
local ID = Instance.new("TextBox")
local Load = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

local function loadModel(id)
	if game:GetService("Players").LocalPlayer.Backpack.Folder then
		TextLabel.Text = "Calculating.."
		local total = 0
		local counterParts = 0

		print("Fetching data..")
		local model = Instance.new("Model", game.ReplicatedStorage)
		game:GetObjects('rbxassetid://'..id)[1].Parent = model


		local offset = Vector3.new(0,500,0)

		local fireErrorRetry = 0

		local run = 0
		local part = nil

		print("Finished getting data")

		local function fireRemote(instance,args)
			local success, err = pcall(function()
				instance:InvokeServer(unpack(args))
			end)
			if not success then
				warn(err)
				task.wait()
				return fireRemote(instance, args)
			end
		end


		local obj = model:FindFirstChildWhichIsA("Model")
		for _, e in ipairs(obj:GetDescendants()) do
			if e:IsA("BasePart") then
				total += 1
			end
		end

		for _, e in ipairs(obj:GetDescendants()) do
			if e:IsA("BasePart") then
				if run > 9 then
					run = 0
					wait(fireErrorRetry)
				end
				run += 1
				counterParts += 1
				TextLabel.Text = "Loading Model.. ("..counterParts.."/"..total..")"
				if e:IsA("WedgePart") then
					local args = {
						[1] = "CreatePart",
						[2] = "Wedge",
						[3] = e.CFrame + offset,
						[4] = workspace
					}
					fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)
					for _, ee in ipairs(workspace:GetDescendants()) do
						if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
							part = ee
						end
					end


				end

				if e:IsA("TrussPart") then
					local args = {
						[1] = "CreatePart",
						[2] = "Truss",
						[3] = e.CFrame + offset,
						[4] = workspace
					}
					fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)
					for _, ee in ipairs(workspace:GetDescendants()) do
						if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
							part = ee
						end
					end


				end

				if e:IsA("Part") and e.Shape == Enum.PartType.Ball then
					local args = {
						[1] = "CreatePart",
						[2] = "Ball",
						[3] = e.CFrame + offset,
						[4] = workspace
					}
					fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)

					for _, ee in ipairs(workspace:GetDescendants()) do
						if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
							part = ee
						end
					end


				end

				if e:IsA("Part") and e.Shape ~= Enum.PartType.Ball then
					local args = {
						[1] = "CreatePart",
						[2] = "Normal",
						[3] = e.CFrame + offset,
						[4] = workspace
					}
					fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)


					for _, ee in ipairs(workspace:GetDescendants()) do
						if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
							part = ee
						end
					end





				end

				--//CONFIG FUNCTION

				local args = {
					[1] = "SyncResize",
					[2] = {
						[1] = {
							["Part"] = part,
							["CFrame"] = part.CFrame,
							["Size"] = e.Size
						}
					}
				}

				fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)

				local args = {
					[1] = "SyncColor",
					[2] = {
						[1] = {
							["Color"] = e.Color,
							["Part"] = part,
							["UnionColoring"] = true
						}
					}
				}

				fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)

				local args = {
					[1] = "SyncMaterial",
					[2] = {
						[1] = {
							["Part"] = part,
							["Transparency"] = e.Transparency
						}
					}
				}

				fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)

				local args = {
					[1] = "SyncMaterial",
					[2] = {
						[1] = {
							["Part"] = part,
							["Material"] = e.Material
						}
					}
				}

				fireRemote(game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint,args)


				part.Name = "FinishedPart"

				

			end
		end

		model:Destroy()
		print("Finished loading!")
		TextLabel.Text = "Load Model"
	else
		print("ERROR")
		TextLabel.Text = "You must have F3X!"
		wait(1)
		TextLabel.Text = "Load Model"
	end
end

--Properties:

Shop.Name = "Shop"
Shop.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Shop.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = Shop
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 170)
MainFrame.ZIndex = 0
MainFrame.Image = "rbxassetid://1934624205"
MainFrame.ImageColor3 = Color3.fromRGB(249, 249, 249)
MainFrame.ScaleType = Enum.ScaleType.Slice
MainFrame.SliceCenter = Rect.new(4, 4, 252, 252)
MainFrame.Draggable = true
MainFrame.Selectable = true
MainFrame.Active = true

Banner.Name = "Banner"
Banner.Parent = MainFrame
Banner.BackgroundColor3 = Color3.fromRGB(248, 189, 85)
Banner.BorderSizePixel = 0
Banner.Position = UDim2.new(0, 0, 0, 5)
Banner.Size = UDim2.new(1, 0, 0, 35)

TextLabel.Parent = Banner
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 20, 0, 0)
TextLabel.Size = UDim2.new(1, -20, 1, 0)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = "Load Model"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 25.000
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

Icon.Name = "Icon"
Icon.Parent = MainFrame
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.BorderSizePixel = 0
Icon.Position = UDim2.new(0, 10, 0, 40)
Icon.Size = UDim2.new(0, 100, 0, 100)
Icon.Image = "http://www.roblox.com/asset/?id=6026568222"
Icon.ImageColor3 = Color3.fromRGB(248, 189, 85)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
UIGradient.Parent = Icon

coroutine.wrap(function()
	while wait() do
		UIGradient.Rotation += 4
	end
end)()

Description.Name = "Description"
Description.Parent = MainFrame
Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Description.BackgroundTransparency = 1.000
Description.BorderSizePixel = 0
Description.Position = UDim2.new(0, 130, 0, 80)
Description.Size = UDim2.new(0, 260, 0, 88)
Description.Font = Enum.Font.SourceSans
Description.Text = [[
- If your model does not load, try re-exec
- The load time will be long, depending
  on your model size
- You must have F3X in your inv or hand
- Made by Snippy#1118
- More comming VERY soon!
]]
Description.TextColor3 = Color3.fromRGB(43, 43, 43)
Description.TextSize = 14.000
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.TextYAlignment = Enum.TextYAlignment.Top

ID.Name = "ID"
ID.Parent = MainFrame
ID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ID.BackgroundTransparency = 1.000
ID.Position = UDim2.new(0, 130, 0, 45)
ID.Size = UDim2.new(0, 260, 0, 30)
ID.Font = Enum.Font.SourceSansSemibold
ID.PlaceholderText = "Model ID"
ID.Text = ""
ID.TextColor3 = Color3.fromRGB(43, 43, 43)
ID.TextScaled = true
ID.TextSize = 14.000
ID.TextWrapped = true

Load.Name = "Load"
Load.Parent = MainFrame
Load.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Load.Position = UDim2.new(0.0200000759, 0, 0.776470602, 0)
Load.Size = UDim2.new(0.258609205, 0, 0.167665914, 0)
Load.Font = Enum.Font.SourceSans
Load.Text = "LOAD"
Load.TextColor3 = Color3.fromRGB(0, 170, 0)
Load.TextSize = 19.000
Load.TextWrapped = true

UICorner.Parent = Load

Load.MouseEnter:Connect(function()
	TweenService:Create(Load, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 194, 87)}):Play()
end)

Load.MouseLeave:Connect(function()
	TweenService:Create(Load, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 255, 255)}):Play()
end)

Load.Activated:Connect(function()
	loadModel(ID.Text)
end)
