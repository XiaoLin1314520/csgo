g_Panorama:Exec([[
if(typeof(ReportToolAInjected) == "undefined") {
var layoutaw = "\t<root>\n\t\t<styles>\n\t\t\t<include src=\"file:\/\/{resources}\/styles\/csgostyles.css\" \/>\n\t\t\t<include src=\"file:\/\/{resources}\/styles\/mainmenu.css\" \/>\n\t\t<\/styles>\n\t\t\n\t\t<Panel class=\"horizontal-center\">\n\t\t\t<RadioButton id=\"CustomReportBtn\"\n\t\t\t\t\t\tclass=\"mainmenu-navbar__btn-small PauseMenuModeOnly\"\n\t\t\t\t\t\tonmouseover=\"UiToolkitAPI.ShowTextTooltip('CustomReportBtn','举报工具');\"\n\t\t\t\t\t\tonmouseout=\"UiToolkitAPI.HideTextTooltip();\">\n\t\t\t\t\t<Image textureheight=\"32\" texturewidth=\"-1\" src=\"file:\/\/{images}\/icons\/ui\/warning.svg\" \/>\n\t\t\t<\/RadioButton>\n\t\t<\/Panel>\n\t<\/root>\n"
ReportEssientials = {
ReportAll : function(teamName, muting){
if(!teamName){
teamName = (GameStateAPI.GetPlayerTeamName(GameStateAPI.GetLocalOrInEyePlayerXuid()) == "CT") ? "TERRORIST" : "CT"
}
var oPlayerList = GameStateAPI.GetPlayerDataJSO()
var reportPlayerXUIDList = []
if ( !oPlayerList || Object.keys( oPlayerList ).length === 0 ){                                 
return false
}
for ( var i in oPlayerList[ teamName ] ){
var xuid = oPlayerList[ teamName ][ i ];
if ( xuid == 0 )
continue;

if(GameStateAPI.IsXuidValid(xuid) && !GameStateAPI.IsFakePlayer(xuid)){
reportPlayerXUIDList.push(xuid)
}
}
reportPlayerXUIDList.forEach(function(item, index){
$.Schedule(index, ReportEssientials.ReportCore(item, muting))
if(index == (reportPlayerXUIDList.length - 1)){$.Schedule(index, function(){$.DispatchEvent('BlurrrButton')})}
})
},
ReportCore : function(xuid, muting){
return function(){
if(GameStateAPI.GetLocalPlayerXuid() == xuid)
return
var cats = ["textabuse", "voiceabuse", "grief", "wallhack", "aimbot", "speedhack"]
cats.forEach(function(item, index){
if (!GameStateAPI.IsReportCategoryEnabledForSelectedPlayer(xuid, item)){
cats.splice(index, 1)
}
})
var ifMuted = false
if(muting){
ifMuted = GameStateAPI.IsSelectedPlayerMuted(xuid)
}
GameStateAPI.SubmitPlayerReport(xuid, cats.toString() + ",")
$.Msg("[Report] Reporting " + xuid + " with " + cats.toString())
if(muting && (GameStateAPI.IsSelectedPlayerMuted(xuid) != ifMuted)){
GameStateAPI.ToggleMute(xuid)
}
}
}
}

var _GetCurrentMenus = function(){
var _ItemConstruct = function(name, cmd){
return {
label : name,
jsCallback : cmd
}
}
var Menu = []
Menu.push(_ItemConstruct("举报所有恐怖分子", function(){ReportEssientials.ReportAll("TERRORIST", false);}))
Menu.push(_ItemConstruct("举报所有CT", function(){ReportEssientials.ReportAll("CT", false);}))
Menu.push(_ItemConstruct("举报所有敌人", function(){ReportEssientials.ReportAll();}))
Menu.push(_ItemConstruct("举报敌人并取消静音", function(){ReportEssientials.ReportAll(false, true);}))
return Menu
}
var ReportMainFunc = {
create : function(){
var obj_LSidebarMenu = $.GetContextPanel().GetChild(0).FindChildTraverse('JsMainMenuNavBar')
if(!obj_LSidebarMenu){
return
}
var panel = $.CreatePanel("Panel", obj_LSidebarMenu, "CustomReportBtnPanel")
if(!panel)
return
if(!panel.BLoadLayoutFromString(layoutaw, false, false))
return
obj_LSidebarMenu.MoveChildAfter(panel, obj_LSidebarMenu.FindChildTraverse("MainMenuNavBarSettings"))
var button = panel.FindChildTraverse("CustomReportBtn")
if(button) {
var _ShowVote = function () {
button.checked = false
var contextMenuPanel = UiToolkitAPI.ShowSimpleContextMenu( "CustomReportBtn", "", _GetCurrentMenus())
contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
};
button.SetPanelEvent("onactivate", _ShowVote)
}
$.DefineEvent( 'BlurrrButton', 0, '', "Button go blurrr" );
var handleFunc = $.RegisterForUnhandledEvent( 'BlurrrButton', function(){
if(button) {
button.checked = false
}
})
$.Msg("[Report] Injected Successfully! Welcome: " + MyPersonaAPI.GetName())
return {
destroy : function() {
if(panel != null) {
$.UnregisterForUnhandledEvent( 'BlurrrButton', handleFunc )
panel.RemoveAndDeleteChildren()
panel.DeleteAsync(0.0)
panel = null
}
},
panel : panel
}
}
}
ReportMainFunc.create()
ReportToolAInjected = true
}
]], "CSGOMainMenu")