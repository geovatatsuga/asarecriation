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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5258")]
   public dynamic class AgentItemBoxUIMC extends MovieClip
   {
      
      public var cmdCancelSell:MainButton;
      
      public var cmdTakeBack:MainButton;
      
      public var txtDeyTotleGold:TextField;
      
      public var txtItemName:TextField;
      
      public var singleGoldPoint:MovieClip;
      
      public var txtDeySingleGold:TextField;
      
      public var bagItem:IconBarMC;
      
      public var txtTime:TextField;
      
      public var totleGoldPoint:MovieClip;
      
      public function AgentItemBoxUIMC()
      {
         super();
         obf_A_L_3807();
         obf_p_E_2258();
      }
      
      internal function obf_p_E_2258() : *
      {
         try
         {
            cmdCancelSell["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancelSell.emphasized = false;
         cmdCancelSell.enabled = true;
         cmdCancelSell.label = "obf_____4809";
         cmdCancelSell.labelPlacement = "right";
         cmdCancelSell.selected = false;
         cmdCancelSell.toggle = false;
         cmdCancelSell.visible = true;
         try
         {
            cmdCancelSell["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_L_3807() : *
      {
         try
         {
            cmdTakeBack["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTakeBack.emphasized = false;
         cmdTakeBack.enabled = true;
         cmdTakeBack.label = "obf_____4795";
         cmdTakeBack.labelPlacement = "right";
         cmdTakeBack.selected = false;
         cmdTakeBack.toggle = false;
         cmdTakeBack.visible = true;
         try
         {
            cmdTakeBack["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

