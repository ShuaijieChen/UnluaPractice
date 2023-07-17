--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type WBP_PauseMenu_C
local M = UnLua.Class()

--function M:Initialize(Initializer)
--end

--function M:PreConstruct(IsDesignTime)
--end

function M:Continue()
    self:SetVisibility(UE.ESlateVisibility.Collapsed)
    UE.UWidgetBlueprintLibrary.SetInputMode_GameOnly(self.controller)
    self.controller.bShowMouseCursor = false
    UE.UGameplayStatics.SetGamePaused(self:GetWorld(),false)
end

function M:Option()
    self.option_root = UE.UClass.Load("/Game/TestFile/UserWidget/WBP_Option.WBP_Option_C")
	self.option_class = NewObject(self.option_root, self)
	self.option_class:AddToViewport()
    self:SetVisibility(UE.ESlateVisibility.Collapsed)
end

function M:Exit()
    UE.UGameplayStatics.OpenLevel(self:GetWorld(),"DefaultLevel",true,nil)
end

function M:Construct()
    self.controller = UE.UGameplayStatics.GetPlayerController(self:GetWorld(),0)
    self.Continue_Button.OnClicked:Add(self,self.Continue)
    self.Exit_Button.OnClicked:Add(self,self.Exit)
    self.Option_Button.OnClicked:Add(self,self.Option)
end

--function M:Tick(MyGeometry, InDeltaTime)
--end

return M
