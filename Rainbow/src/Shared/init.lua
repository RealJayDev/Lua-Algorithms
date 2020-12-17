local module = {}
-- Originally made by: Codepixl (https://codepen.io/Codepixl/pen/ogWWaK/)
-- Converted by: RealJayDev
-- Date: 17/12/2020

-- Services

local Run = game:GetService("RunService")
local Collection = game:GetService("CollectionService")

-- Variables
local r = 255
local g = 0
local b = 0

local Increment = 3 -- Speed factor. increasing too high will cause it to become choppy

local Tag = "Rainbow"

-- Code

function module:GetColor()
    if r > 0 and b == 0 then
        r -= Increment
        g += Increment
    elseif g > 0 and r == 0 then
        g -= Increment
        b += Increment
    elseif b > 0 and g == 0 then
        b -= Increment
        r += Increment
    end
end

function module:UpdateInstances()
    for _, v in pairs(Collection:GetTagged(Tag)) do
        if v:IsA("TextLabel") then
            v.TextColor3 = Color3.fromRGB(r, g, b)
            if v.Name == "Diagnostic" then
                v.Text = "RGB: " .. r ..", " .. g .. ", " ..  b
            end
        elseif v:IsA("Part") then
            v.Color3 = Color3.fromRGB(r, g, b)
        end
    end
end

Run.RenderStepped:Connect(function()
    module:GetColor()
    module:UpdateInstances()
end)

return module