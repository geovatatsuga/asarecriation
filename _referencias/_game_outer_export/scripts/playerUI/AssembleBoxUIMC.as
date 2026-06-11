package playerUI
{
   import ControlClass.MJCheckBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol641")]
   public dynamic class AssembleBoxUIMC extends MovieClip
   {
      
      public var itemObj17:SimpleCollectionItem;
      
      public var itemObj18:SimpleCollectionItem;
      
      public var txtRemark:TextField;
      
      public var obf_D_M_2040:Array;
      
      public var obf_0_5_M_328:Array;
      
      public var obf_f_4_2076:*;
      
      public var obf_6_x_1321:*;
      
      public var aBag0:IconBarMC;
      
      public var aBag1:IconBarMC;
      
      public var aBag2:IconBarMC;
      
      public var aBag3:IconBarMC;
      
      public var aBag4:IconBarMC;
      
      public var aBag5:IconBarMC;
      
      public var mBag0:IconBarMC;
      
      public var mBag1:IconBarMC;
      
      public var mBag2:IconBarMC;
      
      public var mBag3:IconBarMC;
      
      public var mBag4:IconBarMC;
      
      public var mBag5:IconBarMC;
      
      public var cmdCountDown:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyProduct:TextField;
      
      public var i17:int;
      
      public var i18:int;
      
      public var titleBox:MovieClip;
      
      public var chkEqualItem:MJCheckBox;
      
      public var scrollProduct:UIScrollBar;
      
      public var txtDeyMainMaiter:TextField;
      
      public var cmdCountUp:SimpleButton;
      
      public var txtDeyLifeJob:TextField;
      
      public var txtDeyTopType:TextField;
      
      public var txtLifeJob:TextField;
      
      public var cmdMakeButton:MainButton;
      
      public var cmdCloseButton:MainButton;
      
      public var listTopType:ComboBox;
      
      public var txtDeyAssCount:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var costPoint:MovieClip;
      
      public var txtAssembleCount:TextField;
      
      public var obf_6_V_3795:DataProvider;
      
      public var txtChance:TextField;
      
      public var obf_5_h_1671:Object;
      
      public var obf_l_a_2607:Object;
      
      public var obf_B_w_735:DataProvider;
      
      public var txtDeyAidMater:TextField;
      
      public var txtDeyChance:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var productPoint:MovieClip;
      
      public var txtDeyType:TextField;
      
      public var txtDeyLifeJobExp:TextField;
      
      public var assembleListPoint:MovieClip;
      
      public var assembleBar:MovieClip;
      
      public var txtLifeExp:TextField;
      
      public var txtDeyGoldCost:TextField;
      
      public var listType:ComboBox;
      
      public var txtAssist:TextField;
      
      public var scrollAssembleList:UIScrollBar;
      
      public function AssembleBoxUIMC()
      {
         super();
         obf_I_k_2601();
         __setProp_listType_assembleBoxUIMC_typeList_0();
         obf_x_M_3956();
         __setProp_cmdMakeButton_assembleBoxUIMC_button_0();
         __setProp_cmdCloseButton_assembleBoxUIMC_button_0();
         obf_H_t_3848();
      }
      
      internal function obf_I_k_2601() : *
      {
         try
         {
            scrollAssembleList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollAssembleList.direction = "vertical";
         scrollAssembleList.scrollTargetName = "bgBox";
         scrollAssembleList.visible = true;
         try
         {
            scrollAssembleList["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_t_3848() : *
      {
         try
         {
            chkEqualItem["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkEqualItem.enabled = true;
         chkEqualItem.label = "obf_________52";
         chkEqualItem.labelPlacement = "left";
         chkEqualItem.selected = false;
         chkEqualItem.visible = false;
         try
         {
            chkEqualItem["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdCloseButton_assembleBoxUIMC_button_0() : *
      {
         try
         {
            cmdCloseButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCloseButton.emphasized = false;
         cmdCloseButton.enabled = true;
         cmdCloseButton.label = "obf___4879";
         cmdCloseButton.labelPlacement = "right";
         cmdCloseButton.selected = false;
         cmdCloseButton.toggle = false;
         cmdCloseButton.visible = true;
         try
         {
            cmdCloseButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdMakeButton_assembleBoxUIMC_button_0() : *
      {
         try
         {
            cmdMakeButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdMakeButton.emphasized = false;
         cmdMakeButton.enabled = true;
         cmdMakeButton.label = "obf___4883";
         cmdMakeButton.labelPlacement = "right";
         cmdMakeButton.selected = false;
         cmdMakeButton.toggle = false;
         cmdMakeButton.visible = true;
         try
         {
            cmdMakeButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_listType_assembleBoxUIMC_typeList_0() : *
      {
         try
         {
            listType["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_B_w_735 = new DataProvider();
         obf_D_M_2040 = [];
         i17 = 0;
         while(i17 < obf_D_M_2040.length)
         {
            itemObj17 = new SimpleCollectionItem();
            obf_5_h_1671 = obf_D_M_2040[i17];
            for(obf_f_4_2076 in obf_5_h_1671)
            {
               itemObj17[obf_f_4_2076] = obf_5_h_1671[obf_f_4_2076];
            }
            obf_B_w_735.addItem(itemObj17);
            ++i17;
         }
         listType.dataProvider = obf_B_w_735;
         listType.editable = false;
         listType.enabled = true;
         listType.prompt = "";
         listType.restrict = "";
         listType.rowCount = 15;
         listType.visible = true;
         try
         {
            listType["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_x_M_3956() : *
      {
         try
         {
            listTopType["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_6_V_3795 = new DataProvider();
         obf_0_5_M_328 = [];
         i18 = 0;
         while(i18 < obf_0_5_M_328.length)
         {
            itemObj18 = new SimpleCollectionItem();
            obf_l_a_2607 = obf_0_5_M_328[i18];
            for(obf_6_x_1321 in obf_l_a_2607)
            {
               itemObj18[obf_6_x_1321] = obf_l_a_2607[obf_6_x_1321];
            }
            obf_6_V_3795.addItem(itemObj18);
            ++i18;
         }
         listTopType.dataProvider = obf_6_V_3795;
         listTopType.editable = false;
         listTopType.enabled = true;
         listTopType.prompt = "";
         listTopType.restrict = "";
         listTopType.rowCount = 15;
         listTopType.visible = true;
         try
         {
            listTopType["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

