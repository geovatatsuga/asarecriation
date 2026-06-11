package somcUI_fla
{
   import ControlClass.MJInput;
   import ControlClass.MJList;
   import adobe.utils.*;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2475")]
   public dynamic class managerContent_290 extends MovieClip
   {
      
      public var cmdUseStyle:MainButton;
      
      public var txtDeyFarmLevel:TextField;
      
      public var txtDeyFarmName:TextField;
      
      public var txtDeyLeveUp:TextField;
      
      public var txtExp:TextField;
      
      public var inputFarmName:MJInput;
      
      public var cmdRename:MainButton;
      
      public var cmdLevelUp:MainButton;
      
      public var cmdBuyStyle:MainButton;
      
      public var listStyle:MJList;
      
      public var txtLevel:TextField;
      
      public var txtDeyFarmStyle:TextField;
      
      public var levelUpGold:MovieClip;
      
      public function managerContent_290()
      {
         super();
         obf_B_T_2439();
         obf_0_3_A_690();
         obf_I_J_3304();
         obf_O_N_2082();
         obf_1_e_919();
      }
      
      internal function obf_O_N_2082() : *
      {
         try
         {
            cmdUseStyle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUseStyle.emphasized = false;
         cmdUseStyle.enabled = true;
         cmdUseStyle.label = "obf___4964";
         cmdUseStyle.labelPlacement = "right";
         cmdUseStyle.selected = false;
         cmdUseStyle.toggle = false;
         cmdUseStyle.visible = true;
         try
         {
            cmdUseStyle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_A_690() : *
      {
         try
         {
            cmdRename["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRename.emphasized = false;
         cmdRename.enabled = true;
         cmdRename.label = "obf___4906";
         cmdRename.labelPlacement = "right";
         cmdRename.selected = false;
         cmdRename.toggle = false;
         cmdRename.visible = true;
         try
         {
            cmdRename["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_I_J_3304() : *
      {
         try
         {
            cmdLevelUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLevelUp.emphasized = false;
         cmdLevelUp.enabled = true;
         cmdLevelUp.label = "obf_____4706";
         cmdLevelUp.labelPlacement = "right";
         cmdLevelUp.selected = false;
         cmdLevelUp.toggle = false;
         cmdLevelUp.visible = true;
         try
         {
            cmdLevelUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_1_e_919() : *
      {
         try
         {
            cmdBuyStyle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuyStyle.emphasized = false;
         cmdBuyStyle.enabled = true;
         cmdBuyStyle.label = "obf___4920";
         cmdBuyStyle.labelPlacement = "right";
         cmdBuyStyle.selected = false;
         cmdBuyStyle.toggle = false;
         cmdBuyStyle.visible = true;
         try
         {
            cmdBuyStyle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_B_T_2439() : *
      {
         try
         {
            inputFarmName["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputFarmName.displayAsPassword = false;
         inputFarmName.editable = true;
         inputFarmName.enabled = true;
         inputFarmName.maxChars = 8;
         inputFarmName.restrict = "";
         inputFarmName.text = "";
         inputFarmName.visible = true;
         try
         {
            inputFarmName["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

