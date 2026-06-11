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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4184")]
   public dynamic class PlayerDevilBoxUIMC extends MovieClip
   {
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyGenieUnseal:TextField;
      
      public var txtResultMagicDef:TextField;
      
      public var txtGenieLevel:TextField;
      
      public var cmdGenieUnseal:MainButton;
      
      public var txtGenieUnseal:TextField;
      
      public var txtDeyCureApt:TextField;
      
      public var txtMagicAttackApt:TextField;
      
      public var txtDeyUpgradeSelfApt:TextField;
      
      public var cmdCureApt:SimpleButton;
      
      public var txtDeyGenieLevel:TextField;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var txtDeyUpgradeMagicAttackApt:TextField;
      
      public var txtLevelCureApt:TextField;
      
      public var bag5:IconBarMC;
      
      public var bag6:IconBarMC;
      
      public var pointUpgradeView:MovieClip;
      
      public var bag3:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var bag7:IconBarMC;
      
      public var txtCureApt:TextField;
      
      public var txtDeyMagicAttackApt:TextField;
      
      public var txtUpgradeMagicAttackApt:TextField;
      
      public var txtDeyUnsealGold:TextField;
      
      public var cmdBack:MainButton;
      
      public var barGenieExp:MovieClip;
      
      public var txtDeyMagicDefApt:TextField;
      
      public var txtResultLife:TextField;
      
      public var txtLevelPhysicsAttackApt:TextField;
      
      public var pointUnsealGold:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var txtDeyResultMagicAttack:TextField;
      
      public var txtLevelMagicDefApt:TextField;
      
      public var txtDeyLevelUpSp:TextField;
      
      public var txtMagicDefApt:TextField;
      
      public var txtDeyResultLife:TextField;
      
      public var txtDeyPhysicsDefApt:TextField;
      
      public var txtResultMagicAttack:TextField;
      
      public var cmdMagicAttackApt:SimpleButton;
      
      public var cmdMagicDefApt:SimpleButton;
      
      public var txtLevelUpSp:TextField;
      
      public var txtDeyGenieName:TextField;
      
      public var txtLevelPhysicsDefApt:TextField;
      
      public var txtUpgradeLifeApt:TextField;
      
      public var txtResultCure:TextField;
      
      public var txtPhysicsDefApt:TextField;
      
      public var pointGenieView:MovieClip;
      
      public var txtGenieName:TextField;
      
      public var barGenieUnseal:MovieClip;
      
      public var cmdPhysicsAttackApt:SimpleButton;
      
      public var txtDeySelfApt:TextField;
      
      public var txtUpgradeCureApt:TextField;
      
      public var txtDeyUpgradeLifeApt:TextField;
      
      public var txtDeyResultCure:TextField;
      
      public var cmdGenieLevelUp:MainButton;
      
      public var txtGenieExp:TextField;
      
      public var txtUnsealSp:TextField;
      
      public var txtLevelMagicAttackApt:TextField;
      
      public var txtDeyLevelApt:TextField;
      
      public var txtDeyResultPhysicsAttack:TextField;
      
      public var bgBox2:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyUpgradeCureApt:TextField;
      
      public var txtDeyGenieUpgrade:TextField;
      
      public var txtDeyGenieExp:TextField;
      
      public var txtDeyUnsealSp:TextField;
      
      public var txtUpgradeMagicDefApt:TextField;
      
      public var txtDeyResult:TextField;
      
      public var txtPhysicsAttackApt:TextField;
      
      public var bagUnseal0:IconBarMC;
      
      public var txtResultPhysicsDef:TextField;
      
      public var txtResultPhysicsAttack:TextField;
      
      public var bagUnseal1:IconBarMC;
      
      public var txtDeyUpgradeMagicDefApt:TextField;
      
      public var selectGenieBox:MovieClip;
      
      public var txtDeyLifeApt:TextField;
      
      public var txtUpgradePhysicsDefApt:TextField;
      
      public var txtDeyUnsealRemark:TextField;
      
      public var txtDeyUpgradePhysicsAttackApt:TextField;
      
      public var txtDeyPhysicsAttackApt:TextField;
      
      public var cmdLifeApt:SimpleButton;
      
      public var txtUpgradePhysicsAttackApt:TextField;
      
      public var txtDeyUpgradePhysicsDefApt:TextField;
      
      public var cmdPhysicsDefApt:SimpleButton;
      
      public var txtLevelLifeApt:TextField;
      
      public var txtLifeApt:TextField;
      
      public var txtDeyResultPhysicsDef:TextField;
      
      public var cmdUse:MainButton;
      
      public var txtDeyResultMagicDef:TextField;
      
      public function PlayerDevilBoxUIMC()
      {
         super();
         obf_0_9_7_713();
         obf_s_F_2539();
         obf_o_t_2467();
         obf_e_W_4118();
      }
      
      internal function obf_o_t_2467() : *
      {
         try
         {
            cmdGenieLevelUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGenieLevelUp.emphasized = false;
         cmdGenieLevelUp.enabled = true;
         cmdGenieLevelUp.label = "obf_____4774";
         cmdGenieLevelUp.labelPlacement = "right";
         cmdGenieLevelUp.selected = false;
         cmdGenieLevelUp.toggle = false;
         cmdGenieLevelUp.visible = true;
         try
         {
            cmdGenieLevelUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_9_7_713() : *
      {
         try
         {
            cmdUse["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUse.emphasized = false;
         cmdUse.enabled = true;
         cmdUse.label = "obf___4877";
         cmdUse.labelPlacement = "right";
         cmdUse.selected = false;
         cmdUse.toggle = false;
         cmdUse.visible = true;
         try
         {
            cmdUse["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_e_W_4118() : *
      {
         try
         {
            cmdGenieUnseal["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGenieUnseal.emphasized = false;
         cmdGenieUnseal.enabled = true;
         cmdGenieUnseal.label = "obf___4887";
         cmdGenieUnseal.labelPlacement = "right";
         cmdGenieUnseal.selected = false;
         cmdGenieUnseal.toggle = false;
         cmdGenieUnseal.visible = true;
         try
         {
            cmdGenieUnseal["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_F_2539() : *
      {
         try
         {
            cmdBack["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBack.emphasized = false;
         cmdBack.enabled = true;
         cmdBack.label = "obf___4897";
         cmdBack.labelPlacement = "right";
         cmdBack.selected = false;
         cmdBack.toggle = false;
         cmdBack.visible = true;
         try
         {
            cmdBack["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

