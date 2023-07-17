--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type WBP_Option_C
local M = UnLua.Class()

--function M:Initialize(Initializer)
--end

--function M:PreConstruct(IsDesignTime)
--end

function M:de_windowmode()
    self.windowmode_int = UE.UKismetMathLibrary.Conv_ByteToInt(self.windowmode)
    self.windowmode = UE.UKismetMathLibrary.Conv_IntToByte(UE.UKismetMathLibrary.Clamp(self.windowmode_int - 1 , 0, 2))
end

function M:in_windowmode()
    self.windowmode_int = UE.UKismetMathLibrary.Conv_ByteToInt(self.windowmode)
    self.windowmode = UE.UKismetMathLibrary.Conv_IntToByte(UE.UKismetMathLibrary.Clamp(self.windowmode_int + 1 , 0, 2))
end

function M:de_resolution()
    self.ResolutionIndex = UE.UKismetMathLibrary.Clamp(self.ResolutionIndex - 1, 0, 4)
    if self.ResolutionIndex == 0 then
        self.Resolution.X = 1280
        self.Resolution.Y = 720
    elseif self.ResolutionIndex == 1 then
        self.Resolution.X = 1600
        self.Resolution.Y = 900
    elseif self.ResolutionIndex == 2 then
        self.Resolution.X = 1920
        self.Resolution.Y = 1080
    elseif self.ResolutionIndex == 3 then
        self.Resolution.X = 2560
        self.Resolution.Y = 1440
    elseif self.ResolutionIndex == 4 then
        self.Resolution.X = 3840
        self.Resolution.Y = 2160
    end
end

function M:in_resolution()
    self.ResolutionIndex = UE.UKismetMathLibrary.Clamp(self.ResolutionIndex + 1, 0, 4)
    if self.ResolutionIndex == 0 then
        self.Resolution.X = 1280
        self.Resolution.Y = 720
    elseif self.ResolutionIndex == 1 then
        self.Resolution.X = 1600
        self.Resolution.Y = 900
    elseif self.ResolutionIndex == 2 then
        self.Resolution.X = 1920
        self.Resolution.Y = 1080
    elseif self.ResolutionIndex == 3 then
        self.Resolution.X = 2560
        self.Resolution.Y = 1440
    elseif self.ResolutionIndex == 4 then
        self.Resolution.X = 3840
        self.Resolution.Y = 2160
    end
end

function M:in_graphic()
    self.GraphicsIndex = UE.UKismetMathLibrary.Clamp(self.GraphicsIndex + 1, 0, 4)
end

function M:de_graphic()
    self.GraphicsIndex = UE.UKismetMathLibrary.Clamp(self.GraphicsIndex - 1, 0, 4)
end

function M:SetVsync()
    self.Vsync = not self.Vsync
end

function M:Apply()
    self.usersetting:SetFullscreenMode(self.windowmode)
    self.usersetting:SetOverallScalabilityLevel(self.GraphicsIndex)
    self.usersetting:SetVSyncEnabled(self.Vsync)
    self.usersetting:SetScreenResolution(self.Resolution)
    self.usersetting:ApplySettings(true)
    self:SetVisibility(UE.ESlateVisibility.Collapsed)
    if UE.UGameplayStatics.GetCurrentLevelName(self:GetWorld(),true) == "DefaultLevel" then
        local __widgets = UE.TArray(UE.UUserWidget)
        UE.UWidgetBlueprintLibrary.GetAllWidgetsOfClass(
            self:GetWorld(),
            __widgets,
            UE.UClass.Load("/Game/TestFile/UserWidget/WBP_UI.WBP_UI_C"),
            false
        )
        self.WBP_UI = __widgets:GetRef(1)
        self.WBP_UI:SetVisibility(UE.ESlateVisibility.Visible)
    else
        local __widgets = UE.TArray(UE.UUserWidget)
        UE.UWidgetBlueprintLibrary.GetAllWidgetsOfClass(
            self:GetWorld(),
            __widgets,
            UE.UClass.Load("/Game/TestFile/UserWidget/WBP_PauseMenu.WBP_PauseMenu_C"),
            false
        )
        self.WBP_Pasumenu = __widgets:GetRef(1)
        self.WBP_Pasumenu:SetVisibility(UE.ESlateVisibility.Visible)
    end
end

function M:Construct()
    self.usersetting = UE.UGameUserSettings.GetGameUserSettings()
    self.usersetting:LoadSettings(false)
    self.WindowMode = self.usersetting:GetFullscreenMode()
    self.GraphicsIndex = self.usersetting:GetOverallScalabilityLevel()
    self.Vsync = self.usersetting:IsVSyncEnabled()
    self.Resolution = self.usersetting:GetScreenResolution()
    if self.Resolution.X == 1280 then
        self.ResolutionIndex = 0
    elseif self.Resolution.X == 1600 then
        self.ResolutionIndex = 1
    elseif self.Resolution.X == 1920 then
        self.ResolutionIndex = 2
    elseif self.Resolution.X == 2560 then
        self.ResolutionIndex = 3
    elseif self.Resolution.X == 3840 then
        self.ResolutionIndex = 4
    end
    self.de_windowmode_button.OnClicked:Add(self,self.de_windowmode)
    self.in_windowmode_button.OnClicked:Add(self,self.in_windowmode)
    self.In_Resolution_Button.OnClicked:Add(self,self.in_resolution)
    self.De_Resolution_Button.OnClicked:Add(self,self.de_resolution)
    self.De_Graphics_Button.OnClicked:Add(self,self.de_graphic)
    self.In_Graphics_Button.OnClicked:Add(self,self.in_graphic)
    self.De_Vsync_Button.OnClicked:Add(self,self.SetVsync)
    self.In_Vsync_Button.OnClicked:Add(self,self.SetVsync)
    self.Apply_Button.OnClicked:Add(self,self.Apply)
end

--function M:Tick(MyGeometry, InDeltaTime)
--end

return M
