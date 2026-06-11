package playerUI
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3060")]
   public dynamic class RankingUIMC extends MovieClip
   {
      
      public var obf_0_1_n_363:RankItemBox;
      
      public var bgBox:MovieClip;
      
      public var pointList:MovieClip;
      
      public var InstanceName_0:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtDeyJobName:TextField;
      
      public var obf_k_v_1843:UIScrollBar;
      
      public var txtDeyRank:TextField;
      
      public var list:MJList;
      
      public var cmdClose:SimpleButton;
      
      public var txtInfoName:TextField;
      
      public var pointType:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyPlayerName:TextField;
      
      public function RankingUIMC()
      {
         super();
         obf_v_o_3937();
      }
      
      internal function obf_v_o_3937() : *
      {
         try
         {
            obf_k_v_1843["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_k_v_1843.direction = "vertical";
         obf_k_v_1843.scrollTargetName = "InstanceName_0";
         obf_k_v_1843.visible = true;
         try
         {
            obf_k_v_1843["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

