package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4483")]
   public dynamic class AgentUIMC extends MovieClip
   {
      
      public var i22:int;
      
      public var cmdSearch:MainButton;
      
      public var inputCopper:MJInput;
      
      public var sellTotleGoldPoint:MovieClip;
      
      public var collProps22:Array;
      
      public var inputSearch:MJInput;
      
      public var cmdNextPage:MainButton;
      
      public var txtPage:TextField;
      
      public var mySellPoint:MovieClip;
      
      public var itemObj21:SimpleCollectionItem;
      
      public var obf_i_m_p_o_r_t_50:*;
      
      public var obf_a_n_4104:Array;
      
      public var cmdSell:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var j22:*;
      
      public var obf_C_9_2232:ComboBox;
      
      public var txtDeySellTotleGold:TextField;
      
      public var scrollItemList:UIScrollBar;
      
      public var itemListPoint:MovieClip;
      
      public var txtDeyMySell:TextField;
      
      public var cmdPrvPage:MainButton;
      
      public var inputGold:MJInput;
      
      public var obf_5_A_3345:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var txtDeySearch:TextField;
      
      public var itemObj22:SimpleCollectionItem;
      
      public var txtDeySubtype:TextField;
      
      public var comboBoxSubtype:ComboBox;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeySellSingleGold:TextField;
      
      public var txtDeyType:TextField;
      
      public var obf_9_M_2815:DataProvider;
      
      public var collObj22:DataProvider;
      
      public var cmdBuy:MainButton;
      
      public var i21:int;
      
      public var collProp22:Object;
      
      public var inputSilver:MJInput;
      
      public var inputSellDiamond:MJInput;
      
      public var bagSell:IconBarMC;
      
      public var obf_d_T_4468:Object;
      
      public var txtDeySellPrompt:TextField;
      
      public function AgentUIMC()
      {
         super();
         obf_4_0_4521();
         obf_u_E_3444();
         obf_u_5_2717();
         obf_4_1_1658();
         obf_U_d_4246();
         obf_b_g_1497();
         obf_S_W_2649();
         obf_Q_N_4357();
         obf_a_x_1682();
         obf_P_a_1142();
         obf_d_V_2985();
      }
      
      internal function obf_d_V_2985() : *
      {
         try
         {
            cmdBuy["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuy.emphasized = false;
         cmdBuy.enabled = true;
         cmdBuy.label = "obf_____4825";
         cmdBuy.labelPlacement = "right";
         cmdBuy.selected = false;
         cmdBuy.toggle = false;
         cmdBuy.visible = true;
         try
         {
            cmdBuy["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_1_1658() : *
      {
         try
         {
            inputSilver["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputSilver.displayAsPassword = false;
         inputSilver.editable = true;
         inputSilver.enabled = true;
         inputSilver.maxChars = 2;
         inputSilver.restrict = "0-9";
         inputSilver.text = "";
         inputSilver.visible = true;
         try
         {
            inputSilver["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_U_d_4246() : *
      {
         try
         {
            inputCopper["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputCopper.displayAsPassword = false;
         inputCopper.editable = true;
         inputCopper.enabled = true;
         inputCopper.maxChars = 2;
         inputCopper.restrict = "0-9";
         inputCopper.text = "";
         inputCopper.visible = true;
         try
         {
            inputCopper["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_0_4521() : *
      {
         try
         {
            cmdSell["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSell.emphasized = false;
         cmdSell.enabled = true;
         cmdSell.label = "obf_____4822";
         cmdSell.labelPlacement = "right";
         cmdSell.selected = false;
         cmdSell.toggle = false;
         cmdSell.visible = true;
         try
         {
            cmdSell["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_E_3444() : *
      {
         try
         {
            inputSellDiamond["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputSellDiamond.displayAsPassword = false;
         inputSellDiamond.editable = true;
         inputSellDiamond.enabled = true;
         inputSellDiamond.maxChars = 3;
         inputSellDiamond.restrict = "0-9";
         inputSellDiamond.text = "";
         inputSellDiamond.visible = true;
         try
         {
            inputSellDiamond["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_S_W_2649() : *
      {
         try
         {
            comboBoxSubtype["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         collObj22 = new DataProvider();
         collProps22 = [];
         i22 = 0;
         while(i22 < collProps22.length)
         {
            itemObj22 = new SimpleCollectionItem();
            collProp22 = collProps22[i22];
            for(j22 in collProp22)
            {
               itemObj22[j22] = collProp22[j22];
            }
            collObj22.addItem(itemObj22);
            ++i22;
         }
         comboBoxSubtype.dataProvider = collObj22;
         comboBoxSubtype.editable = false;
         comboBoxSubtype.enabled = true;
         comboBoxSubtype.prompt = "";
         comboBoxSubtype.restrict = "";
         comboBoxSubtype.rowCount = 10;
         comboBoxSubtype.visible = true;
         try
         {
            comboBoxSubtype["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_g_1497() : *
      {
         try
         {
            obf_C_9_2232["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_9_M_2815 = new DataProvider();
         obf_a_n_4104 = [];
         i21 = 0;
         while(i21 < obf_a_n_4104.length)
         {
            itemObj21 = new SimpleCollectionItem();
            obf_d_T_4468 = obf_a_n_4104[i21];
            for(obf_i_m_p_o_r_t_50 in obf_d_T_4468)
            {
               itemObj21[obf_i_m_p_o_r_t_50] = obf_d_T_4468[obf_i_m_p_o_r_t_50];
            }
            obf_9_M_2815.addItem(itemObj21);
            ++i21;
         }
         obf_C_9_2232.dataProvider = obf_9_M_2815;
         obf_C_9_2232.editable = false;
         obf_C_9_2232.enabled = true;
         obf_C_9_2232.prompt = "";
         obf_C_9_2232.restrict = "";
         obf_C_9_2232.rowCount = 10;
         obf_C_9_2232.visible = true;
         try
         {
            obf_C_9_2232["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_5_2717() : *
      {
         try
         {
            inputGold["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputGold.displayAsPassword = false;
         inputGold.editable = true;
         inputGold.enabled = true;
         inputGold.maxChars = 2;
         inputGold.restrict = "0-9";
         inputGold.text = "";
         inputGold.visible = true;
         try
         {
            inputGold["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Q_N_4357() : *
      {
         try
         {
            cmdSearch["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSearch.emphasized = false;
         cmdSearch.enabled = true;
         cmdSearch.label = "obf___4941";
         cmdSearch.labelPlacement = "right";
         cmdSearch.selected = false;
         cmdSearch.toggle = false;
         cmdSearch.visible = true;
         try
         {
            cmdSearch["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_P_a_1142() : *
      {
         try
         {
            cmdNextPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNextPage.emphasized = false;
         cmdNextPage.enabled = true;
         cmdNextPage.label = ">";
         cmdNextPage.labelPlacement = "right";
         cmdNextPage.selected = false;
         cmdNextPage.toggle = false;
         cmdNextPage.visible = true;
         try
         {
            cmdNextPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_a_x_1682() : *
      {
         try
         {
            cmdPrvPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrvPage.emphasized = false;
         cmdPrvPage.enabled = true;
         cmdPrvPage.label = "<";
         cmdPrvPage.labelPlacement = "right";
         cmdPrvPage.selected = false;
         cmdPrvPage.toggle = false;
         cmdPrvPage.visible = true;
         try
         {
            cmdPrvPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

