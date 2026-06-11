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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2128")]
   public dynamic class LockTowerEatUIMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var txtTitle:TextField;
      
      public var txtTip:TextField;
      
      public var cmdSure:MainButton;
      
      public var icon:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public function LockTowerEatUIMC()
      {
         super();
         obf_G_O_2775();
      }
      
      internal function obf_G_O_2775() : *
      {
         try
         {
            cmdSure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSure.emphasized = false;
         cmdSure.enabled = true;
         cmdSure.label = "cmdSure";
         cmdSure.labelPlacement = "right";
         cmdSure.selected = false;
         cmdSure.toggle = false;
         cmdSure.visible = true;
         try
         {
            cmdSure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

