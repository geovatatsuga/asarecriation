package playerUI
{
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4271")]
   public dynamic class ExtractantUIMC extends MovieClip
   {
      
      public var extIcon:IconBarMC;
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var txtTitle:TextField;
      
      public var selectRank:ComboBox;
      
      public var txtRemark:TextField;
      
      public var txtSelect:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtAbility:TextField;
      
      public var txtTime:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdUpLv:MainButton;
      
      public var txtRemark2:TextField;
      
      public var cmdType1:MainButton;
      
      public var cmdType2:MainButton;
      
      public var cmdType3:MainButton;
      
      public var obf_q_4_1005:UIScrollBar;
      
      public var txtConsume:TextField;
      
      public var txtNum:TextField;
      
      public var itemPoint:MovieClip;
      
      public var effectPoint:MovieClip;
      
      public function ExtractantUIMC()
      {
         super();
         obf_S_B_2178();
         obf_0_2_F_167();
         obf_4_m_3202();
         obf_p_m_1906();
         override();
         obf_X_e_1641();
      }
      
      internal function obf_S_B_2178() : *
      {
         try
         {
            cmdType1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdType1.emphasized = false;
         cmdType1.enabled = true;
         cmdType1.label = "obf___4870";
         cmdType1.labelPlacement = "right";
         cmdType1.selected = false;
         cmdType1.toggle = false;
         cmdType1.visible = true;
         try
         {
            cmdType1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function override() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "InstanceName_0";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_m_1906() : *
      {
         try
         {
            cmdUpLv["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpLv.emphasized = false;
         cmdUpLv.enabled = true;
         cmdUpLv.label = "obf_____4837";
         cmdUpLv.labelPlacement = "right";
         cmdUpLv.selected = false;
         cmdUpLv.toggle = false;
         cmdUpLv.visible = true;
         try
         {
            cmdUpLv["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_m_3202() : *
      {
         try
         {
            cmdType3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdType3.emphasized = false;
         cmdType3.enabled = true;
         cmdType3.label = "obf___4916";
         cmdType3.labelPlacement = "right";
         cmdType3.selected = false;
         cmdType3.toggle = false;
         cmdType3.visible = true;
         try
         {
            cmdType3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_e_1641() : *
      {
         try
         {
            obf_q_4_1005["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_q_4_1005.direction = "vertical";
         obf_q_4_1005.scrollTargetName = "txtRemark";
         obf_q_4_1005.visible = true;
         try
         {
            obf_q_4_1005["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_F_167() : *
      {
         try
         {
            cmdType2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdType2.emphasized = false;
         cmdType2.enabled = true;
         cmdType2.label = "obf___4973";
         cmdType2.labelPlacement = "right";
         cmdType2.selected = false;
         cmdType2.toggle = false;
         cmdType2.visible = true;
         try
         {
            cmdType2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

