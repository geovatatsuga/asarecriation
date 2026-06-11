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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3856")]
   public dynamic class DrgTreasureUIMC extends MovieClip
   {
      
      public var promptMC:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdTableDrg0:TableButton;
      
      public var cmdTableDrg1:TableButton;
      
      public var cmdTableDrg2:TableButton;
      
      public var pointMoney:MovieClip;
      
      public var InstanceName_0:MovieClip;
      
      public var goldenDrgBG:MovieClip;
      
      public var cmdDrgHit0:SimpleButton;
      
      public var cmdDrgHit1:SimpleButton;
      
      public var cmdDrgHit2:SimpleButton;
      
      public var bag10:IconBarMC;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var bag5:IconBarMC;
      
      public var bag17:IconBarMC;
      
      public var bag12:IconBarMC;
      
      public var obf_z_f_2307:UIScrollBar;
      
      public var bag14:IconBarMC;
      
      public var bag15:IconBarMC;
      
      public var bag16:IconBarMC;
      
      public var bag6:IconBarMC;
      
      public var bag11:IconBarMC;
      
      public var pointDrgMoney1:MovieClip;
      
      public var pointDrgMoney2:MovieClip;
      
      public var bag7:IconBarMC;
      
      public var obf_5_f_1277:UIScrollBar;
      
      public var pointDrgMoney0:MovieClip;
      
      public var bag13:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var bag9:IconBarMC;
      
      public var txtDeyMyMoney:TextField;
      
      public var txtDrgPrompt:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDrgAward:TextField;
      
      public var bag8:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var obf_Y_9_2504:MovieClip;
      
      public var txtOtherDrgAward:TextField;
      
      public var obf_5_s_1586:MovieClip;
      
      public var tempBagButtonPrompt:MovieClip;
      
      public var txtDeyDrgAward:TextField;
      
      public var cmdResult:MainButton;
      
      public var txtDeyOtherDrgAward:TextField;
      
      public var cmdTempBag:MainButton;
      
      public function DrgTreasureUIMC()
      {
         super();
         obf_u_o_4513();
         obf_m_j_4543();
         obf_z_5_3264();
         obf_O_z_1882();
      }
      
      internal function obf_m_j_4543() : *
      {
         try
         {
            obf_5_f_1277["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_5_f_1277.direction = "vertical";
         obf_5_f_1277.scrollTargetName = "txtOtherDrgAward";
         obf_5_f_1277.visible = true;
         try
         {
            obf_5_f_1277["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_z_5_3264() : *
      {
         try
         {
            obf_z_f_2307["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_z_f_2307.direction = "vertical";
         obf_z_f_2307.scrollTargetName = "txtDrgAward";
         obf_z_f_2307.visible = true;
         try
         {
            obf_z_f_2307["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_o_4513() : *
      {
         try
         {
            cmdResult["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdResult.emphasized = false;
         cmdResult.enabled = true;
         cmdResult.label = "obf___4893";
         cmdResult.labelPlacement = "right";
         cmdResult.selected = false;
         cmdResult.toggle = false;
         cmdResult.visible = true;
         try
         {
            cmdResult["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_O_z_1882() : *
      {
         try
         {
            cmdTempBag["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTempBag.emphasized = false;
         cmdTempBag.enabled = true;
         cmdTempBag.label = "obf_____4722";
         cmdTempBag.labelPlacement = "right";
         cmdTempBag.selected = false;
         cmdTempBag.toggle = false;
         cmdTempBag.visible = true;
         try
         {
            cmdTempBag["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

