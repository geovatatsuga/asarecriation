package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3461")]
   public dynamic class BoothBfmUIMC extends MovieClip
   {
      
      public var allayMony:MovieClip;
      
      public var pointItems:MovieClip;
      
      public var InstanceName_1:MovieClip;
      
      public var scrollItems:UIScrollBar;
      
      public var allMony:MovieClip;
      
      public var txtAllayMony:TextField;
      
      public var cmdBfmBuy:MainButton;
      
      public var txtAllMony:TextField;
      
      public function BoothBfmUIMC()
      {
         super();
         obf_Z_q_3323();
         obf_0_8_0_631();
      }
      
      internal function obf_0_8_0_631() : *
      {
         try
         {
            scrollItems["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollItems.direction = "vertical";
         scrollItems.scrollTargetName = "InstanceName_1";
         scrollItems.visible = true;
         try
         {
            scrollItems["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Z_q_3323() : *
      {
         try
         {
            cmdBfmBuy["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBfmBuy.emphasized = false;
         cmdBfmBuy.enabled = true;
         cmdBfmBuy.label = "obf_______1795";
         cmdBfmBuy.labelPlacement = "right";
         cmdBfmBuy.selected = false;
         cmdBfmBuy.toggle = false;
         cmdBfmBuy.visible = true;
         try
         {
            cmdBfmBuy["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

