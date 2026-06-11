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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3829")]
   public dynamic class LockTowerUIMC extends MovieClip
   {
      
      public var txtTower:TextField;
      
      public var txtAttrName0:TextField;
      
      public var txtAttrName1:TextField;
      
      public var txtAttrName2:TextField;
      
      public var txtAttrName3:TextField;
      
      public var txtAttrName4:TextField;
      
      public var txtTip:TextField;
      
      public var txtTowerLvName:TextField;
      
      public var txtTowerAttr:TextField;
      
      public var cmdPrv:MainButton;
      
      public var txtPage:TextField;
      
      public var cmdTower1:MainButton;
      
      public var cmdTower3:MainButton;
      
      public var cmdTower4:MainButton;
      
      public var cmdTower5:MainButton;
      
      public var cmdTower0:MainButton;
      
      public var cmdTower2:MainButton;
      
      public var cmdBuff:MainButton;
      
      public var expBar:MovieClip;
      
      public var bg:MovieClip;
      
      public var txtMonster:TextField;
      
      public var txtAttrVale0:TextField;
      
      public var txtAttrVale1:TextField;
      
      public var cmdNext:MainButton;
      
      public var txtAttrVale3:TextField;
      
      public var txtTitle:TextField;
      
      public var pointModle:MovieClip;
      
      public var txtAttrVale2:TextField;
      
      public var cmdFree:MainButton;
      
      public var cmdEat:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var txtTowerLv:TextField;
      
      public var txtTowerExp:TextField;
      
      public var txtAttrVale4:TextField;
      
      public var imgClose:MovieClip;
      
      public var cmdTowerUp:MainButton;
      
      public var cmdUp:MainButton;
      
      public function LockTowerUIMC()
      {
         super();
         obf_q_A_1079();
         obf_D_e_2218();
         obf_B_C_1360();
         obf_p_A_841();
         obf_t_D_3111();
         obf_0_7_n_160();
         obf_n_F_2575();
         obf_0_4_q_112();
         obf_w_t_2577();
         obf_0_p_788();
         obf_3_o_1145();
         obf_i_1_1000();
         obf_0_5_k_386();
      }
      
      internal function obf_w_t_2577() : *
      {
         try
         {
            cmdTower2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower2.emphasized = false;
         cmdTower2.enabled = true;
         cmdTower2.label = "cmdTower2";
         cmdTower2.labelPlacement = "right";
         cmdTower2.selected = false;
         cmdTower2.toggle = false;
         cmdTower2.visible = true;
         try
         {
            cmdTower2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_k_386() : *
      {
         try
         {
            cmdNext["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNext.emphasized = false;
         cmdNext.enabled = true;
         cmdNext.label = "cmdNext";
         cmdNext.labelPlacement = "right";
         cmdNext.selected = false;
         cmdNext.toggle = false;
         cmdNext.visible = true;
         try
         {
            cmdNext["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_e_2218() : *
      {
         try
         {
            cmdEat["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEat.emphasized = false;
         cmdEat.enabled = true;
         cmdEat.label = "cmdEat";
         cmdEat.labelPlacement = "right";
         cmdEat.selected = false;
         cmdEat.toggle = false;
         cmdEat.visible = true;
         try
         {
            cmdEat["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_p_788() : *
      {
         try
         {
            cmdTower3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower3.emphasized = false;
         cmdTower3.enabled = true;
         cmdTower3.label = "cmdTower3";
         cmdTower3.labelPlacement = "right";
         cmdTower3.selected = false;
         cmdTower3.toggle = false;
         cmdTower3.visible = true;
         try
         {
            cmdTower3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_7_n_160() : *
      {
         try
         {
            cmdPrv["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrv.emphasized = false;
         cmdPrv.enabled = true;
         cmdPrv.label = "cmdPrv";
         cmdPrv.labelPlacement = "right";
         cmdPrv.selected = false;
         cmdPrv.toggle = false;
         cmdPrv.visible = true;
         try
         {
            cmdPrv["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_q_A_1079() : *
      {
         try
         {
            cmdBuff["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuff.emphasized = false;
         cmdBuff.enabled = true;
         cmdBuff.label = "cmdBuff";
         cmdBuff.labelPlacement = "right";
         cmdBuff.selected = false;
         cmdBuff.toggle = false;
         cmdBuff.visible = true;
         try
         {
            cmdBuff["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_A_841() : *
      {
         try
         {
            cmdFree["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFree.emphasized = false;
         cmdFree.enabled = true;
         cmdFree.label = "cmdFree";
         cmdFree.labelPlacement = "right";
         cmdFree.selected = false;
         cmdFree.toggle = false;
         cmdFree.visible = true;
         try
         {
            cmdFree["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_3_o_1145() : *
      {
         try
         {
            cmdTower4["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower4.emphasized = false;
         cmdTower4.enabled = true;
         cmdTower4.label = "cmdTower4";
         cmdTower4.labelPlacement = "right";
         cmdTower4.selected = false;
         cmdTower4.toggle = false;
         cmdTower4.visible = true;
         try
         {
            cmdTower4["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_n_F_2575() : *
      {
         try
         {
            cmdTower0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower0.emphasized = false;
         cmdTower0.enabled = true;
         cmdTower0.label = "cmdTower0";
         cmdTower0.labelPlacement = "right";
         cmdTower0.selected = false;
         cmdTower0.toggle = false;
         cmdTower0.visible = true;
         try
         {
            cmdTower0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_i_1_1000() : *
      {
         try
         {
            cmdTower5["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower5.emphasized = false;
         cmdTower5.enabled = true;
         cmdTower5.label = "cmdTower5";
         cmdTower5.labelPlacement = "right";
         cmdTower5.selected = false;
         cmdTower5.toggle = false;
         cmdTower5.visible = true;
         try
         {
            cmdTower5["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_q_112() : *
      {
         try
         {
            cmdTower1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTower1.emphasized = false;
         cmdTower1.enabled = true;
         cmdTower1.label = "cmdTower1";
         cmdTower1.labelPlacement = "right";
         cmdTower1.selected = false;
         cmdTower1.toggle = false;
         cmdTower1.visible = true;
         try
         {
            cmdTower1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_t_D_3111() : *
      {
         try
         {
            cmdTowerUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTowerUp.emphasized = false;
         cmdTowerUp.enabled = true;
         cmdTowerUp.label = "cmdTowerUp";
         cmdTowerUp.labelPlacement = "right";
         cmdTowerUp.selected = false;
         cmdTowerUp.toggle = false;
         cmdTowerUp.visible = true;
         try
         {
            cmdTowerUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_B_C_1360() : *
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
         cmdUp.label = "cmdUp";
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
   }
}

