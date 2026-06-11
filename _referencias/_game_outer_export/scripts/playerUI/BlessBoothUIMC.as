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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3513")]
   public dynamic class BlessBoothUIMC extends MovieClip
   {
      
      public var cmdBless:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyPrice:TextField;
      
      public var txtDeyBlessSkill:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var txtBlessName:TextField;
      
      public var bagBlessSkill:IconBarMC;
      
      public var inputPrice:MJInput;
      
      public function BlessBoothUIMC()
      {
         super();
         obf_4_R_1195();
         obf_o_4639();
      }
      
      internal function obf_o_4639() : *
      {
         try
         {
            inputPrice["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputPrice.displayAsPassword = false;
         inputPrice.editable = true;
         inputPrice.enabled = true;
         inputPrice.maxChars = 4;
         inputPrice.restrict = "0-9";
         inputPrice.text = "";
         inputPrice.visible = true;
         try
         {
            inputPrice["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_R_1195() : *
      {
         try
         {
            cmdBless["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBless.emphasized = false;
         cmdBless.enabled = true;
         cmdBless.label = "obf_____4812";
         cmdBless.labelPlacement = "right";
         cmdBless.selected = false;
         cmdBless.toggle = false;
         cmdBless.visible = true;
         try
         {
            cmdBless["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

