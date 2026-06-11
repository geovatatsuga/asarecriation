package playerUI
{
   import adobe.utils.*;
   import fl.controls.DataGrid;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2452")]
   public dynamic class FamilyBoxUIMC extends MovieClip
   {
      
      public var txtFamilyMemberCount:TextField;
      
      public var txtFamilyGx:TextField;
      
      public var cmdSetIntroduction:MainButton;
      
      public var cmdSetRank:MainButton;
      
      public var skillBag0:SkillShowBoxUIMC;
      
      public var skillBag1:SkillShowBoxUIMC;
      
      public var skillBag2:SkillShowBoxUIMC;
      
      public var skillBag3:SkillShowBoxUIMC;
      
      public var skillBag4:SkillShowBoxUIMC;
      
      public var skillBag5:SkillShowBoxUIMC;
      
      public var skillBag6:SkillShowBoxUIMC;
      
      public var skillBag7:SkillShowBoxUIMC;
      
      public var skillBag8:SkillShowBoxUIMC;
      
      public var skillBag9:SkillShowBoxUIMC;
      
      public var txtDeyFamilyGx:TextField;
      
      public var txtRes2:TextField;
      
      public var txtFamilyLeader:TextField;
      
      public var txtDeyFamilyLeader:TextField;
      
      public var txtDeyFamilyIntroduction:TextField;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var memberList:DataGrid;
      
      public var cmdLeaveFamily:MainButton;
      
      public var txtDeyFamilyExp:TextField;
      
      public var txtDeyFamilyTotlaGx:TextField;
      
      public var cmdDismissFamily:MainButton;
      
      public var txtMessage:TextField;
      
      public var obf_O_m_3194:UIScrollBar;
      
      public var cmdUpgrade:MainButton;
      
      public var cmdJoin:MainButton;
      
      public var obf_y_4697:UIScrollBar;
      
      public var txtFamilyExp:TextField;
      
      public var txtFamilyTotlaGx:TextField;
      
      public var cmdSetBulletin:MainButton;
      
      public var pointFamilyGold:MovieClip;
      
      public var txtDeyFamilyGold:TextField;
      
      public var txtFamilyName:TextField;
      
      public var txtIntroduction:TextField;
      
      public var txtFamilyPost:TextField;
      
      public var expBar:MovieClip;
      
      public var txtDeyFamilyName:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyFamilyRes2:TextField;
      
      public var txtDeyFamilyMember:TextField;
      
      public var txtDeyFamilyPost:TextField;
      
      public var txtDeyFamilyBulletin:TextField;
      
      public var txtDeyFamilyLevel:TextField;
      
      public var txtDeyFamilyInfo:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyFamilyMemberCount:TextField;
      
      public var txtFamilyLevel:TextField;
      
      public var txtDeyFamilyRes:TextField;
      
      public function FamilyBoxUIMC()
      {
         super();
         obf_A_T_2047();
         obf_f_W_3923();
         obf_u_D_4474();
         obf_G_N_3968();
         obf_c_5_2443();
         obf_K_Z_1479();
         obf_8_7_1256();
         obf_t_r_1725();
         obf_m_3_3248();
      }
      
      internal function obf_f_W_3923() : *
      {
         try
         {
            cmdSetBulletin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSetBulletin.emphasized = false;
         cmdSetBulletin.enabled = true;
         cmdSetBulletin.label = "obf_____4799";
         cmdSetBulletin.labelPlacement = "right";
         cmdSetBulletin.selected = false;
         cmdSetBulletin.toggle = false;
         cmdSetBulletin.visible = true;
         try
         {
            cmdSetBulletin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_K_Z_1479() : *
      {
         try
         {
            cmdSetIntroduction["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSetIntroduction.emphasized = false;
         cmdSetIntroduction.enabled = true;
         cmdSetIntroduction.label = "obf_____4757";
         cmdSetIntroduction.labelPlacement = "right";
         cmdSetIntroduction.selected = false;
         cmdSetIntroduction.toggle = false;
         cmdSetIntroduction.visible = true;
         try
         {
            cmdSetIntroduction["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_8_7_1256() : *
      {
         try
         {
            cmdJoin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdJoin.emphasized = false;
         cmdJoin.enabled = true;
         cmdJoin.label = "obf_______968";
         cmdJoin.labelPlacement = "right";
         cmdJoin.selected = false;
         cmdJoin.toggle = false;
         cmdJoin.visible = true;
         try
         {
            cmdJoin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_t_r_1725() : *
      {
         try
         {
            obf_O_m_3194["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_O_m_3194.direction = "vertical";
         obf_O_m_3194.scrollTargetName = "txtMessage";
         obf_O_m_3194.visible = true;
         try
         {
            obf_O_m_3194["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_c_5_2443() : *
      {
         try
         {
            cmdUpgrade["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade.emphasized = false;
         cmdUpgrade.enabled = true;
         cmdUpgrade.label = "obf_____4834";
         cmdUpgrade.labelPlacement = "right";
         cmdUpgrade.selected = false;
         cmdUpgrade.toggle = false;
         cmdUpgrade.visible = true;
         try
         {
            cmdUpgrade["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_D_4474() : *
      {
         try
         {
            cmdSetRank["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSetRank.emphasized = false;
         cmdSetRank.enabled = true;
         cmdSetRank.label = "obf_____4777";
         cmdSetRank.labelPlacement = "right";
         cmdSetRank.selected = false;
         cmdSetRank.toggle = false;
         cmdSetRank.visible = true;
         try
         {
            cmdSetRank["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_3_3248() : *
      {
         try
         {
            obf_y_4697["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_y_4697.direction = "vertical";
         obf_y_4697.scrollTargetName = "txtIntroduction";
         obf_y_4697.visible = true;
         try
         {
            obf_y_4697["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_T_2047() : *
      {
         try
         {
            cmdLeaveFamily["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLeaveFamily.emphasized = false;
         cmdLeaveFamily.enabled = true;
         cmdLeaveFamily.label = "obf_____4784";
         cmdLeaveFamily.labelPlacement = "right";
         cmdLeaveFamily.selected = false;
         cmdLeaveFamily.toggle = false;
         cmdLeaveFamily.visible = true;
         try
         {
            cmdLeaveFamily["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_G_N_3968() : *
      {
         try
         {
            cmdDismissFamily["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDismissFamily.emphasized = false;
         cmdDismissFamily.enabled = true;
         cmdDismissFamily.label = "obf_____4802";
         cmdDismissFamily.labelPlacement = "right";
         cmdDismissFamily.selected = false;
         cmdDismissFamily.toggle = false;
         cmdDismissFamily.visible = true;
         try
         {
            cmdDismissFamily["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

