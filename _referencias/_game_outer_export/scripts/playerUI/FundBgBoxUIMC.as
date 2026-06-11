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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol836")]
   public dynamic class FundBgBoxUIMC extends MovieClip
   {
      
      public var childUIPoint:MovieClip;
      
      public var monthCardBtn:MainButton;
      
      public var bgBox:MovieClip;
      
      public var boonBtn:MainButton;
      
      public var tuFundBtn:MainButton;
      
      public var FundBtn:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyTitle:TextField;
      
      public function FundBgBoxUIMC()
      {
         super();
         obf_o_r_1740();
      }
      
      internal function obf_o_r_1740() : *
      {
         try
         {
            monthCardBtn["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         monthCardBtn.emphasized = false;
         monthCardBtn.enabled = true;
         monthCardBtn.label = "Monthly Card Rebate";
         monthCardBtn.labelPlacement = "right";
         monthCardBtn.selected = false;
         monthCardBtn.toggle = false;
         monthCardBtn.visible = true;
         try
         {
            monthCardBtn["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

