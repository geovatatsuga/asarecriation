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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol397")]
   public dynamic class MainBagUIMC extends MovieClip
   {
      
      public var cmdSplit:MainButton;
      
      public var txtDeyGold:TextField;
      
      public var pointTypeCmd:MovieClip;
      
      public var cmdAlmirah:MainButton;
      
      public var txtDeyMoney:TextField;
      
      public var cmdArtifact:MainButton;
      
      public var cmdAssemble:MainButton;
      
      public var txtDeyCoin:TextField;
      
      public var bgBox:MovieClip;
      
      public var closeButton:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var bagPage1:MovieClip;
      
      public var bagPage2:MovieClip;
      
      public var bagPage3:MovieClip;
      
      public var bagPage4:MovieClip;
      
      public var bagPage5:MovieClip;
      
      public var txtDeyShopTitle:TextField;
      
      public var obf_0_9_3_562:UIScrollBar;
      
      public var bagPage6:MovieClip;
      
      public var bagPage7:MovieClip;
      
      public var cmdRenew:MainButton;
      
      public var coinPoint:MovieClip;
      
      public var cmdStrengthen:MainButton;
      
      public var cmdStall:MainButton;
      
      public var bagPageType:MovieClip;
      
      public var txtSilver:TextField;
      
      public var txtCopper:TextField;
      
      public var pointShop:MovieClip;
      
      public var moneyPoint:MovieClip;
      
      public var cmdBagPage1:TableButton;
      
      public var cmdBagPage2:TableButton;
      
      public var cmdBagPage3:TableButton;
      
      public var cmdBagPage4:TableButton;
      
      public var cmdBagPage6:TableButton;
      
      public var cmdBagPage7:TableButton;
      
      public var cmdEmbed:MainButton;
      
      public var cmdLOT:MainButton;
      
      public var cmdBagPage5:TableButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdSoulWeapon:MainButton;
      
      public var txtDiamond:TextField;
      
      public var cmdDecompose:MainButton;
      
      public var cmdLettering:MainButton;
      
      public var tempBagButtonPrompt:MovieClip;
      
      public var obf_t_O_1071:MovieClip;
      
      public var cmdResult:MainButton;
      
      public var cmdSort:MainButton;
      
      public var cmdTempBag:MainButton;
      
      public var txtGold:TextField;
      
      public function MainBagUIMC()
      {
         super();
         obf_X_E_2338();
         obf_u_B_4165();
         obf_A_B_1980();
         obf_o_L_1935();
         obf_Z_K_3452();
         obf_0_R_3585();
         obf_M_w_4212();
         obf_0_8_J_576();
         obf_c_m_2020();
         obf_Q_2_3328();
         obf_0_5_s_722();
         obf_0_3_q_407();
         obf_X_C_2065();
         obf_0_1_r_523();
         obf_0_3_Y_143();
      }
      
      internal function obf_M_w_4212() : *
      {
         try
         {
            cmdStall["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdStall.emphasized = false;
         cmdStall.enabled = true;
         cmdStall.label = "obf___4911";
         cmdStall.labelPlacement = "right";
         cmdStall.selected = false;
         cmdStall.toggle = false;
         cmdStall.visible = true;
         try
         {
            cmdStall["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_J_576() : *
      {
         try
         {
            cmdRenew["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRenew.emphasized = false;
         cmdRenew.enabled = true;
         cmdRenew.label = "obf___4868";
         cmdRenew.labelPlacement = "right";
         cmdRenew.selected = false;
         cmdRenew.toggle = false;
         cmdRenew.visible = true;
         try
         {
            cmdRenew["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_s_722() : *
      {
         try
         {
            cmdLettering["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLettering.emphasized = false;
         cmdLettering.enabled = true;
         cmdLettering.label = "obf___4958";
         cmdLettering.labelPlacement = "right";
         cmdLettering.selected = false;
         cmdLettering.toggle = false;
         cmdLettering.visible = false;
         try
         {
            cmdLettering["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Z_K_3452() : *
      {
         try
         {
            cmdDecompose["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDecompose.emphasized = false;
         cmdDecompose.enabled = true;
         cmdDecompose.label = "obf___4972";
         cmdDecompose.labelPlacement = "right";
         cmdDecompose.selected = false;
         cmdDecompose.toggle = false;
         cmdDecompose.visible = true;
         try
         {
            cmdDecompose["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_B_4165() : *
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
         cmdResult.label = "obf___4937";
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
      
      internal function obf_o_L_1935() : *
      {
         try
         {
            cmdEmbed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEmbed.emphasized = false;
         cmdEmbed.enabled = true;
         cmdEmbed.label = "obf___4915";
         cmdEmbed.labelPlacement = "right";
         cmdEmbed.selected = false;
         cmdEmbed.toggle = false;
         cmdEmbed.visible = true;
         try
         {
            cmdEmbed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_q_407() : *
      {
         try
         {
            cmdSort["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSort.emphasized = false;
         cmdSort.enabled = true;
         cmdSort.label = "obf___4939";
         cmdSort.labelPlacement = "right";
         cmdSort.selected = false;
         cmdSort.toggle = false;
         cmdSort.visible = true;
         try
         {
            cmdSort["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_c_m_2020() : *
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
      
      internal function obf_0_1_r_523() : *
      {
         try
         {
            cmdLOT["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLOT.emphasized = false;
         cmdLOT.enabled = true;
         cmdLOT.label = "LOT";
         cmdLOT.labelPlacement = "right";
         cmdLOT.selected = false;
         cmdLOT.toggle = false;
         cmdLOT.visible = true;
         try
         {
            cmdLOT["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_E_2338() : *
      {
         try
         {
            cmdSplit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSplit.emphasized = false;
         cmdSplit.enabled = true;
         cmdSplit.label = "obf___4898";
         cmdSplit.labelPlacement = "right";
         cmdSplit.selected = false;
         cmdSplit.toggle = false;
         cmdSplit.visible = true;
         try
         {
            cmdSplit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_Y_143() : *
      {
         try
         {
            cmdAlmirah["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAlmirah.emphasized = false;
         cmdAlmirah.enabled = true;
         cmdAlmirah.label = "obf___4900";
         cmdAlmirah.labelPlacement = "right";
         cmdAlmirah.selected = false;
         cmdAlmirah.toggle = false;
         cmdAlmirah.visible = true;
         try
         {
            cmdAlmirah["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_R_3585() : *
      {
         try
         {
            cmdAssemble["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAssemble.emphasized = false;
         cmdAssemble.enabled = true;
         cmdAssemble.label = "obf___4883";
         cmdAssemble.labelPlacement = "right";
         cmdAssemble.selected = false;
         cmdAssemble.toggle = false;
         cmdAssemble.visible = true;
         try
         {
            cmdAssemble["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_C_2065() : *
      {
         try
         {
            cmdSoulWeapon["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSoulWeapon.emphasized = false;
         cmdSoulWeapon.enabled = true;
         cmdSoulWeapon.label = "obf___4914";
         cmdSoulWeapon.labelPlacement = "right";
         cmdSoulWeapon.selected = false;
         cmdSoulWeapon.toggle = false;
         cmdSoulWeapon.visible = true;
         try
         {
            cmdSoulWeapon["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Q_2_3328() : *
      {
         try
         {
            cmdArtifact["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdArtifact.emphasized = false;
         cmdArtifact.enabled = true;
         cmdArtifact.label = "obf___4929";
         cmdArtifact.labelPlacement = "right";
         cmdArtifact.selected = false;
         cmdArtifact.toggle = false;
         cmdArtifact.visible = true;
         try
         {
            cmdArtifact["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_B_1980() : *
      {
         try
         {
            cmdStrengthen["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdStrengthen.emphasized = false;
         cmdStrengthen.enabled = true;
         cmdStrengthen.label = "obf___4967";
         cmdStrengthen.labelPlacement = "right";
         cmdStrengthen.selected = false;
         cmdStrengthen.toggle = false;
         cmdStrengthen.visible = true;
         try
         {
            cmdStrengthen["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

