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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3367")]
   public dynamic class ArmoryComposeUIMC extends MovieClip
   {
      
      public var txtSuccess:TextField;
      
      public var i7:int;
      
      public var obf_1_C_3198:*;
      
      public var txtMainMaterial:TextField;
      
      public var mbag0:IconBarMC;
      
      public var mbag1:IconBarMC;
      
      public var mbag2:IconBarMC;
      
      public var mbag3:IconBarMC;
      
      public var mbag4:IconBarMC;
      
      public var txtSafe:TextField;
      
      public var btnProductCompose:MainButton;
      
      public var mbag5:IconBarMC;
      
      public var obf_9_F_3722:Object;
      
      public var bagSafe:IconBarMC;
      
      public var txtMaterial:TextField;
      
      public var obf_3_I_2471:DataProvider;
      
      public var bagTally:IconBarMC;
      
      public var bagProduct:IconBarMC;
      
      public var txtFailed:TextField;
      
      public var bagMaterial:IconBarMC;
      
      public var itemObj7:SimpleCollectionItem;
      
      public var txttallylevelInfo:TextField;
      
      public var btnTallyUpdate:MainButton;
      
      public var obf_0_7_Y_330:Array;
      
      public var bagSuccess:IconBarMC;
      
      public var txtTally:TextField;
      
      public var txtProduct:TextField;
      
      public var assembleBar:MovieClip;
      
      public var txtDeyType:TextField;
      
      public var bagFailed:IconBarMC;
      
      public var txtProductRate:TextField;
      
      public var txtSuccessRate:TextField;
      
      public var listType:ComboBox;
      
      public var scrolltallyList:UIScrollBar;
      
      public var typeListPoint:MovieClip;
      
      public function ArmoryComposeUIMC()
      {
         super();
         obf_e_M_1116();
         obf_0_5_q_317();
         obf_P_V_4542();
      }
      
      internal function obf_e_M_1116() : *
      {
         try
         {
            btnTallyUpdate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         btnTallyUpdate.emphasized = false;
         btnTallyUpdate.enabled = true;
         btnTallyUpdate.label = "obf___4883";
         btnTallyUpdate.labelPlacement = "right";
         btnTallyUpdate.selected = false;
         btnTallyUpdate.toggle = false;
         btnTallyUpdate.visible = true;
         try
         {
            btnTallyUpdate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_P_V_4542() : *
      {
         try
         {
            btnProductCompose["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         btnProductCompose.emphasized = false;
         btnProductCompose.enabled = true;
         btnProductCompose.label = "obf___4883";
         btnProductCompose.labelPlacement = "right";
         btnProductCompose.selected = false;
         btnProductCompose.toggle = false;
         btnProductCompose.visible = true;
         try
         {
            btnProductCompose["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_q_317() : *
      {
         try
         {
            listType["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_3_I_2471 = new DataProvider();
         obf_0_7_Y_330 = [];
         i7 = 0;
         while(i7 < obf_0_7_Y_330.length)
         {
            itemObj7 = new SimpleCollectionItem();
            obf_9_F_3722 = obf_0_7_Y_330[i7];
            for(obf_1_C_3198 in obf_9_F_3722)
            {
               itemObj7[obf_1_C_3198] = obf_9_F_3722[obf_1_C_3198];
            }
            obf_3_I_2471.addItem(itemObj7);
            ++i7;
         }
         listType.dataProvider = obf_3_I_2471;
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
   }
}

