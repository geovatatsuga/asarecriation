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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3935")]
   public dynamic class RunningManUIMC extends MovieClip
   {
      
      public var txtDeyTitle:TextField;
      
      public var cmdAward:MainButton;
      
      public var bgBox:MovieClip;
      
      public var iconPont1:MovieClip;
      
      public var iconPont2:MovieClip;
      
      public var iconPont3:MovieClip;
      
      public var iconPont4:MovieClip;
      
      public var iconPont5:MovieClip;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var icon4:IconBarMC;
      
      public var icon5:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var icon3:IconBarMC;
      
      public var txtTime:TextField;
      
      public var iconPont7:MovieClip;
      
      public var num1:MovieClip;
      
      public var num2:MovieClip;
      
      public var num3:MovieClip;
      
      public var num4:MovieClip;
      
      public var num5:MovieClip;
      
      public var iconPont6:MovieClip;
      
      public var num7:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var num6:MovieClip;
      
      public function RunningManUIMC()
      {
         super();
         obf_p_D_1890();
      }
      
      internal function obf_p_D_1890() : *
      {
         try
         {
            cmdAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAward.emphasized = false;
         cmdAward.enabled = true;
         cmdAward.label = "Collect Reward";
         cmdAward.labelPlacement = "right";
         cmdAward.selected = false;
         cmdAward.toggle = false;
         cmdAward.visible = true;
         try
         {
            cmdAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

