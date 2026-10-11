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
    Default = "Howdz1606-12",
    Placeholder = "Nhập Key...",
    Numeric = false,
    Finished = false,
})

Tab:AddButton({
    Title = "Mở Khóa Script",
    Callback = function()
        local enteredKey = KeyInput.Value
        if enteredKey == "" then
            Fluent:Notify({ Title = "Thông báo", Content = "Vui lòng nhập Key!", Duration = 3 })
            return
        end

        Fluent:Notify({ Title = "Hệ thống", Content = "Đang kiểm tra Key...", Duration = 2 })

        local workerUrl = "https://how-hub.howutuban.workers.dev/?key=" .. enteredKey
        
        local result = nil
        pcall(function()
            local reqFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
            if reqFunc then
                local res = reqFunc({
                    Url = workerUrl,
                    Method = "GET",
                    Headers = {
                        ["X-Roblox-Script"] = "true"
                    }
                })
                if res and res.Body then
                    result = res.Body
                end
            end
        end)

        if not result or result == "" then
            pcall(function()
                result = game:HttpGet(workerUrl)
            end)
        end

        if result and result ~= "INVALID_KEY" and result ~= "GITHUB_ERROR" and not string.find(result, "ACCESS_DENIED") then
            Fluent:Notify({ Title = "Thành Công!", Content = "Đang tải Hub...", Duration = 2 })
            task.wait(1)
            Window:Destroy()
            
            loadstring(result)()
        else
            Fluent:Notify({ Title = "Thất Bại!", Content = "Key sai hoặc lỗi kết nối máy chủ!", Duration = 3 })
        end
    end
})
