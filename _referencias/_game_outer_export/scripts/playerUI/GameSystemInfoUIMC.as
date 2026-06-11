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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol420")]
   public dynamic class GameSystemInfoUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var scrollInfo:UIScrollBar;
      
      public var txtInfo:TextField;
      
      public function GameSystemInfoUIMC()
      {
         super();
         obf_h_j_2861();
      }
      
      internal function obf_h_j_2861() : *
      {
         try
         {
            scrollInfo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollInfo.direction = "vertical";
         scrollInfo.scrollTargetName = "txtInfo";
         scrollInfo.visible = true;
         try
         {
            scrollInfo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

