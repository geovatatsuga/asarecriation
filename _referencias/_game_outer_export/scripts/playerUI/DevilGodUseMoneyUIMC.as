package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3779")]
   public dynamic class DevilGodUseMoneyUIMC extends MovieClip
   {
      
      public var cmdLeft:SimpleButton;
      
      public var cmdClose:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var txtExplain:TextField;
      
      public var cmdRight:SimpleButton;
      
      public var cmdSure:MainButton;
      
      public var txtNum:TextField;
      
      public var txtCount:MJInput;
      
      public function DevilGodUseMoneyUIMC()
      {
         super();
         obf_z_z_1461();
         obf_h_G_2724();
      }
      
      internal function obf_h_G_2724() : *
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
         cmdSure.label = "obf___4891";
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
      
      internal function obf_z_z_1461() : *
      {
         try
         {
            txtCount["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtCount.displayAsPassword = false;
         txtCount.editable = true;
         txtCount.enabled = true;
         txtCount.maxChars = 8;
         txtCount.restrict = "0-9";
         txtCount.text = "";
         txtCount.visible = true;
         try
         {
            txtCount["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

