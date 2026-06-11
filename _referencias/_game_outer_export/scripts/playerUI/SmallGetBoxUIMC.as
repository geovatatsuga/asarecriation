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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5052")]
   public dynamic class SmallGetBoxUIMC extends MovieClip
   {
      
      public var moneyTxt:TextField;
      
      public var conditionTxt:TextField;
      
      public var icon:IconBarMC;
      
      public var cmdBuy:MainButton;
      
      public function SmallGetBoxUIMC()
      {
         super();
         obf_k_P_2778();
      }
      
      internal function obf_k_P_2778() : *
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
         cmdBuy.label = "obf___4957";
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

