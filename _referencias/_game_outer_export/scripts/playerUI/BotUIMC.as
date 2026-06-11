package playerUI
{
   import ControlClass.MJCheckBox;
   import ControlClass.MJInput;
   import adobe.utils.*;
   import fl.controls.ComboBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4542")]
   public dynamic class BotUIMC extends MovieClip
   {
      
      public var bagPetHpPercent1:IconBarMC;
      
      public var bagPetHpPercent2:IconBarMC;
      
      public var chkHpPercent:MJCheckBox;
      
      public var txtDeyPetMpPercentUse:TextField;
      
      public var bagTimeUse0:IconBarMC;
      
      public var bagTimeUse1:IconBarMC;
      
      public var bagTimeUse2:IconBarMC;
      
      public var bagTimeUse3:IconBarMC;
      
      public var chkMpPercent:MJCheckBox;
      
      public var bagSkill0:IconBarMC;
      
      public var bagSkill1:IconBarMC;
      
      public var bagSkill2:IconBarMC;
      
      public var bagSkill3:IconBarMC;
      
      public var bagSkill4:IconBarMC;
      
      public var cmdAddBotTime:MainButton;
      
      public var bagSkill5:IconBarMC;
      
      public var txtDeyAntoAnimal:TextField;
      
      public var txtDeyPetHpPercentUse:TextField;
      
      public var txtDeyPickUp:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdRefreshMonster:MainButton;
      
      public var chkPickUpOther:MJCheckBox;
      
      public var listOtherRank:ComboBox;
      
      public var titleBox:MovieClip;
      
      public var chkPickUpAll:MJCheckBox;
      
      public var chkPickUpEquip:MJCheckBox;
      
      public var inputHpPercent:MJInput;
      
      public var bagMpPercent1:IconBarMC;
      
      public var bagMpPercent2:IconBarMC;
      
      public var listEquipRank:ComboBox;
      
      public var inputMpPercent:MJInput;
      
      public var chkPetHpPercent:MJCheckBox;
      
      public var chkAutoPerfectRepair:MJCheckBox;
      
      public var txtDeyMapMonster:TextField;
      
      public var chkPetMpPercent:MJCheckBox;
      
      public var chkAutoAddPetExp:MJCheckBox;
      
      public var scrollMonsterList:UIScrollBar;
      
      public var txtDeyBotRadius:TextField;
      
      public var txtDeyTimeLeft1:TextField;
      
      public var txtDeyTimeLeft2:TextField;
      
      public var txtDeyTimeUse0:TextField;
      
      public var txtDeyTimeUse1:TextField;
      
      public var txtDeyTimeUse2:TextField;
      
      public var txtDeyTimeUse3:TextField;
      
      public var txtDeyPrompt1:TextField;
      
      public var bagPetMpPercent1:IconBarMC;
      
      public var bagPetMpPercent2:IconBarMC;
      
      public var chkAutoAddBotTime:MJCheckBox;
      
      public var txtDeySkill:TextField;
      
      public var txtTimeLeft1:TextField;
      
      public var txtTimeLeft2:TextField;
      
      public var inputPetHpPercent:MJInput;
      
      public var txtBotRadius:TextField;
      
      public var txtDeyMpPercentUse:TextField;
      
      public var txtDeyPrompt2:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtUseItemPrompt:TextField;
      
      public var cmdBotAction:MainButton;
      
      public var inputPetMpPercent:MJInput;
      
      public var txtDeyTimeUse:TextField;
      
      public var txtDeyHpPercentUse:TextField;
      
      public var bagHpPercent1:IconBarMC;
      
      public var bagHpPercent2:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var inputTimeUse1:MJInput;
      
      public var inputTimeUse2:MJInput;
      
      public var inputTimeUse3:MJInput;
      
      public var inputTimeUse0:MJInput;
      
      public var pointMonsterList:MovieClip;
      
      public var scrollBotRadius:UIScrollBar;
      
      public var chkAutoRepairEquip:MJCheckBox;
      
      public var chkAutoAddPlayerExp:MJCheckBox;
      
      public var listCallAnimalSkill:ComboBox;
      
      public function BotUIMC()
      {
         super();
         obf_w_C_4354();
         obf_3_s_4229();
         obf_0_4_i_93();
         obf_R_b_1575();
         obf_h_2_1764();
         obf_N_0_2681();
         obf_8_j_2918();
         obf_A_4694();
         obf_u_w_3188();
         obf_u_6_2513();
         obf_h_7_2211();
         obf_p_8_2796();
         obf_m_q_3868();
         obf_1_2_4304();
         obf_c_v_2399();
         obf_0_3_9_228();
         obf_s_u_2650();
         obf_A_G_1875();
         obf_t_J_2465();
         obf_v_R_1660();
         obf_u_a_4053();
         obf_0_7_X_316();
         obf_7_4_2518();
         obf_H_V_2842();
      }
      
      internal function obf_8_j_2918() : *
      {
         try
         {
            inputPetHpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputPetHpPercent.displayAsPassword = false;
         inputPetHpPercent.editable = true;
         inputPetHpPercent.enabled = true;
         inputPetHpPercent.maxChars = 2;
         inputPetHpPercent.restrict = "0123456789";
         inputPetHpPercent.text = "";
         inputPetHpPercent.visible = true;
         try
         {
            inputPetHpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_q_3868() : *
      {
         try
         {
            chkPickUpEquip["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkPickUpEquip.enabled = true;
         chkPickUpEquip.label = "obf___4978";
         chkPickUpEquip.labelPlacement = "right";
         chkPickUpEquip.selected = false;
         chkPickUpEquip.visible = true;
         try
         {
            chkPickUpEquip["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_1_2_4304() : *
      {
         try
         {
            cmdAddBotTime["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAddBotTime.emphasized = false;
         cmdAddBotTime.enabled = true;
         cmdAddBotTime.label = "obf____4849";
         cmdAddBotTime.labelPlacement = "right";
         cmdAddBotTime.selected = false;
         cmdAddBotTime.toggle = false;
         cmdAddBotTime.visible = true;
         try
         {
            cmdAddBotTime["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_u_2650() : *
      {
         try
         {
            inputTimeUse3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTimeUse3.displayAsPassword = false;
         inputTimeUse3.editable = true;
         inputTimeUse3.enabled = true;
         inputTimeUse3.maxChars = 3;
         inputTimeUse3.restrict = "0-9";
         inputTimeUse3.text = "";
         inputTimeUse3.visible = true;
         try
         {
            inputTimeUse3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_i_93() : *
      {
         try
         {
            inputHpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputHpPercent.displayAsPassword = false;
         inputHpPercent.editable = true;
         inputHpPercent.enabled = true;
         inputHpPercent.maxChars = 2;
         inputHpPercent.restrict = "0123456789";
         inputHpPercent.text = "";
         inputHpPercent.visible = true;
         try
         {
            inputHpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_w_C_4354() : *
      {
         try
         {
            scrollBotRadius["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollBotRadius.direction = "vertical";
         scrollBotRadius.scrollTargetName = "InstanceName_0";
         scrollBotRadius.visible = true;
         try
         {
            scrollBotRadius["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_4694() : *
      {
         try
         {
            chkPetHpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkPetHpPercent.enabled = true;
         chkPetHpPercent.label = "obf_____4720";
         chkPetHpPercent.labelPlacement = "right";
         chkPetHpPercent.selected = true;
         chkPetHpPercent.visible = true;
         try
         {
            chkPetHpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_h_7_2211() : *
      {
         try
         {
            chkPickUpAll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkPickUpAll.enabled = true;
         chkPickUpAll.label = "obf_____4847";
         chkPickUpAll.labelPlacement = "right";
         chkPickUpAll.selected = false;
         chkPickUpAll.visible = true;
         try
         {
            chkPickUpAll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_3_s_4229() : *
      {
         try
         {
            cmdRefreshMonster["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRefreshMonster.emphasized = false;
         cmdRefreshMonster.enabled = true;
         cmdRefreshMonster.label = "obf__4985";
         cmdRefreshMonster.labelPlacement = "right";
         cmdRefreshMonster.selected = false;
         cmdRefreshMonster.toggle = false;
         cmdRefreshMonster.visible = true;
         try
         {
            cmdRefreshMonster["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_w_3188() : *
      {
         try
         {
            inputPetMpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputPetMpPercent.displayAsPassword = false;
         inputPetMpPercent.editable = true;
         inputPetMpPercent.enabled = true;
         inputPetMpPercent.maxChars = 2;
         inputPetMpPercent.restrict = "0123456789";
         inputPetMpPercent.text = "";
         inputPetMpPercent.visible = true;
         try
         {
            inputPetMpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_7_X_316() : *
      {
         try
         {
            chkAutoAddPlayerExp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoAddPlayerExp.enabled = true;
         chkAutoAddPlayerExp.label = "obf_________45";
         chkAutoAddPlayerExp.labelPlacement = "right";
         chkAutoAddPlayerExp.selected = false;
         chkAutoAddPlayerExp.visible = true;
         try
         {
            chkAutoAddPlayerExp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_h_2_1764() : *
      {
         try
         {
            chkHpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkHpPercent.enabled = true;
         chkHpPercent.label = "obf_____4738";
         chkHpPercent.labelPlacement = "right";
         chkHpPercent.selected = true;
         chkHpPercent.visible = true;
         try
         {
            chkHpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_b_1575() : *
      {
         try
         {
            inputMpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputMpPercent.displayAsPassword = false;
         inputMpPercent.editable = true;
         inputMpPercent.enabled = true;
         inputMpPercent.maxChars = 2;
         inputMpPercent.restrict = "0123456789";
         inputMpPercent.text = "";
         inputMpPercent.visible = true;
         try
         {
            inputMpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_a_4053() : *
      {
         try
         {
            chkAutoAddBotTime["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoAddBotTime.enabled = true;
         chkAutoAddBotTime.label = "obf_________43";
         chkAutoAddBotTime.labelPlacement = "right";
         chkAutoAddBotTime.selected = false;
         chkAutoAddBotTime.visible = true;
         try
         {
            chkAutoAddBotTime["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_G_1875() : *
      {
         try
         {
            inputTimeUse1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTimeUse1.displayAsPassword = false;
         inputTimeUse1.editable = true;
         inputTimeUse1.enabled = true;
         inputTimeUse1.maxChars = 3;
         inputTimeUse1.restrict = "0-9";
         inputTimeUse1.text = "";
         inputTimeUse1.visible = true;
         try
         {
            inputTimeUse1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_t_J_2465() : *
      {
         try
         {
            chkAutoRepairEquip["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoRepairEquip.enabled = true;
         chkAutoRepairEquip.label = "obf__________31";
         chkAutoRepairEquip.labelPlacement = "right";
         chkAutoRepairEquip.selected = false;
         chkAutoRepairEquip.visible = true;
         try
         {
            chkAutoRepairEquip["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_9_228() : *
      {
         try
         {
            inputTimeUse2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTimeUse2.displayAsPassword = false;
         inputTimeUse2.editable = true;
         inputTimeUse2.enabled = true;
         inputTimeUse2.maxChars = 3;
         inputTimeUse2.restrict = "0-9";
         inputTimeUse2.text = "";
         inputTimeUse2.visible = true;
         try
         {
            inputTimeUse2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_6_2513() : *
      {
         try
         {
            chkPetMpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkPetMpPercent.enabled = true;
         chkPetMpPercent.label = "obf_____4841";
         chkPetMpPercent.labelPlacement = "right";
         chkPetMpPercent.selected = true;
         chkPetMpPercent.visible = true;
         try
         {
            chkPetMpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_V_2842() : *
      {
         try
         {
            cmdBotAction["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBotAction.emphasized = false;
         cmdBotAction.enabled = true;
         cmdBotAction.label = "obf_____4749";
         cmdBotAction.labelPlacement = "right";
         cmdBotAction.selected = false;
         cmdBotAction.toggle = false;
         cmdBotAction.visible = true;
         try
         {
            cmdBotAction["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_7_4_2518() : *
      {
         try
         {
            chkAutoAddPetExp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoAddPetExp.enabled = true;
         chkAutoAddPetExp.label = "obf_________47";
         chkAutoAddPetExp.labelPlacement = "right";
         chkAutoAddPetExp.selected = false;
         chkAutoAddPetExp.visible = true;
         try
         {
            chkAutoAddPetExp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_c_v_2399() : *
      {
         try
         {
            inputTimeUse0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTimeUse0.displayAsPassword = false;
         inputTimeUse0.editable = true;
         inputTimeUse0.enabled = true;
         inputTimeUse0.maxChars = 3;
         inputTimeUse0.restrict = "0-9";
         inputTimeUse0.text = "";
         inputTimeUse0.visible = true;
         try
         {
            inputTimeUse0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_N_0_2681() : *
      {
         try
         {
            chkMpPercent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkMpPercent.enabled = true;
         chkMpPercent.label = "obf_____4704";
         chkMpPercent.labelPlacement = "right";
         chkMpPercent.selected = true;
         chkMpPercent.visible = true;
         try
         {
            chkMpPercent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_8_2796() : *
      {
         try
         {
            chkPickUpOther["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkPickUpOther.enabled = true;
         chkPickUpOther.label = "obf___4892";
         chkPickUpOther.labelPlacement = "right";
         chkPickUpOther.selected = false;
         chkPickUpOther.visible = true;
         try
         {
            chkPickUpOther["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_v_R_1660() : *
      {
         try
         {
            chkAutoPerfectRepair["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoPerfectRepair.enabled = true;
         chkAutoPerfectRepair.label = "obf_______________11";
         chkAutoPerfectRepair.labelPlacement = "right";
         chkAutoPerfectRepair.selected = false;
         chkAutoPerfectRepair.visible = true;
         try
         {
            chkAutoPerfectRepair["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

