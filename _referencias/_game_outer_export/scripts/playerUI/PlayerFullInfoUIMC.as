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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1651")]
   public dynamic class PlayerFullInfoUIMC extends MovieClip
   {
      
      public var txtState:TextField;
      
      public var txtDeySp:TextField;
      
      public var txtDeyStrength:TextField;
      
      public var bagSoul:IconBarMC;
      
      public var txtDeyMaxLevel:TextField;
      
      public var txtMp:TextField;
      
      public var txtDeyAttackSpeed:TextField;
      
      public var bagWing:IconBarMC;
      
      public var txtPierceAttack:TextField;
      
      public var txtLuck:TextField;
      
      public var cmdAgiRemovePoint:SimpleButton;
      
      public var bagWeapon:IconBarMC;
      
      public var txtAttackSpeed:TextField;
      
      public var txtDeySingSpeed:TextField;
      
      public var cmdStrRemovePoint:SimpleButton;
      
      public var bagRing:IconBarMC;
      
      public var cmdPlayerTitle:MainButton;
      
      public var txtDeyCritDefense:TextField;
      
      public var txtDeyArena:TextField;
      
      public var txtMagicDefense:TextField;
      
      public var txtDeyEquipMedal:TextField;
      
      public var txtCrit:TextField;
      
      public var txtPK:TextField;
      
      public var cmdVitRemovePoint:SimpleButton;
      
      public var txtSingSpeed:TextField;
      
      public var txtCharmValue:TextField;
      
      public var txtCritDefense:TextField;
      
      public var txtArena:TextField;
      
      public var obf_3_817:MovieClip;
      
      public var txtGild:TextField;
      
      public var txtPhysicalAttack:TextField;
      
      public var txtCritDamage:TextField;
      
      public var txtDeyCharmInt:TextField;
      
      public var cmdEquKindGrow:MainButton;
      
      public var txtDeyAccuracy:TextField;
      
      public var txtDeyEquipShoes:TextField;
      
      public var txtDeyFateSkill:TextField;
      
      public var txtDeyLOA:TextField;
      
      public var txtDeyLuckDefense:TextField;
      
      public var bagCloak:IconBarMC;
      
      public var txtDeyLOT:TextField;
      
      public var cmdWisRemovePoint:SimpleButton;
      
      public var txtLOA:TextField;
      
      public var txtLOH:TextField;
      
      public var expBar:MovieClip;
      
      public var txtDeyHp:TextField;
      
      public var txtDeyEquipRide:TextField;
      
      public var txtMpHeal:TextField;
      
      public var txtDeyHpHeal:TextField;
      
      public var txtLOT:TextField;
      
      public var txtRank:TextField;
      
      public var txtCure:TextField;
      
      public var txtDeyPhysicalDefense:TextField;
      
      public var cmdWigAddPoint:SimpleButton;
      
      public var txtArenaPlace:TextField;
      
      public var txtStrength:TextField;
      
      public var txtPrestige:TextField;
      
      public var obf_N_L_4045:MovieClip;
      
      public var txtDeyIntellect:TextField;
      
      public var txtPhysicalDefense:TextField;
      
      public var txtDeyLevel:TextField;
      
      public var cmdPointOK:MainButton;
      
      public var cmdHonorPrompt:MainButton;
      
      public var txtSp:TextField;
      
      public var txtIntellect:TextField;
      
      public var txtLevel:TextField;
      
      public var txtDeyEquipBanner:TextField;
      
      public var txtLuckDefense:TextField;
      
      public var txtDeyLOH:TextField;
      
      public var cmdAgiAddAllPoint:SimpleButton;
      
      public var txtMaxLevel:TextField;
      
      public var txtDeyEquipShield:TextField;
      
      public var txtDeyJob:TextField;
      
      public var cmdVitAddPoint:SimpleButton;
      
      public var txtDeyEquipFashionClothes:TextField;
      
      public var cmdStrAddAllPoint:SimpleButton;
      
      public var bagClothes:IconBarMC;
      
      public var cmdArenaPlace:MainButton;
      
      public var cmdStrAddPoint:SimpleButton;
      
      public var bagRide:IconBarMC;
      
      public var txtCharmInt:TextField;
      
      public var cmdVitAddAllPoint:SimpleButton;
      
      public var cmdFateSkill:SimpleButton;
      
      public var txtJob:TextField;
      
      public var txtDeyDodge:TextField;
      
      public var bagGlove:IconBarMC;
      
      public var txtDeyPierceDefense:TextField;
      
      public var cmdPointAuto:MainButton;
      
      public var txtDodge:TextField;
      
      public var txtPierceDefense:TextField;
      
      public var txtDeyMp:TextField;
      
      public var bagBanner:IconBarMC;
      
      public var txtDeyWalkSpeed:TextField;
      
      public var txtDeyLuck:TextField;
      
      public var txtDeyPlayerTitle:TextField;
      
      public var txtDeyPierceAttack:TextField;
      
      public var txtDeyEquipAmulet:TextField;
      
      public var txtPlayerTitle:TextField;
      
      public var cmdSuccess:MainButton;
      
      public var txtDeyEquipFashionHat:TextField;
      
      public var txtDeyEquipCloak:TextField;
      
      public var bagHat:IconBarMC;
      
      public var txtDeyExp:TextField;
      
      public var txtDeyAttrPoint:TextField;
      
      public var txtDeyMagicDefense:TextField;
      
      public var chkShowFashion:MJCheckBox;
      
      public var txtWalkSpeed:TextField;
      
      public var cmdWisAddAllPoint:SimpleButton;
      
      public var txtDeyGild:TextField;
      
      public var txtDeyPK:TextField;
      
      public var txtExp:TextField;
      
      public var txtAttrPoint:TextField;
      
      public var txtAccuracy:TextField;
      
      public var txtDeyCritDamage:TextField;
      
      public var txtHp:TextField;
      
      public var txtDeyEquipSoul:TextField;
      
      public var txtDeyAgility:TextField;
      
      public var bagFashionClothes:IconBarMC;
      
      public var txtDeyEquipClothes:TextField;
      
      public var txtDeyPhysicalAttack:TextField;
      
      public var bagShield:IconBarMC;
      
      public var txtDeyMagicAttack:TextField;
      
      public var txtDeyEquipGlove:TextField;
      
      public var txtDeyEquipWing:TextField;
      
      public var txtAgility:TextField;
      
      public var bagShoes:IconBarMC;
      
      public var txtHpHeal:TextField;
      
      public var txtDeyEquipWeapon:TextField;
      
      public var txtMagicAttack:TextField;
      
      public var txtDeyStamina:TextField;
      
      public var txtDeyCharmValue:TextField;
      
      public var txtDeyCure:TextField;
      
      public var bagMedal:IconBarMC;
      
      public var txtDeyMpHeal:TextField;
      
      public var txtDeyRank:TextField;
      
      public var txtDeyEquipRing:TextField;
      
      public var bagAmulet:IconBarMC;
      
      public var txtStamina:TextField;
      
      public var txtDeyCrit:TextField;
      
      public var txtDeyArenaPlace:TextField;
      
      public var txtDeyState:TextField;
      
      public var bagFashionHat:IconBarMC;
      
      public var txtDeyPrestige:TextField;
      
      public var txtDeyEquipHat:TextField;
      
      public var cmdAgiAddPoint:SimpleButton;
      
      public function PlayerFullInfoUIMC()
      {
         super();
         obf_0_3_v_378();
         obf_m_n_913();
         obf_D_5_3815();
         obf_v_V_3149();
         obf_0_6_2_410();
         obf_l_h_3826();
         obf_3_K_4364();
      }
      
      internal function obf_m_n_913() : *
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
      
      internal function obf_D_5_3815() : *
      {
         try
         {
            cmdPointAuto["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPointAuto.emphasized = false;
         cmdPointAuto.enabled = true;
         cmdPointAuto.label = "obf___4948";
         cmdPointAuto.labelPlacement = "right";
         cmdPointAuto.selected = false;
         cmdPointAuto.toggle = false;
         cmdPointAuto.visible = true;
         try
         {
            cmdPointAuto["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_v_V_3149() : *
      {
         try
         {
            cmdHonorPrompt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdHonorPrompt.emphasized = false;
         cmdHonorPrompt.enabled = true;
         cmdHonorPrompt.label = "obf_____4743";
         cmdHonorPrompt.labelPlacement = "right";
         cmdHonorPrompt.selected = false;
         cmdHonorPrompt.toggle = false;
         cmdHonorPrompt.visible = true;
         try
         {
            cmdHonorPrompt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_3_K_4364() : *
      {
         try
         {
            cmdArenaPlace["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdArenaPlace.emphasized = false;
         cmdArenaPlace.enabled = true;
         cmdArenaPlace.label = "obf_____4773";
         cmdArenaPlace.labelPlacement = "right";
         cmdArenaPlace.selected = false;
         cmdArenaPlace.toggle = false;
         cmdArenaPlace.visible = true;
         try
         {
            cmdArenaPlace["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_6_2_410() : *
      {
         try
         {
            cmdPlayerTitle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPlayerTitle.emphasized = false;
         cmdPlayerTitle.enabled = true;
         cmdPlayerTitle.label = "obf_____4817";
         cmdPlayerTitle.labelPlacement = "right";
         cmdPlayerTitle.selected = false;
         cmdPlayerTitle.toggle = false;
         cmdPlayerTitle.visible = true;
         try
         {
            cmdPlayerTitle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_v_378() : *
      {
         try
         {
            chkShowFashion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkShowFashion.enabled = true;
         chkShowFashion.label = "obf_____4846";
         chkShowFashion.labelPlacement = "right";
         chkShowFashion.selected = false;
         chkShowFashion.visible = true;
         try
         {
            chkShowFashion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_l_h_3826() : *
      {
         try
         {
            cmdSuccess["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSuccess.emphasized = false;
         cmdSuccess.enabled = true;
         cmdSuccess.label = "obf___4889";
         cmdSuccess.labelPlacement = "right";
         cmdSuccess.selected = false;
         cmdSuccess.toggle = false;
         cmdSuccess.visible = true;
         try
         {
            cmdSuccess["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

