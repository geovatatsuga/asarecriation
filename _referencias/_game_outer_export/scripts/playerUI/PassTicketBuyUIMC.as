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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3509")]
   public dynamic class PassTicketBuyUIMC extends MovieClip
   {
      
      public var obf_j_3_4375:MovieClip;
      
      public var bg:MovieClip;
      
      public var txtTitle:TextField;
      
      public var obf_8_2_3423:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtHighMoney:TextField;
      
      public var cmdBuyMidd:MainButton;
      
      public var txtMiddMoney:TextField;
      
      public var iconMidd:IconBarMC;
      
      public var iconHigh:IconBarMC;
      
      public var cmdBuyHigh:MainButton;
      
      public function PassTicketBuyUIMC()
      {
         super();
         obf_l_B_4327();
         obf_b_7_3885();
      }
      
      internal function obf_l_B_4327() : *
      {
         try
         {
            cmdBuyMidd["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuyMidd.emphasized = false;
         cmdBuyMidd.enabled = true;
         cmdBuyMidd.label = "obf___4920";
         cmdBuyMidd.labelPlacement = "right";
         cmdBuyMidd.selected = false;
         cmdBuyMidd.toggle = false;
         cmdBuyMidd.visible = true;
         try
         {
            cmdBuyMidd["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_7_3885() : *
      {
         try
         {
            cmdBuyHigh["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuyHigh.emphasized = false;
         cmdBuyHigh.enabled = true;
         cmdBuyHigh.label = "obf___4920";
         cmdBuyHigh.labelPlacement = "right";
         cmdBuyHigh.selected = false;
         cmdBuyHigh.toggle = false;
         cmdBuyHigh.visible = true;
         try
         {
            cmdBuyHigh["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

