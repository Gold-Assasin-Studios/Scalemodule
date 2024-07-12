-- Please check the devforum post for more information
-- https://devforum.roblox.com/t/scalemodule-scale-your-gui-with-just-a-script/3065623

local scalemodule = {}

local function adjust_scale_and_offset(udim2, parent)
    local xScale = udim2.X.Scale
    local xOffset = udim2.X.Offset
    local yScale = udim2.Y.Scale
    local yOffset = udim2.Y.Offset
    local adjustedXScale = xScale + (xOffset / parent.AbsoluteSize.X)
    local adjustedYScale = yScale + (yOffset / parent.AbsoluteSize.Y)
    
    return UDim2.new(adjustedXScale, xOffset, adjustedYScale, yOffset)
end

local function scale_ui_instance(instance)
    if instance:IsA("GuiObject") then
        instance.Size = adjust_scale_and_offset(instance.Size, instance.Parent)
        instance.Position = adjust_scale_and_offset(instance.Position, instance.Parent)
    end

    for _, child in pairs(instance:GetChildren()) do
        scale_ui_instance(child)
    end
end

function scalemodule.scale_all_ui_instances(screengui)
    if not screengui:IsA("ScreenGui") then
        error("The provided instance is not a ScreenGui")
    end
    
    for _, instance in pairs(screengui:GetChildren()) do
        scale_ui_instance(instance)
    end
end

return scalemodule
