package playerUI
{
   import ControlClass.MJCheckBox;
   import ControlClass.MJInput;
   import ControlClass.MJList;
   import adobe.utils.*;
   import fl.controls.ComboBox;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1338")]
   public dynamic class TeamManagerUIMC extends MovieClip
   {
      
      public var cmdCreateTeam:MainButton;
      
      public var cmdJoinTeam:MainButton;
      
      public var txtDeyTeamItemRank:TextField;
      
      public var txtDeyTeam:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdTeamItemModeOK:MainButton;
      
      public var listTeam:MJList;
      
      public var cmdClose:SimpleButton;
      
      public var cmdQuitTeam:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdDismissTeam:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var listTeamModeRank:ComboBox;
      
      public var inputTeamName:MJInput;
      
      public var chkTeamMode:MJCheckBox;
      
      public var txtDeyMapTeam:TextField;
      
      public var txtDeyTeamItemMode:TextField;
      
      public var chkFreeMode:MJCheckBox;
      
      public var cmdRefreshTeam:MainButton;
      
      public function TeamManagerUIMC()
      {
         super();
         __setProp_cmdJoinTeam_teamManagerUIMC_controls_0();
         __setProp_cmdQuitTeam_teamManagerUIMC_controls_0();
         __setProp_inputTeamName_teamManagerUIMC_controls_0();
         __setProp_cmdCreateTeam_teamManagerUIMC_controls_0();
         __setProp_cmdDismissTeam_teamManagerUIMC_controls_0();
         __setProp_cmdRefreshTeam_teamManagerUIMC_controls_0();
         obf_0_1_M_205();
         obf_Y_l_2148();
         obf_O_2636();
      }
      
      internal function obf_Y_l_2148() : *
      {
         try
         {
            chkTeamMode["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkTeamMode.enabled = true;
         chkTeamMode.label = "obf_____4776";
         chkTeamMode.labelPlacement = "right";
         chkTeamMode.selected = false;
         chkTeamMode.visible = true;
         try
         {
            chkTeamMode["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_M_205() : *
      {
         try
         {
            chkFreeMode["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkFreeMode.enabled = true;
         chkFreeMode.label = "obf_____4818";
         chkFreeMode.labelPlacement = "right";
         chkFreeMode.selected = false;
         chkFreeMode.visible = true;
         try
         {
            chkFreeMode["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdDismissTeam_teamManagerUIMC_controls_0() : *
      {
         try
         {
            cmdDismissTeam["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDismissTeam.emphasized = false;
         cmdDismissTeam.enabled = true;
         cmdDismissTeam.label = "obf_____4820";
         cmdDismissTeam.labelPlacement = "right";
         cmdDismissTeam.selected = false;
         cmdDismissTeam.toggle = false;
         cmdDismissTeam.visible = true;
         try
         {
            cmdDismissTeam["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdJoinTeam_teamManagerUIMC_controls_0() : *
      {
         try
         {
            cmdJoinTeam["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdJoinTeam.emphasized = false;
         cmdJoinTeam.enabled = true;
         cmdJoinTeam.label = "obf_____4766";
         cmdJoinTeam.labelPlacement = "right";
         cmdJoinTeam.selected = false;
         cmdJoinTeam.toggle = false;
         cmdJoinTeam.visible = true;
         try
         {
            cmdJoinTeam["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_O_2636() : *
      {
         try
         {
            cmdTeamItemModeOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTeamItemModeOK.emphasized = false;
         cmdTeamItemModeOK.enabled = true;
         cmdTeamItemModeOK.label = "obf___4864";
         cmdTeamItemModeOK.labelPlacement = "right";
         cmdTeamItemModeOK.selected = false;
         cmdTeamItemModeOK.toggle = false;
         cmdTeamItemModeOK.visible = true;
         try
         {
            cmdTeamItemModeOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_inputTeamName_teamManagerUIMC_controls_0() : *
      {
         try
         {
            inputTeamName["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTeamName.displayAsPassword = false;
         inputTeamName.editable = true;
         inputTeamName.enabled = true;
         inputTeamName.maxChars = 10;
         inputTeamName.restrict = "";
         inputTeamName.text = "";
         inputTeamName.visible = true;
         try
         {
            inputTeamName["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdCreateTeam_teamManagerUIMC_controls_0() : *
      {
         try
         {
            cmdCreateTeam["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCreateTeam.emphasized = false;
         cmdCreateTeam.enabled = true;
         cmdCreateTeam.label = "obf_____4740";
         cmdCreateTeam.labelPlacement = "right";
         cmdCreateTeam.selected = false;
         cmdCreateTeam.toggle = false;
         cmdCreateTeam.visible = true;
         try
         {
            cmdCreateTeam["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdRefreshTeam_teamManagerUIMC_controls_0() : *
      {
         try
         {
            cmdRefreshTeam["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRefreshTeam.emphasized = false;
         cmdRefreshTeam.enabled = true;
         cmdRefreshTeam.label = "obf__4985";
         cmdRefreshTeam.labelPlacement = "right";
         cmdRefreshTeam.selected = false;
         cmdRefreshTeam.toggle = false;
         cmdRefreshTeam.visible = true;
         try
         {
            cmdRefreshTeam["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdQuitTeam_teamManagerUIMC_controls_0() : *
      {
         try
         {
            cmdQuitTeam["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdQuitTeam.emphasized = false;
         cmdQuitTeam.enabled = true;
         cmdQuitTeam.label = "obf_____4748";
         cmdQuitTeam.labelPlacement = "right";
         cmdQuitTeam.selected = false;
         cmdQuitTeam.toggle = false;
         cmdQuitTeam.visible = true;
         try
         {
            cmdQuitTeam["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

