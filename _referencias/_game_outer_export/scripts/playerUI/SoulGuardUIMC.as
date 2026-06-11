package playerUI
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1743")]
   public dynamic class SoulGuardUIMC extends MovieClip
   {
      
      public var cmdUpgrade4:MainButton;
      
      public var obf_n_p_1457:MovieClip;
      
      public var obf_D_4668:MovieClip;
      
      public var obf_1_P_1395:MovieClip;
      
      public var obf_B_r_1532:MovieClip;
      
      public var obf_t_2_3837:MovieClip;
      
      public var obf_r_S_1375:MovieClip;
      
      public var txtBuffName2:TextField;
      
      public var txtNext:TextField;
      
      public var obf_5_T_3953:MovieClip;
      
      public var txtCurrentName:TextField;
      
      public var txtCurrentAttrValue:TextField;
      
      public var pointBuffIcon:MovieClip;
      
      public var txtCurrent:TextField;
      
      public var pointRoleModel:MovieClip;
      
      public var txtCurrentAttrName:TextField;
      
      public var bgBox2:MovieClip;
      
      public var bgBox3:MovieClip;
      
      public var listRole:MJList;
      
      public var txtNextName:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtNextAttrValue:TextField;
      
      public var txtNextAttrName:TextField;
      
      public var txtChange:TextField;
      
      public var titleBox:MovieClip;
      
      public var pointCeil:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtBuffName1:TextField;
      
      public var txtBuffName5:TextField;
      
      public var txtBuffName7:TextField;
      
      public var txtBuffName3:TextField;
      
      public var txtBuffName4:TextField;
      
      public var txtExplain:TextField;
      
      public var cmdUpgrade1:MainButton;
      
      public var cmdUpgrade2:MainButton;
      
      public var txtStar:TextField;
      
      public var txtUpMaterial:TextField;
      
      public var cmdUpgrade5:MainButton;
      
      public var cmdUpgrade6:MainButton;
      
      public var cmdUp:MainButton;
      
      public var txtBuffName6:TextField;
      
      public var cmdUpgrade3:MainButton;
      
      public var cmdUpgrade7:MainButton;
      
      public var upIcon1:IconBarMC;
      
      public var upIcon2:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public function SoulGuardUIMC()
      {
         super();
         obf_H_x_4074();
         obf_6_K_2448();
         obf_0_5_u_336();
         obf_0_2_p_201();
         obf_0_6_A_331();
         obf_C_w_1791();
         obf_M_6_1957();
         obf_U_T_869();
      }
      
      internal function obf_0_6_A_331() : *
      {
         try
         {
            cmdUpgrade5["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade5.emphasized = false;
         cmdUpgrade5.enabled = true;
         cmdUpgrade5.label = "obf___4912";
         cmdUpgrade5.labelPlacement = "right";
         cmdUpgrade5.selected = false;
         cmdUpgrade5.toggle = false;
         cmdUpgrade5.visible = true;
         try
         {
            cmdUpgrade5["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_M_6_1957() : *
      {
         try
         {
            cmdUpgrade7["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade7.emphasized = false;
         cmdUpgrade7.enabled = true;
         cmdUpgrade7.label = "obf___4912";
         cmdUpgrade7.labelPlacement = "right";
         cmdUpgrade7.selected = false;
         cmdUpgrade7.toggle = false;
         cmdUpgrade7.visible = true;
         try
         {
            cmdUpgrade7["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_x_4074() : *
      {
         try
         {
            cmdUpgrade1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade1.emphasized = false;
         cmdUpgrade1.enabled = true;
         cmdUpgrade1.label = "obf___4912";
         cmdUpgrade1.labelPlacement = "right";
         cmdUpgrade1.selected = false;
         cmdUpgrade1.toggle = false;
         cmdUpgrade1.visible = true;
         try
         {
            cmdUpgrade1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_6_K_2448() : *
      {
         try
         {
            cmdUpgrade2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade2.emphasized = false;
         cmdUpgrade2.enabled = true;
         cmdUpgrade2.label = "obf___4912";
         cmdUpgrade2.labelPlacement = "right";
         cmdUpgrade2.selected = false;
         cmdUpgrade2.toggle = false;
         cmdUpgrade2.visible = true;
         try
         {
            cmdUpgrade2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_u_336() : *
      {
         try
         {
            cmdUpgrade3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade3.emphasized = false;
         cmdUpgrade3.enabled = true;
         cmdUpgrade3.label = "obf___4912";
         cmdUpgrade3.labelPlacement = "right";
         cmdUpgrade3.selected = false;
         cmdUpgrade3.toggle = false;
         cmdUpgrade3.visible = true;
         try
         {
            cmdUpgrade3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_p_201() : *
      {
         try
         {
            cmdUpgrade4["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade4.emphasized = false;
         cmdUpgrade4.enabled = true;
         cmdUpgrade4.label = "obf___4912";
         cmdUpgrade4.labelPlacement = "right";
         cmdUpgrade4.selected = false;
         cmdUpgrade4.toggle = false;
         cmdUpgrade4.visible = true;
         try
         {
            cmdUpgrade4["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_U_T_869() : *
      {
         try
         {
            cmdUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUp.emphasized = false;
         cmdUp.enabled = true;
         cmdUp.label = "obf___4912";
         cmdUp.labelPlacement = "right";
         cmdUp.selected = false;
         cmdUp.toggle = false;
         cmdUp.visible = true;
         try
         {
            cmdUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_C_w_1791() : *
      {
         try
         {
            cmdUpgrade6["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpgrade6.emphasized = false;
         cmdUpgrade6.enabled = true;
         cmdUpgrade6.label = "obf___4912";
         cmdUpgrade6.labelPlacement = "right";
         cmdUpgrade6.selected = false;
         cmdUpgrade6.toggle = false;
         cmdUpgrade6.visible = true;
         try
         {
            cmdUpgrade6["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

