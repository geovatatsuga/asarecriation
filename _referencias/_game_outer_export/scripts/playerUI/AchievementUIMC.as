package playerUI
{
   import adobe.utils.*;
   import fl.controls.DataGrid;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2293")]
   public dynamic class AchievementUIMC extends MovieClip
   {
      
      public var txtDeySuccessCondition:TextField;
      
      public var txtDeySuccessAward:TextField;
      
      public var listSuccess:DataGrid;
      
      public var bgBox:MovieClip;
      
      public var barSuccessTotle:MovieClip;
      
      public var pointSuccessAward:MovieClip;
      
      public var obf_X_d_2366:UIScrollBar;
      
      public var txtTitleContent:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtSuccessTotle:TextField;
      
      public var txtSuccessCondition:TextField;
      
      public var txtDeyTitleContent:TextField;
      
      public var pointType:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public function AchievementUIMC()
      {
         super();
         obf_j_o_2389();
      }
      
      internal function obf_j_o_2389() : *
      {
         try
         {
            obf_X_d_2366["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_X_d_2366.direction = "vertical";
         obf_X_d_2366.scrollTargetName = "txtSuccessCondition";
         obf_X_d_2366.visible = true;
         try
         {
            obf_X_d_2366["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

