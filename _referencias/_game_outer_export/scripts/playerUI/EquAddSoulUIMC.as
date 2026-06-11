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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4203")]
   public dynamic class EquAddSoulUIMC extends MovieClip
   {
      
      public var txtDeyBeforeSoul:TextField;
      
      public var pointSoulIcon:MovieClip;
      
      public var txtChance:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdDevolve:MainButton;
      
      public var obf_8_3_3181:IconBarMC;
      
      public var cmdSoul:MainButton;
      
      public var txtRemark:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDeyAfterSoul:TextField;
      
      public var iconBar1:IconBarMC;
      
      public var soulBg:MovieClip;
      
      public var iconBar3:IconBarMC;
      
      public var txtAfterAttrValue:TextField;
      
      public var txtDeyChance:TextField;
      
      public var txtAfterAttr:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var iconBar2:IconBarMC;
      
      public var txtBeforeAttr:TextField;
      
      public var txtBeforeAttrValue:TextField;
      
      public var txtDeyCost:TextField;
      
      public var pointCost:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public function EquAddSoulUIMC()
      {
         super();
         obf_0_9_9_615();
         obf_W_U_2146();
      }
      
      internal function obf_0_9_9_615() : *
      {
         try
         {
            cmdDevolve["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDevolve.emphasized = false;
         cmdDevolve.enabled = true;
         cmdDevolve.label = "";
         cmdDevolve.labelPlacement = "right";
         cmdDevolve.selected = false;
         cmdDevolve.toggle = false;
         cmdDevolve.visible = true;
         try
         {
            cmdDevolve["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_W_U_2146() : *
      {
         try
         {
            cmdSoul["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSoul.emphasized = false;
         cmdSoul.enabled = true;
         cmdSoul.label = "";
         cmdSoul.labelPlacement = "right";
         cmdSoul.selected = false;
         cmdSoul.toggle = false;
         cmdSoul.visible = true;
         try
         {
            cmdSoul["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

