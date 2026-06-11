package mmorpg
{
   import adobe.utils.*;
   import fl.controls.ComboBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol171")]
   public dynamic class InputBoxUI extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var cmdOK:MainButton;
      
      public var cmdCancel:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var inputBox:ComboBox;
      
      public var itemObj23:SimpleCollectionItem;
      
      public var i23:int;
      
      public var obf_9_l_4603:*;
      
      public var obf_e_B_3625:DataProvider;
      
      public var txtDeyTitle:TextField;
      
      public var txtPrompt:TextField;
      
      public var obf_y_9_4343:Object;
      
      public var obf_8_M_2217:Array;
      
      public function InputBoxUI()
      {
         super();
         obf_0_4_w_396();
         obf_0_4_H_731();
         obf_I_2_4049();
      }
      
      internal function obf_0_4_w_396() : *
      {
         try
         {
            inputBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_e_B_3625 = new DataProvider();
         obf_8_M_2217 = [];
         i23 = 0;
         while(i23 < obf_8_M_2217.length)
         {
            itemObj23 = new SimpleCollectionItem();
            obf_y_9_4343 = obf_8_M_2217[i23];
            for(obf_9_l_4603 in obf_y_9_4343)
            {
               itemObj23[obf_9_l_4603] = obf_y_9_4343[obf_9_l_4603];
            }
            obf_e_B_3625.addItem(itemObj23);
            ++i23;
         }
         inputBox.dataProvider = obf_e_B_3625;
         inputBox.editable = true;
         inputBox.enabled = true;
         inputBox.prompt = "";
         inputBox.restrict = "";
         inputBox.rowCount = 5;
         inputBox.visible = true;
         try
         {
            inputBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_H_731() : *
      {
         try
         {
            cmdOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOK.emphasized = false;
         cmdOK.enabled = true;
         cmdOK.label = "obf___4891";
         cmdOK.labelPlacement = "right";
         cmdOK.selected = false;
         cmdOK.toggle = false;
         cmdOK.visible = true;
         try
         {
            cmdOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_I_2_4049() : *
      {
         try
         {
            cmdCancel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancel.emphasized = false;
         cmdCancel.enabled = true;
         cmdCancel.label = "obf___4932";
         cmdCancel.labelPlacement = "right";
         cmdCancel.selected = false;
         cmdCancel.toggle = false;
         cmdCancel.visible = true;
         try
         {
            cmdCancel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

