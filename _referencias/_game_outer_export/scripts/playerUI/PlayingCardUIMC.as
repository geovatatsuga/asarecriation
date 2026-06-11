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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4409")]
   public dynamic class PlayingCardUIMC extends MovieClip
   {
      
      public var pointCard1:MovieClip;
      
      public var cmdCardRule:MainButton;
      
      public var txtRewards:TextField;
      
      public var rewardScrollBar:UIScrollBar;
      
      public var bag0:cardIconBar;
      
      public var bag1:cardIconBar;
      
      public var bag2:cardIconBar;
      
      public var bag3:cardIconBar;
      
      public var bag4:cardIconBar;
      
      public var bag5:cardIconBar;
      
      public var bag6:cardIconBar;
      
      public var bag7:cardIconBar;
      
      public var bag8:cardIconBar;
      
      public var cmdReset:MainButton;
      
      public var resetNum:TextField;
      
      public var txtReset:TextField;
      
      public var bgBox:MovieClip;
      
      public var obf_O_Z_2554:TextField;
      
      public var cmdStart:MainButton;
      
      public var cmdReceive:MainButton;
      
      public var txtLeavings:TextField;
      
      public var cmdRule:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var pointCard2:MovieClip;
      
      public var pointCard3:MovieClip;
      
      public var pointCard4:MovieClip;
      
      public var pointCard5:MovieClip;
      
      public var pointCard6:MovieClip;
      
      public var pointCard7:MovieClip;
      
      public var pointCard8:MovieClip;
      
      public var cmdBuy:MainButton;
      
      public var pointCard0:MovieClip;
      
      public function PlayingCardUIMC()
      {
         super();
         obf_0_9_W_710();
         obf_c_F_3509();
         obf_b_l_1708();
         obf_Z_V_2305();
         obf_S_P_4197();
         obf_H_C_3709();
         obf_D_w_1019();
      }
      
      internal function obf_Z_V_2305() : *
      {
         try
         {
            cmdReceive["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReceive.emphasized = false;
         cmdReceive.enabled = true;
         cmdReceive.label = "obf_____4728";
         cmdReceive.labelPlacement = "right";
         cmdReceive.selected = false;
         cmdReceive.toggle = false;
         cmdReceive.visible = true;
         try
         {
            cmdReceive["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_w_1019() : *
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
      
      internal function obf_c_F_3509() : *
      {
         try
         {
            cmdRule["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRule.emphasized = false;
         cmdRule.enabled = true;
         cmdRule.label = "obf_____4750";
         cmdRule.labelPlacement = "right";
         cmdRule.selected = false;
         cmdRule.toggle = false;
         cmdRule.visible = true;
         try
         {
            cmdRule["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_S_P_4197() : *
      {
         try
         {
            cmdStart["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdStart.emphasized = false;
         cmdStart.enabled = true;
         cmdStart.label = "obf___4934";
         cmdStart.labelPlacement = "right";
         cmdStart.selected = false;
         cmdStart.toggle = false;
         cmdStart.visible = true;
         try
         {
            cmdStart["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_9_W_710() : *
      {
         try
         {
            rewardScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         rewardScrollBar.direction = "vertical";
         rewardScrollBar.scrollTargetName = "txtRewards";
         rewardScrollBar.visible = true;
         try
         {
            rewardScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_C_3709() : *
      {
         try
         {
            cmdCardRule["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCardRule.emphasized = false;
         cmdCardRule.enabled = true;
         cmdCardRule.label = "obf_____4745";
         cmdCardRule.labelPlacement = "right";
         cmdCardRule.selected = false;
         cmdCardRule.toggle = false;
         cmdCardRule.visible = true;
         try
         {
            cmdCardRule["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_l_1708() : *
      {
         try
         {
            cmdReset["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReset.emphasized = false;
         cmdReset.enabled = true;
         cmdReset.label = "obf_____4714";
         cmdReset.labelPlacement = "right";
         cmdReset.selected = false;
         cmdReset.toggle = false;
         cmdReset.visible = true;
         try
         {
            cmdReset["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

