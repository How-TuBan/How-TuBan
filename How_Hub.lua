local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "How Hub - Key System",
    SubTitle = "bởi How-TuBan",
    TabWidth = 160,
    Size = UDim2.fromOffset(450, 260),
    Theme = "Dark"
})

local Tab = Window:AddTab({ Title = "Xác Thực Key", Icon = "key" })

local KeyInput = Tab:AddInput("Input", {
    Title = "Key Bảo Vệ",
    Default = "Howdz1606-12", -- Đã tự động điền sẵn Key
    Placeholder = "Nhập Key...",
    Numeric = false,
    Finished = false,
})

Tab:AddButton({
    Title = "Mở Khóa Script",
    Callback = function()
        local enteredKey = KeyInput.Value
        Fluent:Notify({ Title = "Hệ thống", Content = "Đang kiểm tra Key...", Duration = 2 })

        local workerUrl = "https://how-hub.howutuban.workers.dev/?key=" .. enteredKey
        local success, result = pcall(function()
            return game:HttpGet(workerUrl)
        end)

        if success and result ~= "INVALID_KEY" and result ~= "GITHUB_ERROR" then
            Fluent:Notify({ Title = "Thành Công!", Content = "Đang tải Hub...", Duration = 2 })
            task.wait(1)
            Window:Destroy()
            loadstring(result)()
        else
            Fluent:Notify({ Title = "Thất Bại!", Content = "Key không đúng hoặc sai môi trường!", Duration = 3 })
        end
    end
})
