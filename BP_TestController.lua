--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type BP_TestController_C
local M = UnLua.Class()
local BindKey = UnLua.Input.BindKey

-- function M:Initialize(Initializer)
-- end

-- function M:UserConstructionScript()
-- end

function M:ReceiveBeginPlay()
    self.pausemenu_root = UE.UClass.Load("/Game/TestFile/UserWidget/WBP_PauseMenu.WBP_PauseMenu_C")
	self.pausemenu_class = NewObject(self.pausemenu_root, self)
	self.pausemenu_class:AddToViewport()
    self.pausemenu_class:SetVisibility(UE.ESlateVisibility.Collapsed)
    self.controller = UE.UGameplayStatics.GetPlayerController(self:GetWorld(),0)
end

BindKey(M, "M", "Pressed", function(self, key)
	self.pausemenu_class:SetVisibility(UE.ESlateVisibility.Visible)
    UE.UGameplayStatics.SetGamePaused(self:GetWorld(),true)
    self.controller.bShowMouseCursor = true
    UE.UWidgetBlueprintLibrary.SetInputMode_GameAndUI(self.controller)
end)

-- function M:ReceiveEndPlay()
-- end

-- function M:ReceiveTick(DeltaSeconds)
-- end

-- function M:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
-- end

-- function M:ReceiveActorBeginOverlap(OtherActor)
-- end

-- function M:ReceiveActorEndOverlap(OtherActor)
-- end

return M
