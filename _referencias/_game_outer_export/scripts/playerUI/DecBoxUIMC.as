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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3557")]
   public dynamic class DecBoxUIMC extends MovieClip
   {
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var txtDeyPrompt:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdDec:MainButton;
      
      public var bag4:IconBarMC;
      
      public var titleBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function DecBoxUIMC()
      {
         super();
         obf_L_Y_1069();
      }
      
      internal function obf_L_Y_1069() : *
      {
         try
         {
            cmdDec["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDec.emphasized = false;
         cmdDec.enabled = true;
         cmdDec.label = "obf___4972";
         cmdDec.labelPlacement = "right";
         cmdDec.selected = false;
         cmdDec.toggle = false;
         cmdDec.visible = true;
         try
         {
            cmdDec["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

