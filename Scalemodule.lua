-- Please check the devforum post for more information

local scalemodule = {}

local function convert_to_scale(udim2, parent)
	local xScale = udim2.X.Scale + (udim2.X.Offset / parent.AbsoluteSize.X)
	local yScale = udim2.Y.Scale + (udim2.Y.Offset / parent.AbsoluteSize.Y)
	return UDim2.new(xScale, 0, yScale, 0)
end

function scale_ui_instance(instance:Instance)
	if instance:IsA("GuiObject") then
		instance.Size = convert_to_scale(instance.Size, instance.Parent)
		instance.Position = convert_to_scale(instance.Position, instance.Parent)
	end

	for _, child in pairs(instance:GetChildren()) do
		scale_ui_instance(child)
	end
end

function scalemodule.scale_all_ui_instances(screengui:ScreenGui)
	if not screengui:IsA("ScreenGui") then
		error("The provided instance is not a ScreenGui")
	end
	
	for _, instance in pairs(screengui:GetChildren()) do
		scale_ui_instance(instance)
	end
end

return scalemodule
