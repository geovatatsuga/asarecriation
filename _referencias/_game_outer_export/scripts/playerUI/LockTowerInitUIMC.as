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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2046")]
   public dynamic class LockTowerInitUIMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var txtTip1:TextField;
      
      public var txtTip2:TextField;
      
      public var txtTitle:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdSure:MainButton;
      
      public var icon:IconBarMC;
      
      public function LockTowerInitUIMC()
      {
         super();
         obf_0_3_W_365();
      }
      
      internal function obf_0_3_W_365() : *
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

