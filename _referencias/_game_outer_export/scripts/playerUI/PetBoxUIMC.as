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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4391")]
   public dynamic class PetBoxUIMC extends MovieClip
   {
      
      public var txtDeyPetEquip:TextField;
      
      public var cx034:MovieClip;
      
      public var txtEnhanceLevel:TextField;
      
      public var cmdAgiAddPoint:SimpleButton;
      
      public var cmdGeneration:MainButton;
      
      public var txtDeyStrength:TextField;
      
      public var txtDeyFateItems:TextField;
      
      public var barStrengthApt:MovieClip;
      
      public var barAgilityApt:MovieClip;
      
      public var bagArmor:IconBarMC;
      
      public var txtMP:TextField;
      
      public var cmdGrowthRate:MainButton;
      
      public var txtWisdomApt:TextField;
      
      public var txtDeyPetSkill:TextField;
      
      public var txtAgilityApt:TextField;
      
      public var txtDeyName:TextField;
      
      public var txtDeyAbsorbRatio:TextField;
      
      public var cmdAgiRemovePoint:SimpleButton;
      
      public var bagWeapon:IconBarMC;
      
      public var txtHitValue:TextField;
      
      public var txtAbsorbRatio:TextField;
      
      public var txtWisdom:TextField;
      
      public var cmdStrRemovePoint:SimpleButton;
      
      public var txtRestraintModulus:TextField;
      
      public var cmdVitRemovePoint:SimpleButton;
      
      public var cmdLevel:MainButton;
      
      public var txtDeyAccessory:TextField;
      
      public var txtDeyRace:TextField;
      
      public var barDefSkill:IconBarMC;
      
      public var txtPhysicalAttack:TextField;
      
      public var txtDeyHP:TextField;
      
      public var txtDeyFateGold:TextField;
      
      public var txtDeyItemType:TextField;
      
      public var txtDeyArmor:TextField;
      
      public var cmdChangeItemType:MainButton;
      
      public var pointSkill:MovieClip;
      
      public var pointFateGold:MovieClip;
      
      public var txtDeyLife:TextField;
      
      public var cmdWisRemovePoint:SimpleButton;
      
      public var cmdSummon:MainButton;
      
      public var txtDeyFateName:TextField;
      
      public var txtFatePetLevel:TextField;
      
      public var obf_j_L_3395:MovieClip;
      
      public var cmdFate:MainButton;
      
      public var cmdWigAddPoint:SimpleButton;
      
      public var cmdSex:MainButton;
      
      public var txtDeyVitality:TextField;
      
      public var cmdPetSort:MainButton;
      
      public var txtStrength:TextField;
      
      public var txtDeyLevel:TextField;
      
      public var cmdPointOK:MainButton;
      
      public var txtDeyPetDefSkill:TextField;
      
      public var cmdName:MainButton;
      
      public var petBag1:MovieClip;
      
      public var petBag2:MovieClip;
      
      public var petBag4:MovieClip;
      
      public var petBag5:MovieClip;
      
      public var txtDeyGrowthRate:TextField;
      
      public var txtDeyType:TextField;
      
      public var txtLevel:TextField;
      
      public var petBag3:MovieClip;
      
      public var txtDeyVitalityApt:TextField;
      
      public var cmdPetUp:MainButton;
      
      public var cmdAgiAddAllPoint:SimpleButton;
      
      public var barExp:MovieClip;
      
      public var txtDeyCritValue:TextField;
      
      public var txtVitalityApt:TextField;
      
      public var txtDeyNotOpen:TextField;
      
      public var cmdVitAddPoint:SimpleButton;
      
      public var cmdStrAddAllPoint:SimpleButton;
      
      public var txtName:TextField;
      
      public var txtPage:TextField;
      
      public var cmdStrAddPoint:SimpleButton;
      
      public var txtCritValue:TextField;
      
      public var cmdVitAddAllPoint:SimpleButton;
      
      public var txtDeyMP:TextField;
      
      public var pointPetImage:MovieClip;
      
      public var bagBlood:IconBarMC;
      
      public var txtDeyHitValue:TextField;
      
      public var bagFateItem0:IconBarMC;
      
      public var bagFateItem2:IconBarMC;
      
      public var bagFateItem3:IconBarMC;
      
      public var txtDeyAgilityApt:TextField;
      
      public var bagFateItem1:IconBarMC;
      
      public var txtDeyBlood:TextField;
      
      public var cmdLife:MainButton;
      
      public var txtRace:TextField;
      
      public var txtDeyWisdom:TextField;
      
      public var txtDeyRestraint:TextField;
      
      public var cmdRelease:MainButton;
      
      public var cmdWisAddAllPoint:SimpleButton;
      
      public var txtDeyRestraintModulus:TextField;
      
      public var txtDeyExp:TextField;
      
      public var txtDeyAttrPoint:TextField;
      
      public var txtHP:TextField;
      
      public var txtDeyStrengthApt:TextField;
      
      public var txtItemType:TextField;
      
      public var txtRestraint:TextField;
      
      public var txtLife:TextField;
      
      public var txtAttrPoint:TextField;
      
      public var barVitalityApt:MovieClip;
      
      public var cx001:MovieClip;
      
      public var txtDeyAgility:TextField;
      
      public var txtDeyLoyalty:TextField;
      
      public var cx004:MovieClip;
      
      public var cx000:MovieClip;
      
      public var txtExp:TextField;
      
      public var txtDeyPhysicalAttack:TextField;
      
      public var txtGeneration:TextField;
      
      public var cmdLoyalty:MainButton;
      
      public var txtDeyMagicAttack:TextField;
      
      public var cmdResetApt:MainButton;
      
      public var obf_v_N_4096:MovieClip;
      
      public var txtAgility:TextField;
      
      public var txtLoyalty:TextField;
      
      public var txtVitality:TextField;
      
      public var cx010:MovieClip;
      
      public var cx011:MovieClip;
      
      public var cx012:MovieClip;
      
      public var cx013:MovieClip;
      
      public var cx014:MovieClip;
      
      public var cx002:MovieClip;
      
      public var cx003:MovieClip;
      
      public var txtStrengthApt:TextField;
      
      public var txtDeyWeapon:TextField;
      
      public var txtDeySex:TextField;
      
      public var selectedBoxIcon:MovieClip;
      
      public var txtType:TextField;
      
      public var txtMagicAttack:TextField;
      
      public var cmdEnhanceLevel:MainButton;
      
      public var barWisdomApt:MovieClip;
      
      public var txtGrowthRate:TextField;
      
      public var cx020:MovieClip;
      
      public var cx021:MovieClip;
      
      public var cx022:MovieClip;
      
      public var cx023:MovieClip;
      
      public var cx024:MovieClip;
      
      public var txtFateName:TextField;
      
      public var txtSex:TextField;
      
      public var cmdPetDown:MainButton;
      
      public var bagAccessory:IconBarMC;
      
      public var txtDeyFatePetLevel:TextField;
      
      public var cx030:MovieClip;
      
      public var cx031:MovieClip;
      
      public var cx032:MovieClip;
      
      public var cx033:MovieClip;
      
      public var txtDeyWisdomApt:TextField;
      
      public function PetBoxUIMC()
      {
         super();
         obf_n_e_4036();
         obf_J_2_1670();
         obf_0___3_568();
         obf_o_h_3799();
         obf_l_A_4618();
         obf_G_7_1482();
         obf_R_H_2221();
         obf_f_3_1336();
         obf_i_E_3036();
         obf_E_h_1018();
         obf_g_i_1555();
         obf_u_f_4295();
         obf_O_M_1669();
         obf_0_3_o_557();
         obf_F_y_3779();
         obf_v_I_4541();
         obf_u_u_4479();
      }
      
      internal function obf_F_y_3779() : *
      {
         try
         {
            cmdSummon["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSummon.emphasized = false;
         cmdSummon.enabled = true;
         cmdSummon.label = "obf___4895";
         cmdSummon.labelPlacement = "right";
         cmdSummon.selected = false;
         cmdSummon.toggle = false;
         cmdSummon.visible = true;
         try
         {
            cmdSummon["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0___3_568() : *
      {
         try
         {
            cmdPetSort["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPetSort.emphasized = false;
         cmdPetSort.enabled = true;
         cmdPetSort.label = "obf___4939";
         cmdPetSort.labelPlacement = "right";
         cmdPetSort.selected = false;
         cmdPetSort.toggle = false;
         cmdPetSort.visible = true;
         try
         {
            cmdPetSort["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_f_4295() : *
      {
         try
         {
            cmdEnhanceLevel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEnhanceLevel.emphasized = false;
         cmdEnhanceLevel.enabled = true;
         cmdEnhanceLevel.label = "obf___4967";
         cmdEnhanceLevel.labelPlacement = "right";
         cmdEnhanceLevel.selected = false;
         cmdEnhanceLevel.toggle = false;
         cmdEnhanceLevel.visible = true;
         try
         {
            cmdEnhanceLevel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_n_e_4036() : *
      {
         try
         {
            cmdPetUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPetUp.emphasized = false;
         cmdPetUp.enabled = true;
         cmdPetUp.label = "obf____4858";
         cmdPetUp.labelPlacement = "right";
         cmdPetUp.selected = false;
         cmdPetUp.toggle = false;
         cmdPetUp.visible = true;
         try
         {
            cmdPetUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_3_1336() : *
      {
         try
         {
            cmdLife["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLife.emphasized = false;
         cmdLife.enabled = true;
         cmdLife.label = "obf___4890";
         cmdLife.labelPlacement = "right";
         cmdLife.selected = false;
         cmdLife.toggle = false;
         cmdLife.visible = true;
         try
         {
            cmdLife["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_H_2221() : *
      {
         try
         {
            cmdLoyalty["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLoyalty.emphasized = false;
         cmdLoyalty.enabled = true;
         cmdLoyalty.label = "obf___4954";
         cmdLoyalty.labelPlacement = "right";
         cmdLoyalty.selected = false;
         cmdLoyalty.toggle = false;
         cmdLoyalty.visible = true;
         try
         {
            cmdLoyalty["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_v_I_4541() : *
      {
         try
         {
            cmdRelease["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRelease.emphasized = false;
         cmdRelease.enabled = true;
         cmdRelease.label = "obf___4977";
         cmdRelease.labelPlacement = "right";
         cmdRelease.selected = false;
         cmdRelease.toggle = false;
         cmdRelease.visible = true;
         try
         {
            cmdRelease["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_o_h_3799() : *
      {
         try
         {
            cmdName["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdName.emphasized = false;
         cmdName.enabled = true;
         cmdName.label = "obf____4857";
         cmdName.labelPlacement = "right";
         cmdName.selected = false;
         cmdName.toggle = false;
         cmdName.visible = true;
         try
         {
            cmdName["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_G_7_1482() : *
      {
         try
         {
            cmdSex["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSex.emphasized = false;
         cmdSex.enabled = true;
         cmdSex.label = "obf___4938";
         cmdSex.labelPlacement = "right";
         cmdSex.selected = false;
         cmdSex.toggle = false;
         cmdSex.visible = true;
         try
         {
            cmdSex["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_l_A_4618() : *
      {
         try
         {
            cmdLevel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLevel.emphasized = false;
         cmdLevel.enabled = true;
         cmdLevel.label = "obf___4923";
         cmdLevel.labelPlacement = "right";
         cmdLevel.selected = false;
         cmdLevel.toggle = false;
         cmdLevel.visible = true;
         try
         {
            cmdLevel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_u_4479() : *
      {
         try
         {
            cmdFate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFate.emphasized = false;
         cmdFate.enabled = true;
         cmdFate.label = "FateOK";
         cmdFate.labelPlacement = "right";
         cmdFate.selected = false;
         cmdFate.toggle = false;
         cmdFate.visible = true;
         try
         {
            cmdFate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_J_2_1670() : *
      {
         try
         {
            cmdPetDown["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPetDown.emphasized = false;
         cmdPetDown.enabled = true;
         cmdPetDown.label = "obf____4854";
         cmdPetDown.labelPlacement = "right";
         cmdPetDown.selected = false;
         cmdPetDown.toggle = false;
         cmdPetDown.visible = true;
         try
         {
            cmdPetDown["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_i_E_3036() : *
      {
         try
         {
            cmdGrowthRate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGrowthRate.emphasized = false;
         cmdGrowthRate.enabled = true;
         cmdGrowthRate.label = "obf___4960";
         cmdGrowthRate.labelPlacement = "right";
         cmdGrowthRate.selected = false;
         cmdGrowthRate.toggle = false;
         cmdGrowthRate.visible = true;
         try
         {
            cmdGrowthRate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_o_557() : *
      {
         try
         {
            cmdResetApt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdResetApt.emphasized = false;
         cmdResetApt.enabled = true;
         cmdResetApt.label = "obf___4918";
         cmdResetApt.labelPlacement = "right";
         cmdResetApt.selected = false;
         cmdResetApt.toggle = false;
         cmdResetApt.visible = true;
         try
         {
            cmdResetApt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_O_M_1669() : *
      {
         try
         {
            cmdPointOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPointOK.emphasized = false;
         cmdPointOK.enabled = true;
         cmdPointOK.label = "obf___4891";
         cmdPointOK.labelPlacement = "right";
         cmdPointOK.selected = false;
         cmdPointOK.toggle = false;
         cmdPointOK.visible = true;
         try
         {
            cmdPointOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_h_1018() : *
      {
         try
         {
            cmdChangeItemType["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdChangeItemType.emphasized = false;
         cmdChangeItemType.enabled = true;
         cmdChangeItemType.label = "obf___4943";
         cmdChangeItemType.labelPlacement = "right";
         cmdChangeItemType.selected = false;
         cmdChangeItemType.toggle = false;
         cmdChangeItemType.visible = true;
         try
         {
            cmdChangeItemType["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_g_i_1555() : *
      {
         try
         {
            cmdGeneration["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGeneration.emphasized = false;
         cmdGeneration.enabled = true;
         cmdGeneration.label = "obf___4975";
         cmdGeneration.labelPlacement = "right";
         cmdGeneration.selected = false;
         cmdGeneration.toggle = false;
         cmdGeneration.visible = true;
         try
         {
            cmdGeneration["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

