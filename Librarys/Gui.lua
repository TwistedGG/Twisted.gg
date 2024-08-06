repeat task.wait() until game:IsLoaded()

local plr = game.Players.LocalPlayer

local GUI = Instance.new("ScreenGui", plr.PlayerGui)
GUI.ResetOnSpawn = false
GUI.Name = tostring(math.random())
GUI.IgnoreGuiInset = true

local lib = {
	Count = 0,
	ThemeColors = {
		clr1 = Color3.fromRGB(101, 181, 255),
		clr2 = Color3.fromRGB(103, 103, 255),
	},
	GuiBind = Enum.KeyCode.Delete,
	GuiInst = GUI,
	ArrayListEnabled = false,
	ArraylistTable = {
		IsEnabled = false,
		ColorMode = "White",
		Colors  = {
			Rainbow = {
				Color3.fromRGB(255,0,0),
				Color3.fromRGB(255,100,0),
				Color3.fromRGB(255,255,0),
				Color3.fromRGB(0, 255, 0),
				Color3.fromRGB(0,100,255),
				Color3.fromRGB(255,0,255),
			}
		}
	}
}

local ArrayFrame = Instance.new("Frame", GUI)
ArrayFrame.Position = UDim2.fromScale(0.85, 0.5)
ArrayFrame.Size = UDim2.fromScale(0.15, 0.5)
ArrayFrame.BorderSizePixel = 0
ArrayFrame.BackgroundTransparency = 1
ArrayFrame.Visible = true
local ArraySort = Instance.new("UIListLayout", ArrayFrame)
ArraySort.VerticalAlignment = Enum.VerticalAlignment.Bottom
ArraySort.SortOrder = Enum.SortOrder.Name

function lib.ArraylistTable:AddNewArray(Item)
	local newinst = Instance.new("TextLabel", ArrayFrame)
	newinst.Size = UDim2.fromScale(1, 0.09)
	newinst.BackgroundTransparency = 1
	newinst.TextColor3 = Color3.fromRGB(255,255,255)
	newinst.TextSize = 30
	newinst.Font = Enum.Font.SourceSans
	newinst.Text = Item .. "  "
	newinst.Name = Item
	newinst.TextXAlignment = Enum.TextXAlignment.Right
	newinst.TextStrokeTransparency = 0.5
end
function lib.ArraylistTable:RemoveFromArray(Item)
	local Item = ArrayFrame:FindFirstChild(Item)
	if Item then
		Item:Remove()
	end
end

spawn(function()
	repeat
		task.spawn(function() ArrayFrame.Visible = lib.ArraylistTable.IsEnabled end)
		if lib.ArraylistTable.ColorMode == "White" then
			for i,v in pairs(ArrayFrame:GetChildren()) do
				if v:IsA("TextLabel") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.25), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
				end
			end
		elseif lib.ArraylistTable.ColorMode == "Rainbow" then
			for _,Colors in pairs(lib.ArraylistTable.Colors.Rainbow) do
				for i,v in ipairs(ArrayFrame:GetChildren()) do
					if v:IsA("TextLabel") then
						game:GetService("TweenService"):Create(v, TweenInfo.new(0.6), {TextColor3 = Colors}):Play()
						task.wait()
					end
				end
				task.wait(0.6)
			end
		end


		for i,v in pairs(ArrayFrame:GetChildren()) do
			if v:IsA("TextLabel") then
				v.TextSize = tonumber(ArrayListTextSize.Value)
			end
		end
		task.wait()
	until false
end)

function tweenColor(obj, clr1, clr2, Changing)
	game.TweenService:Create(obj, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Changing = clr1
	}):Play()
	task.wait(.5)
	game.TweenService:Create(obj, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Changing = clr2
	}):Play()
	task.wait(.5)
end

local notifCount = 0
function lib:NewNotification(Type, Thing, Time)
	spawn(function()

		notifCount -= 1
	end)
end

function lib:CreateWindow(name)
	local Text = Instance.new("TextLabel", GUI)
	Text.Position = UDim2.fromScale(0.12 + (lib.Count / 7), 0.1)
	Text.Size = UDim2.fromScale(0.14, 0.05)
	Text.BorderSizePixel = 0
	Text.Font = Enum.Font.Roboto
	Text.TextColor3 = Color3.fromRGB(255,255,255)
	Text.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Text.Text = "   " .. name
	Text.Name = name
	Text.TextSize = 18
	Text.Visible = false
	Text.Active = true
	Text.Draggable = true
	Text.TextYAlignment = Enum.TextYAlignment.Center
	Text.Font = Enum.Font.SourceSans
	Text.TextXAlignment = Enum.TextXAlignment.Left

	local corner = Instance.new("UICorner", Text)

	local Modules = Instance.new("Frame", Text)
	Modules.Position = UDim2.fromScale(0,0.825)
	Modules.Size = UDim2.fromScale(1, 7)	
	Modules.BorderSizePixel = 0
	Modules.BackgroundTransparency = 1
	Modules.Name = "Modules"

	local sort = Instance.new("UIListLayout", Modules)

	game.UserInputService.InputBegan:Connect(function(k, gpe)
		if gpe then return end
		if k.KeyCode == lib.GuiBind then
			Text.Visible = not Text.Visible
		end
	end)

	lib.Count += 1
end

function lib:CreateButton(tab)
	local enabled = false

	local name = tab["Name"]
	local func = tab["Function"]
	local ntab = tab["Tab"]
	local keyc = tab["KeyBind"]
	local path = GUI[ntab].Modules

	local button = Instance.new("TextButton", path)
	button.Size = UDim2.fromScale(1, .12)
	button.Position = UDim2.fromScale(0,0)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.Roboto
	button.TextColor3 = Color3.fromRGB(255,255,255)
	button.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
	button.Text = "   " .. name
	button.Name = name
	button.TextSize = 18
	button.AutoButtonColor = false
	button.Font = Enum.Font.SourceSans
	button.TextXAlignment = Enum.TextXAlignment.Left
	local dropdown = Instance.new("Frame", button)
	dropdown.Size = UDim2.fromScale(1, 5)
	dropdown.Position = UDim2.fromScale(0,1)
	dropdown.BorderSizePixel = 0
	dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	dropdown.Name = "dropdown"
	dropdown.Visible = false
	dropdown.BackgroundTransparency = 1
	local dropuilist = Instance.new("UIListLayout", dropdown)
	dropuilist.SortOrder = Enum.SortOrder.LayoutOrder

	local buttonFunctions = {}
	buttonFunctions.Enabled = enabled
	buttonFunctions.Toggle = function()
		enabled = not enabled
		buttonFunctions.Enabled = enabled
		task.spawn(lib.NewNotification, {"Toggle", name, 3})
		task.spawn(func, enabled)
		button.BackgroundColor3 = (enabled and Color3.fromRGB(0,185,255) or Color3.fromRGB(75, 75, 75))
		if enabled then
			lib.ArraylistTable:AddNewArray(name)
		else
			lib.ArraylistTable:RemoveFromArray(name)
		end
	end
	function buttonFunctions:newToggle(tab2)
		local enabled2 = false
		local name2 = tab2["Name"]
		local func2 = tab2["Function"]

		local lol = {Enabled = enabled2}

		local button2 = Instance.new("TextButton", dropdown)
		button2.Size = UDim2.fromScale(1, .15)
		button2.Position = UDim2.fromScale(0,0)
		button2.BorderSizePixel = 0
		button2.Font = Enum.Font.Roboto
		button2.TextColor3 = Color3.fromRGB(255,255,255)
		button2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button2.Text = name2
		button2.Name = name2
		button2.TextSize = 18
		button2.AutoButtonColor = false
		button2.Font = Enum.Font.SourceSans

		local buttonFunctions2 = {
			Toggle = function()
				enabled2 = not enabled2
				task.spawn(func2, enabled2)
				lol.Enabled = enabled2
				button2.BackgroundColor3 = (enabled2 and Color3.fromRGB(0,185,255) or Color3.fromRGB(40, 40, 40))
			end,
		}

		button2.MouseButton1Down:Connect(function()
			buttonFunctions2.Toggle()
		end)
		return lol
	end
	function buttonFunctions:newTextBox(tab2)
		local name2 = tab2["Name"]
		local func2 = tab2["Function"]
		local Default = tab2["Default"]

		local returnval = {Value = Default and Default or 16}

		local textbox = Instance.new("TextBox", dropdown)
		textbox.Size = UDim2.fromScale(1, .15)
		textbox.Position = UDim2.fromScale(0,0)
		textbox.BorderSizePixel = 0
		textbox.Font = Enum.Font.Roboto
		textbox.TextColor3 = Color3.fromRGB(255,255,255)
		textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		textbox.Text = name2 .. " : " .. returnval.Value
		textbox.Name = name2
		textbox.TextSize = 18
		textbox.Font = Enum.Font.SourceSans

		textbox.FocusLost:Connect(function()
			if textbox.Text ~= "" then
				returnval.Value = textbox.Text
				func2(textbox.Text)
				textbox.Text = name2.. " : "..textbox.Text
			else
				textbox.Text = name2.. " : "..returnval.Value
			end
		end)

		return returnval
	end
	function buttonFunctions:newPicker(tab2)
		local enabled2 = false
		local name2 = tab2["Name"]
		local Options = tab2["Options"]
		local Default = tab2["Default"]

		local lol = {Option = (Default and Default or Options[1])}

		local button2 = Instance.new("TextButton", dropdown)
		button2.Size = UDim2.fromScale(1, .15)
		button2.Position = UDim2.fromScale(0,0)
		button2.BorderSizePixel = 0
		button2.Font = Enum.Font.Roboto
		button2.TextColor3 = Color3.fromRGB(255,255,255)
		button2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button2.Text = name2 .. " : " .. lol.Option
		button2.Name = name2
		button2.TextSize = 18
		button2.AutoButtonColor = false
		button2.Font = Enum.Font.SourceSans

		local Index = 1
		local pickerFuncs = {
			Switch = function()
				Index += 1
				if Index> #Options then
					Index = 1
				end
				button2.Text = name2.." : "..Options[Index]
				lol.Option = Options[Index]
			end,
		}

		button2.MouseButton1Down:Connect(function()
			pickerFuncs.Switch()
		end)

		return lol
	end

	button.MouseButton1Down:Connect(function()
		buttonFunctions.Toggle()
	end)

	button.MouseButton2Down:Connect(function()
		for i,v in pairs(path:GetChildren()) do
			if v:IsA("UIListLayout") then continue end
			if v.Name ~= name then
				v.Visible = not v.Visible
			end
		end

		dropdown.Visible = not dropdown.Visible
	end)

	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if keyc == nil then return end
		if key.KeyCode == keyc then
			buttonFunctions.Toggle()
		end
	end)

	return buttonFunctions
end
return lib
