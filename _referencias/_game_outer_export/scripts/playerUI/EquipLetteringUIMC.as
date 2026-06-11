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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3505")]
   public dynamic class EquipLetteringUIMC extends MovieClip
   {
      
      public var txtDeyInput:TextField;
      
      public var bagEquip:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var inputLettering:TextField;
      
      public var txtDeyPushEquipment:TextField;
      
      public var cmdOK:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function EquipLetteringUIMC()
      {
         super();
         obf_0_8_4_178();
      }
      
      internal function obf_0_8_4_178() : *
      {
         try
         {
            cmdOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOK.emphasized = false;
         cmdOK.enabled = true;
         cmdOK.label = "obf___4891";
         cmdOK.labelPlacement = "right";
         cmdOK.selected = false;
         cmdOK.toggle = false;
         cmdOK.visible = true;
         try
         {
            cmdOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

