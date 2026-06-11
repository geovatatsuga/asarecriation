package playerUI
{
   import adobe.utils.*;
   import fl.controls.ComboBox;
   import fl.controls.UIScrollBar;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4221")]
   public dynamic class ConstellationUIMC extends MovieClip
   {
      
      public var taskScrollBar:UIScrollBar;
      
      public var txtCompose:TextField;
      
      public var itemObj10:SimpleCollectionItem;
      
      public var collProps10:Array;
      
      public var cmdAssociate:MainButton;
      
      public var txtDay:TextField;
      
      public var obf_q_f_4369:*;
      
      public var obf_F_X_2456:*;
      
      public var cmdRouse:MainButton;
      
      public var attrScrollBar:UIScrollBar;
      
      public var txtName:TextField;
      
      public var pointConstellationUp:MovieClip;
      
      public var j10:*;
      
      public var taskShow:TextField;
      
      public var cmdConfirm:MainButton;
      
      public var bagClothes:IconBarMC;
      
      public var obf_h_C_2919:DataProvider;
      
      public var inputYear:ComboBox;
      
      public var pointIcon:MovieClip;
      
      public var obf_n_G_1004:DataProvider;
      
      public var bagWeapon:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var i10:int;
      
      public var cmdReceive:MainButton;
      
      public var blessScrollBar:UIScrollBar;
      
      public var luckShow:TextField;
      
      public var bagTally:IconBarMC;
      
      public var pointLuck:MovieClip;
      
      public var luckScrollBar:UIScrollBar;
      
      public var constellationLevel:TextField;
      
      public var inputDay:ComboBox;
      
      public var cmdUp:MainButton;
      
      public var taskAwardContent:MovieClip;
      
      public var cmdChange:MainButton;
      
      public var scrollTaskAward:UIScrollBar;
      
      public var attrShow:TextField;
      
      public var bagShield:IconBarMC;
      
      public var cmdComplete:MainButton;
      
      public var blessShow:TextField;
      
      public var obf_I_B_1338:Object;
      
      public var txtWeapon:TextField;
      
      public var txtClothes:TextField;
      
      public var composeScrolBar:UIScrollBar;
      
      public var collObj10:DataProvider;
      
      public var obf_Q_U_979:Object;
      
      public var collProp10:Object;
      
      public var pointConstellationUp1:MovieClip;
      
      public var itemObj8:SimpleCollectionItem;
      
      public var itemObj9:SimpleCollectionItem;
      
      public var inputMonth:ComboBox;
      
      public var cmdAbandon:MainButton;
      
      public var txtTally:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdBless:MainButton;
      
      public var cmdAccept:MainButton;
      
      public var obf_8_E_2383:Array;
      
      public var obf_0_8_e_309:Array;
      
      public var i8:int;
      
      public var pointLuck1:MovieClip;
      
      public var cmdCompose:MainButton;
      
      public var txtShield:TextField;
      
      public var i9:int;
      
      public function ConstellationUIMC()
      {
         super();
         obf_V_1_1046();
         obf_f_I_3312();
         obf_w_q_2922();
         obf_J_4395();
         obf_W_M_3273();
         obf_g_F_1211();
         obf_K_4_1493();
         obf_b_G_3249();
         obf_x_U_3401();
         obf_8_y_3315();
         obf_0_1_G_712();
         obf_T_h_2007();
         obf_X_9_1243();
         dynamic();
         obf_y_0_1898();
         obf_F_4_3860();
         obf_b_W_3337();
         obf_0_6_Y_354();
         obf_0_8_a_342();
      }
      
      internal function obf_0_6_Y_354() : *
      {
         try
         {
            cmdConfirm["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdConfirm.emphasized = false;
         cmdConfirm.enabled = true;
         cmdConfirm.label = "obf___4864";
         cmdConfirm.labelPlacement = "right";
         cmdConfirm.selected = false;
         cmdConfirm.toggle = false;
         cmdConfirm.visible = true;
         try
         {
            cmdConfirm["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_g_F_1211() : *
      {
         try
         {
            taskScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         taskScrollBar.direction = "vertical";
         taskScrollBar.scrollTargetName = "taskShow";
         taskScrollBar.visible = true;
         try
         {
            taskScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_9_1243() : *
      {
         try
         {
            cmdReceive["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReceive.emphasized = false;
         cmdReceive.enabled = true;
         cmdReceive.label = "obf___4867";
         cmdReceive.labelPlacement = "right";
         cmdReceive.selected = false;
         cmdReceive.toggle = false;
         cmdReceive.visible = true;
         try
         {
            cmdReceive["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_K_4_1493() : *
      {
         try
         {
            blessScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         blessScrollBar.direction = "vertical";
         blessScrollBar.scrollTargetName = "blessShow";
         blessScrollBar.visible = true;
         try
         {
            blessScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_F_4_3860() : *
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
      
      internal function obf_8_y_3315() : *
      {
         try
         {
            cmdAbandon["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAbandon.emphasized = false;
         cmdAbandon.enabled = true;
         cmdAbandon.label = "obf___4945";
         cmdAbandon.labelPlacement = "right";
         cmdAbandon.selected = false;
         cmdAbandon.toggle = false;
         cmdAbandon.visible = true;
         try
         {
            cmdAbandon["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_J_4395() : *
      {
         try
         {
            composeScrolBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         composeScrolBar.direction = "vertical";
         composeScrolBar.scrollTargetName = "txtCompose";
         composeScrolBar.visible = true;
         try
         {
            composeScrolBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_W_3337() : *
      {
         try
         {
            cmdCompose["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCompose.emphasized = false;
         cmdCompose.enabled = true;
         cmdCompose.label = "obf___4883";
         cmdCompose.labelPlacement = "right";
         cmdCompose.selected = false;
         cmdCompose.toggle = false;
         cmdCompose.visible = true;
         try
         {
            cmdCompose["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_a_342() : *
      {
         try
         {
            cmdRouse["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRouse.emphasized = false;
         cmdRouse.enabled = true;
         cmdRouse.label = "obf___4956";
         cmdRouse.labelPlacement = "right";
         cmdRouse.selected = false;
         cmdRouse.toggle = false;
         cmdRouse.visible = true;
         try
         {
            cmdRouse["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_T_h_2007() : *
      {
         try
         {
            cmdBless["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBless.emphasized = false;
         cmdBless.enabled = true;
         cmdBless.label = "obf___4974";
         cmdBless.labelPlacement = "right";
         cmdBless.selected = false;
         cmdBless.toggle = false;
         cmdBless.visible = true;
         try
         {
            cmdBless["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_w_q_2922() : *
      {
         try
         {
            inputYear["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         collObj10 = new DataProvider();
         collProps10 = [{
            "label":2500,
            "data":""
         }];
         i10 = 0;
         while(i10 < collProps10.length)
         {
            itemObj10 = new SimpleCollectionItem();
            collProp10 = collProps10[i10];
            for(j10 in collProp10)
            {
               itemObj10[j10] = collProp10[j10];
            }
            collObj10.addItem(itemObj10);
            ++i10;
         }
         inputYear.dataProvider = collObj10;
         inputYear.editable = false;
         inputYear.enabled = true;
         inputYear.prompt = "";
         inputYear.restrict = "";
         inputYear.rowCount = 5;
         inputYear.visible = true;
         try
         {
            inputYear["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_y_0_1898() : *
      {
         try
         {
            cmdAccept["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAccept.emphasized = false;
         cmdAccept.enabled = true;
         cmdAccept.label = "obf_____4845";
         cmdAccept.labelPlacement = "right";
         cmdAccept.selected = false;
         cmdAccept.toggle = false;
         cmdAccept.visible = true;
         try
         {
            cmdAccept["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_1_1046() : *
      {
         try
         {
            inputMonth["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_h_C_2919 = new DataProvider();
         obf_8_E_2383 = [{
            "label":10,
            "data":""
         },{
            "label":2,
            "data":""
         },{
            "label":3,
            "data":""
         },{
            "label":4,
            "data":""
         },{
            "label":5,
            "data":""
         }];
         i8 = 0;
         while(i8 < obf_8_E_2383.length)
         {
            itemObj8 = new SimpleCollectionItem();
            obf_I_B_1338 = obf_8_E_2383[i8];
            for(obf_q_f_4369 in obf_I_B_1338)
            {
               itemObj8[obf_q_f_4369] = obf_I_B_1338[obf_q_f_4369];
            }
            obf_h_C_2919.addItem(itemObj8);
            ++i8;
         }
         inputMonth.dataProvider = obf_h_C_2919;
         inputMonth.editable = false;
         inputMonth.enabled = true;
         inputMonth.prompt = "";
         inputMonth.restrict = "";
         inputMonth.rowCount = 5;
         inputMonth.visible = true;
         try
         {
            inputMonth["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_G_712() : *
      {
         try
         {
            cmdComplete["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdComplete.emphasized = false;
         cmdComplete.enabled = true;
         cmdComplete.label = "obf___4980";
         cmdComplete.labelPlacement = "right";
         cmdComplete.selected = false;
         cmdComplete.toggle = false;
         cmdComplete.visible = true;
         try
         {
            cmdComplete["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_I_3312() : *
      {
         try
         {
            inputDay["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_n_G_1004 = new DataProvider();
         obf_0_8_e_309 = [{
            "label":100,
            "data":""
         },{
            "label":2,
            "data":""
         },{
            "label":3,
            "data":""
         },{
            "label":4,
            "data":""
         },{
            "label":5,
            "data":""
         },{
            "label":6,
            "data":""
         },{
            "label":7,
            "data":""
         },{
            "label":8,
            "data":""
         },{
            "label":9,
            "data":""
         },{
            "label":10,
            "data":""
         },{
            "label":11,
            "data":""
         },{
            "label":12,
            "data":""
         }];
         i9 = 0;
         while(i9 < obf_0_8_e_309.length)
         {
            itemObj9 = new SimpleCollectionItem();
            obf_Q_U_979 = obf_0_8_e_309[i9];
            for(obf_F_X_2456 in obf_Q_U_979)
            {
               itemObj9[obf_F_X_2456] = obf_Q_U_979[obf_F_X_2456];
            }
            obf_n_G_1004.addItem(itemObj9);
            ++i9;
         }
         inputDay.dataProvider = obf_n_G_1004;
         inputDay.editable = false;
         inputDay.enabled = true;
         inputDay.prompt = "";
         inputDay.restrict = "";
         inputDay.rowCount = 5;
         inputDay.visible = true;
         try
         {
            inputDay["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_W_M_3273() : *
      {
         try
         {
            luckScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         luckScrollBar.direction = "vertical";
         luckScrollBar.scrollTargetName = "luckShow";
         luckScrollBar.visible = true;
         try
         {
            luckScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_x_U_3401() : *
      {
         try
         {
            cmdAssociate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAssociate.emphasized = false;
         cmdAssociate.enabled = true;
         cmdAssociate.label = "obf_____4796";
         cmdAssociate.labelPlacement = "right";
         cmdAssociate.selected = false;
         cmdAssociate.toggle = false;
         cmdAssociate.visible = false;
         try
         {
            cmdAssociate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_G_3249() : *
      {
         try
         {
            attrScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         attrScrollBar.direction = "vertical";
         attrScrollBar.scrollTargetName = "attrShow";
         attrScrollBar.visible = true;
         try
         {
            attrScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function dynamic() : *
      {
         try
         {
            cmdChange["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdChange.emphasized = false;
         cmdChange.enabled = true;
         cmdChange.label = "obf_____4830";
         cmdChange.labelPlacement = "right";
         cmdChange.selected = false;
         cmdChange.toggle = false;
         cmdChange.visible = true;
         try
         {
            cmdChange["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

