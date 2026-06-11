package playerUI
{
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1332")]
   public dynamic class EquipRepairUIMC extends MovieClip
   {
      
      public var equipBar:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var pointGold:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var pointMoney:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var cmdPerfectRepair:MainButton;
      
      public var txtEquName:TextField;
      
      public var cmdRepair:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var txtPrompt1:TextField;
      
      public var txtPrompt2:TextField;
      
      public function EquipRepairUIMC()
      {
         super();
         obf_t_y_2672();
         obf_1_0_2476();
      }
      
      internal function obf_t_y_2672() : *
      {
         try
         {
            cmdRepair["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRepair.emphasized = false;
         cmdRepair.enabled = true;
         cmdRepair.label = "obf_____4717";
         cmdRepair.labelPlacement = "right";
         cmdRepair.selected = false;
         cmdRepair.toggle = false;
         cmdRepair.visible = true;
         try
         {
            cmdRepair["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_1_0_2476() : *
      {
         try
         {
            cmdPerfectRepair["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPerfectRepair.emphasized = false;
         cmdPerfectRepair.enabled = true;
         cmdPerfectRepair.label = "obf_____4751";
         cmdPerfectRepair.labelPlacement = "right";
         cmdPerfectRepair.selected = false;
         cmdPerfectRepair.toggle = false;
         cmdPerfectRepair.visible = true;
         try
         {
            cmdPerfectRepair["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

