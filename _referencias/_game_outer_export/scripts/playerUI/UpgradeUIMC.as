package playerUI
{
   import ControlClass.MJCheckBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2081")]
   public dynamic class UpgradeUIMC extends MovieClip
   {
      
      public var txtExpendable:TextField;
      
      public var txtDaySucceed:TextField;
      
      public var iconBar1:IconBarMC;
      
      public var iconBar2:IconBarMC;
      
      public var iconBar3:IconBarMC;
      
      public var txtLv:TextField;
      
      public var txtName:TextField;
      
      public var iconBar6:IconBarMC;
      
      public var mgPoint:MovieClip;
      
      public var iconBar9:IconBarMC;
      
      public var iconBar4:IconBarMC;
      
      public var iconBar5:IconBarMC;
      
      public var iconBar7:IconBarMC;
      
      public var txtDayAchieve:TextField;
      
      public var moneyCheck:MJCheckBox;
      
      public var iconBar8:IconBarMC;
      
      public var txtSucceed:TextField;
      
      public var obf_T_o_3829:IconBarMC;
      
      public var txtLeavings:TextField;
      
      public var godCheck:MJCheckBox;
      
      public var cmdUp:MainButton;
      
      public var iconBar10:IconBarMC;
      
      public var iconBar11:IconBarMC;
      
      public var iconBar12:IconBarMC;
      
      public function UpgradeUIMC()
      {
         super();
         obf_O_s_2017();
         obf_B_d_2259();
      }
      
      internal function obf_O_s_2017() : *
      {
         try
         {
            godCheck["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         godCheck.enabled = true;
         godCheck.label = "";
         godCheck.labelPlacement = "right";
         godCheck.selected = false;
         godCheck.visible = true;
         try
         {
            godCheck["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_B_d_2259() : *
      {
         try
         {
            moneyCheck["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         moneyCheck.enabled = true;
         moneyCheck.label = "";
         moneyCheck.labelPlacement = "right";
         moneyCheck.selected = false;
         moneyCheck.visible = true;
         try
         {
            moneyCheck["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

