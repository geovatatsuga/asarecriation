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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol901")]
   public dynamic class ItemManualUIMC extends MovieClip
   {
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var obf_9_E_3210:*;
      
      public var txtAll:TextField;
      
      public var itemManualPic:MovieClip;
      
      public var obf_0___2_216:DataProvider;
      
      public var itemPoint:MovieClip;
      
      public var button0:SimpleButton;
      
      public var button1:SimpleButton;
      
      public var button2:SimpleButton;
      
      public var button3:SimpleButton;
      
      public var button4:SimpleButton;
      
      public var button5:SimpleButton;
      
      public var button6:SimpleButton;
      
      public var button7:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var cmdSummonTen:MainButton;
      
      public var itemIcon1:ItemManualIcon;
      
      public var itemIcon2:ItemManualIcon;
      
      public var itemIcon3:ItemManualIcon;
      
      public var itemIcon5:ItemManualIcon;
      
      public var itemIcon7:ItemManualIcon;
      
      public var itemIcon8:ItemManualIcon;
      
      public var itemIcon9:ItemManualIcon;
      
      public var itemIcon4:ItemManualIcon;
      
      public var itemIcon6:ItemManualIcon;
      
      public var itemIcon0:ItemManualIcon;
      
      public var itemPoint1:MovieClip;
      
      public var txtTen:TextField;
      
      public var obf_C_S_2277:Object;
      
      public var cmdSummonOne:MainButton;
      
      public var bgBox2:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var itemObj0:SimpleCollectionItem;
      
      public var bgBox1:MovieClip;
      
      public var obf_M_3_2848:Array;
      
      public var txtOne:TextField;
      
      public var icon0:IconBarMC;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var icon3:IconBarMC;
      
      public var icon4:IconBarMC;
      
      public var icon5:IconBarMC;
      
      public var icon6:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var icon8:IconBarMC;
      
      public var icon9:IconBarMC;
      
      public var icon7:IconBarMC;
      
      public var i0:int;
      
      public var listRank:ComboBox;
      
      public var itemManualTxt:TextField;
      
      public function ItemManualUIMC()
      {
         super();
         obf_K_H_2846();
         obf_A_5_3088();
         obf_s_k_3921();
      }
      
      internal function obf_s_k_3921() : *
      {
         try
         {
            listRank["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_0___2_216 = new DataProvider();
         obf_M_3_2848 = [];
         i0 = 0;
         while(i0 < obf_M_3_2848.length)
         {
            itemObj0 = new SimpleCollectionItem();
            obf_C_S_2277 = obf_M_3_2848[i0];
            for(obf_9_E_3210 in obf_C_S_2277)
            {
               itemObj0[obf_9_E_3210] = obf_C_S_2277[obf_9_E_3210];
            }
            obf_0___2_216.addItem(itemObj0);
            ++i0;
         }
         listRank.dataProvider = obf_0___2_216;
         listRank.editable = false;
         listRank.enabled = true;
         listRank.prompt = "";
         listRank.restrict = "";
         listRank.rowCount = 3;
         listRank.visible = true;
         try
         {
            listRank["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_5_3088() : *
      {
         try
         {
            cmdSummonTen["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSummonTen.emphasized = false;
         cmdSummonTen.enabled = true;
         cmdSummonTen.label = "obf___489510次";
         cmdSummonTen.labelPlacement = "right";
         cmdSummonTen.selected = false;
         cmdSummonTen.toggle = false;
         cmdSummonTen.visible = true;
         try
         {
            cmdSummonTen["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_K_H_2846() : *
      {
         try
         {
            cmdSummonOne["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSummonOne.emphasized = false;
         cmdSummonOne.enabled = true;
         cmdSummonOne.label = "obf___48951次";
         cmdSummonOne.labelPlacement = "right";
         cmdSummonOne.selected = false;
         cmdSummonOne.toggle = false;
         cmdSummonOne.visible = true;
         try
         {
            cmdSummonOne["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

