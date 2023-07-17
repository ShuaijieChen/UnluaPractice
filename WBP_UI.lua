--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type WBP_UI_C
local M = UnLua.Class()

function M:Quit()
    UE.UKismetSystemLibrary.QuitGame(self:GetWorld(),self.controller,0,false)
end

function M:Option()
    self.option_root = UE.UClass.Load("/Game/TestFile/UserWidget/WBP_Option.WBP_Option_C")
	self.option_class = NewObject(self.option_root, self)
	self.option_class:AddToViewport()
    self:SetVisibility(UE.ESlateVisibility.Collapsed)
end

function M:Start()
    UE.UGameplayStatics.OpenLevel(self:GetWorld(),"ThirdPersonExampleMap",true,nil)
    UE.UWidgetBlueprintLibrary.SetInputMode_GameOnly(self.controller)
    self.controller.bShowMouseCursor = false
    UE.UGameplayStatics.SetGamePaused(self:GetWorld(),false)
end

--function M:Initialize(Initializer)
--end

--function M:PreConstruct(IsDesignTime)
--end

function M:Construct()
    self.controller = UE.UGameplayStatics.GetPlayerController(self:GetWorld(),0)
    self.Exit_Button.OnClicked:Add(self,self.Quit)
    self.Option_Button.OnClicked:Add(self,self.Option)
    self.Start_Button.Onclicked:Add(self,self.Start)
end

--function M:Tick(MyGeometry, InDeltaTime)
--end

return M
