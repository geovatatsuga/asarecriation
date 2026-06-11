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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4313")]
   public dynamic class AllOfPeopleBoonUIMC extends MovieClip
   {
      
      public var rewardPoint:MovieClip;
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var numberTxt:TextField;
      
      public var curBuyTxt:TextField;
      
      public var cmdBuy:MainButton;
      
      public var txtRemark:TextField;
      
      public var InstanceName_1:MovieClip;
      
      public function AllOfPeopleBoonUIMC()
      {
         super();
         obf_0_1_j_286();
         obf_A_O_1113();
      }
      
      internal function obf_A_O_1113() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "InstanceName_1";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_j_286() : *
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
         cmdBuy.label = "obf___4920";
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

