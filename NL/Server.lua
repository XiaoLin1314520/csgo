-- xiaolin1314520

g_Panorama:Exec(
    [[
var panel
var panel2
var layout = `
<root>	
	<Panel class="vertical-align-middle horizontal-center">
		<RadioButton id="CustomPanel"
			onactivate="$.DispatchEvent('PlaySoundEffect', 'mainmenu_press_GO', 'MOUSE' ); 
			GameInterfaceAPI.ConsoleCommand('connect linkhvh.com');"
			oncancel="MainMenu.OnEscapeKeyPressed();"
			onmouseover="UiToolkitAPI.ShowTextTooltip( 'CustomPanel', 'LINK 服务器');"
			onmouseout="UiToolkitAPI.HideTextTooltip();">
			<Image textureheight="42" texturewidth="-1" src="file://{images}/icons/ui/servers.svg" />
		</RadioButton>
    </Panel>
</root>
`

var layout2 = `
<root>	
	<Panel class="vertical-align-middle horizontal-center">
		<RadioButton id="CustomPanel2"
			onactivate="$.DispatchEvent('PlaySoundEffect', 'mainmenu_press_GO', 'MOUSE' ); 
			GameInterfaceAPI.ConsoleCommand('connect 47.108.215.186;password PGC666');"
			oncancel="MainMenu.OnEscapeKeyPressed();"
			onmouseover="UiToolkitAPI.ShowTextTooltip( 'CustomPanel2', 'PGC 测参服');"
			onmouseout="UiToolkitAPI.HideTextTooltip();">
			<Image textureheight="42" texturewidth="-1" src="file://{images}/icons/ui/servers.svg" />
		</RadioButton>
    </Panel>
</root>
`

   function create() {
		var parent = $.GetContextPanel().FindChildTraverse("JsMainMenuNavBar")

      if(!parent) return
      if (parent.FindChild("CustomPanel"))
         parent.FindChild("CustomPanel").DeleteAsync(1)

      if (parent.FindChild("CustomPanel2"))
         parent.FindChild("CustomPanel2").DeleteAsync(1)
      
      panel = $.CreatePanel("Panel", parent, "CustomPanel")
      panel2 = $.CreatePanel("Panel", parent, "CustomPanel2")

		if(!panel || !panel2)
			return
      
		if(!panel.BLoadLayoutFromString(layout, false, false) || !panel2.BLoadLayoutFromString(layout2, false, false))
			return
      
		parent.MoveChildBefore(panel, parent.GetChild(14))
      parent.MoveChildBefore(panel2, parent.GetChild(15))
	}

   function destroy() {
      if(panel != null) {
            panel.RemoveAndDeleteChildren()
            panel.DeleteAsync(0.0)
            panel = null
      }

      if(panel2 != null) {
            panel2.RemoveAndDeleteChildren()
            panel2.DeleteAsync(0.0)
            panel2 = null
      }
   }
]],
    "CSGOMainMenu"
)

g_Panorama:Exec([[create()]])

cheat.RegisterCallback(
    "destroy",
    function()
      print(1)
        g_Panorama:Exec([[destroy()]])
    end
)
