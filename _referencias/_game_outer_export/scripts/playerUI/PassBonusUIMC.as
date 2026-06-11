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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3554")]
   public dynamic class PassBonusUIMC extends MovieClip
   {
      
      public var txtDeyClearBonus:TextField;
      
      public var txtBestPlayer:TextField;
      
      public var bg:MovieClip;
      
      public var txtBonus:TextField;
      
      public var chkAutoBuy:MJCheckBox;
      
      public var titleBox:MovieClip;
      
      public var txtTime:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtBestTime:TextField;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var bag5:IconBarMC;
      
      public var pointBonus:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var bag2:IconBarMC;
      
      public var cmdCloseUI:MainButton;
      
      public var txtDeyName:TextField;
      
      public var txtDeyTime:TextField;
      
      public var txtDeyOne:TextField;
      
      public function PassBonusUIMC()
      {
         super();
         obf_B_u_3619();
         obf_B_s_3223();
      }
      
      internal function obf_B_s_3223() : *
      {
         try
         {
            cmdCloseUI["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCloseUI.emphasized = false;
         cmdCloseUI.enabled = true;
         cmdCloseUI.label = "obf___4879";
         cmdCloseUI.labelPlacement = "right";
         cmdCloseUI.selected = false;
         cmdCloseUI.toggle = false;
         cmdCloseUI.visible = true;
         try
         {
            cmdCloseUI["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_B_u_3619() : *
      {
         try
         {
            chkAutoBuy["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoBuy.enabled = true;
         chkAutoBuy.label = "obf_____4758";
         chkAutoBuy.labelPlacement = "right";
         chkAutoBuy.selected = false;
         chkAutoBuy.visible = true;
         try
         {
            chkAutoBuy["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

