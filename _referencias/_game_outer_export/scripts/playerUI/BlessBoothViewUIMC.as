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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol694")]
   public dynamic class BlessBoothViewUIMC extends MovieClip
   {
      
      public var bagBlessSkill:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var txtDeyMyCharmInt:TextField;
      
      public var txtDeyTransacCount:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtBlessName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyPrice:TextField;
      
      public var cmdBuy:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var txtMyCharmInt:TextField;
      
      public var txtTransacCount:TextField;
      
      public var txtPrice:TextField;
      
      public var txtDeyBlessSkill:TextField;
      
      public function BlessBoothViewUIMC()
      {
         super();
         obf_G_P_1043();
      }
      
      internal function obf_G_P_1043() : *
      {
         try
         {
            cmdBuy["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuy.emphasized = false;
         cmdBuy.enabled = true;
         cmdBuy.label = "obf_____4761";
         cmdBuy.labelPlacement = "right";
         cmdBuy.selected = false;
         cmdBuy.toggle = false;
         cmdBuy.visible = true;
         try
         {
            cmdBuy["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

