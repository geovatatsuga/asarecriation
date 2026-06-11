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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1996")]
   public dynamic class ChallengeUIMC extends MovieClip
   {
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var btnObtain:MainButton;
      
      public var txtName:TextField;
      
      public var surplusTimeNum:TextField;
      
      public var cmdAward:MainButton;
      
      public var obf_0_3_E_375:TextField;
      
      public var cmdLook1:MainButton;
      
      public var cmdLook2:MainButton;
      
      public var cmdLook3:MainButton;
      
      public var cmdLook4:MainButton;
      
      public var award:IconBarMC;
      
      public var obf_O_F_2801:UIScrollBar;
      
      public var bgbox:MovieClip;
      
      public var txtCommunique:TextField;
      
      public var cmdLook0:MainButton;
      
      public var txtName0:TextField;
      
      public var txtName1:TextField;
      
      public var txtName2:TextField;
      
      public var txtName4:TextField;
      
      public var txtRankLv:TextField;
      
      public var txtName3:TextField;
      
      public var txtAwardsRank:TextField;
      
      public var point1:MovieClip;
      
      public var point2:MovieClip;
      
      public var point3:MovieClip;
      
      public var point4:MovieClip;
      
      public var cmdDare0:MainButton;
      
      public var cmdDare1:MainButton;
      
      public var cmdDare3:MainButton;
      
      public var cmdDare4:MainButton;
      
      public var cmdDare2:MainButton;
      
      public var point0:MovieClip;
      
      public var txtReceiveTime:TextField;
      
      public var txtArards:TextField;
      
      public var txtTitle:TextField;
      
      public var txtRank:TextField;
      
      public var txtAwardGold:TextField;
      
      public var txtDeyRank:TextField;
      
      public var surplusTime:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtRank0:TextField;
      
      public var txtRank1:TextField;
      
      public var txtRank2:TextField;
      
      public var txtRank3:TextField;
      
      public var txtRank4:TextField;
      
      public function ChallengeUIMC()
      {
         super();
         obf_0_7_K_536();
         obf_g_8_4454();
         obf_T_R_1813();
         obf_X_z_2715();
         obf_o_b_3744();
         obf_m_e_2735();
         obf_s_q_2925();
         obf_e_l_s_e_2616();
         obf_6_n_1726();
         obf_8_v_4396();
         obf_G_R_4099();
         obf_V_Z_3357();
         obf_c_1_756();
         obf_D_6_1722();
      }
      
      internal function obf_s_q_2925() : *
      {
         try
         {
            cmdLook3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLook3.emphasized = false;
         cmdLook3.enabled = true;
         cmdLook3.label = "";
         cmdLook3.labelPlacement = "right";
         cmdLook3.selected = false;
         cmdLook3.toggle = false;
         cmdLook3.visible = true;
         try
         {
            cmdLook3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_Z_3357() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "txtCommunique";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_e_l_s_e_2616() : *
      {
         try
         {
            cmdDare3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDare3.emphasized = false;
         cmdDare3.enabled = true;
         cmdDare3.label = "";
         cmdDare3.labelPlacement = "right";
         cmdDare3.selected = false;
         cmdDare3.toggle = false;
         cmdDare3.visible = true;
         try
         {
            cmdDare3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_7_K_536() : *
      {
         try
         {
            cmdLook0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLook0.emphasized = false;
         cmdLook0.enabled = true;
         cmdLook0.label = "";
         cmdLook0.labelPlacement = "right";
         cmdLook0.selected = false;
         cmdLook0.toggle = false;
         cmdLook0.visible = true;
         try
         {
            cmdLook0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_T_R_1813() : *
      {
         try
         {
            cmdDare0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDare0.emphasized = false;
         cmdDare0.enabled = true;
         cmdDare0.label = "";
         cmdDare0.labelPlacement = "right";
         cmdDare0.selected = false;
         cmdDare0.toggle = false;
         cmdDare0.visible = true;
         try
         {
            cmdDare0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_G_R_4099() : *
      {
         try
         {
            obf_O_F_2801["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_O_F_2801.direction = "vertical";
         obf_O_F_2801.scrollTargetName = "txtRank";
         obf_O_F_2801.visible = true;
         try
         {
            obf_O_F_2801["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_o_b_3744() : *
      {
         try
         {
            cmdLook2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLook2.emphasized = false;
         cmdLook2.enabled = true;
         cmdLook2.label = "";
         cmdLook2.labelPlacement = "right";
         cmdLook2.selected = false;
         cmdLook2.toggle = false;
         cmdLook2.visible = true;
         try
         {
            cmdLook2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_e_2735() : *
      {
         try
         {
            cmdDare2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDare2.emphasized = false;
         cmdDare2.enabled = true;
         cmdDare2.label = "";
         cmdDare2.labelPlacement = "right";
         cmdDare2.selected = false;
         cmdDare2.toggle = false;
         cmdDare2.visible = true;
         try
         {
            cmdDare2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_6_n_1726() : *
      {
         try
         {
            cmdLook4["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLook4.emphasized = false;
         cmdLook4.enabled = true;
         cmdLook4.label = "";
         cmdLook4.labelPlacement = "right";
         cmdLook4.selected = false;
         cmdLook4.toggle = false;
         cmdLook4.visible = true;
         try
         {
            cmdLook4["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_8_v_4396() : *
      {
         try
         {
            cmdDare4["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDare4.emphasized = false;
         cmdDare4.enabled = true;
         cmdDare4.label = "";
         cmdDare4.labelPlacement = "right";
         cmdDare4.selected = false;
         cmdDare4.toggle = false;
         cmdDare4.visible = true;
         try
         {
            cmdDare4["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_c_1_756() : *
      {
         try
         {
            cmdAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAward.emphasized = false;
         cmdAward.enabled = true;
         cmdAward.label = "";
         cmdAward.labelPlacement = "right";
         cmdAward.selected = false;
         cmdAward.toggle = false;
         cmdAward.visible = true;
         try
         {
            cmdAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_g_8_4454() : *
      {
         try
         {
            cmdLook1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLook1.emphasized = false;
         cmdLook1.enabled = true;
         cmdLook1.label = "";
         cmdLook1.labelPlacement = "right";
         cmdLook1.selected = false;
         cmdLook1.toggle = false;
         cmdLook1.visible = true;
         try
         {
            cmdLook1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_6_1722() : *
      {
         try
         {
            btnObtain["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         btnObtain.emphasized = false;
         btnObtain.enabled = true;
         btnObtain.label = "";
         btnObtain.labelPlacement = "right";
         btnObtain.selected = false;
         btnObtain.toggle = false;
         btnObtain.visible = true;
         try
         {
            btnObtain["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_z_2715() : *
      {
         try
         {
            cmdDare1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDare1.emphasized = false;
         cmdDare1.enabled = true;
         cmdDare1.label = "";
         cmdDare1.labelPlacement = "right";
         cmdDare1.selected = false;
         cmdDare1.toggle = false;
         cmdDare1.visible = true;
         try
         {
            cmdDare1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

