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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol976")]
   public dynamic class ActivityUIMC extends MovieClip
   {
      
      public var txtDeyActLevel:TextField;
      
      public var txtDeyActTimes:TextField;
      
      public var txtActNpc:TextField;
      
      public var obf_h_I_782:UIScrollBar;
      
      public var titleBox:MovieClip;
      
      public var txtDeyActName:TextField;
      
      public var txtDeyActNpc:TextField;
      
      public var txtActDate:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyActTime:TextField;
      
      public var txtDeyActStatus:TextField;
      
      public var txtActTime:TextField;
      
      public var pointType:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyActDate:TextField;
      
      public var txtDeyActDate2:TextField;
      
      public var obf_h_o_2384:UIScrollBar;
      
      public var txtInfo:TextField;
      
      public var pointActivity:MovieClip;
      
      public function ActivityUIMC()
      {
         super();
         obf_l_C_2883();
      }
      
      internal function obf_l_C_2883() : *
      {
         try
         {
            obf_h_o_2384["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_h_o_2384.direction = "vertical";
         obf_h_o_2384.scrollTargetName = "txtInfo";
         obf_h_o_2384.visible = true;
         try
         {
            obf_h_o_2384["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

