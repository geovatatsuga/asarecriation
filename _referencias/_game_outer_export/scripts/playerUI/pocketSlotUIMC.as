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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3348")]
   public dynamic class pocketSlotUIMC extends MovieClip
   {
      
      public var txtAttrName1:TextField;
      
      public var txtAttrName3:TextField;
      
      public var txtLockInfo:TextField;
      
      public var slot10:SlotUIMC;
      
      public var slot11:SlotUIMC;
      
      public var slot12:SlotUIMC;
      
      public var slot13:SlotUIMC;
      
      public var slot14:SlotUIMC;
      
      public var txtAllAttr:TextField;
      
      public var txtAttrName2:TextField;
      
      public var slot15:SlotUIMC;
      
      public var cmdAssemble:MainButton;
      
      public var txtAttrName0:TextField;
      
      public var slot9:SlotUIMC;
      
      public var txtThisAttr:TextField;
      
      public var txtAttrValue0:TextField;
      
      public var txtAttrValue1:TextField;
      
      public var txtNextName0:TextField;
      
      public var txtNextName1:TextField;
      
      public var txtNextName2:TextField;
      
      public var txtNextName3:TextField;
      
      public var txtNextName4:TextField;
      
      public var txtNextName5:TextField;
      
      public var txtTitle:TextField;
      
      public var txtAttrValue2:TextField;
      
      public var txtAttrValue3:TextField;
      
      public var bg:MovieClip;
      
      public var txtInfo:TextField;
      
      public var txtNextValue5:TextField;
      
      public var txtNextValue1:TextField;
      
      public var txtNextValue3:TextField;
      
      public var txtNextValue4:TextField;
      
      public var txtNextValue0:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var txtLvInfo:TextField;
      
      public var txtNextValue2:TextField;
      
      public var slot0:SlotUIMC;
      
      public var slot1:SlotUIMC;
      
      public var slot2:SlotUIMC;
      
      public var slot3:SlotUIMC;
      
      public var slot4:SlotUIMC;
      
      public var slot5:SlotUIMC;
      
      public var slot6:SlotUIMC;
      
      public var slot7:SlotUIMC;
      
      public var slot8:SlotUIMC;
      
      public var cmdPocket:MainButton;
      
      public function pocketSlotUIMC()
      {
         super();
         obf_V_0_1455();
         obf_0_4_a_639();
      }
      
      internal function obf_0_4_a_639() : *
      {
         try
         {
            cmdAssemble["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAssemble.emphasized = false;
         cmdAssemble.enabled = true;
         cmdAssemble.label = "obf___4883";
         cmdAssemble.labelPlacement = "right";
         cmdAssemble.selected = false;
         cmdAssemble.toggle = false;
         cmdAssemble.visible = true;
         try
         {
            cmdAssemble["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_0_1455() : *
      {
         try
         {
            cmdPocket["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPocket.emphasized = false;
         cmdPocket.enabled = true;
         cmdPocket.label = "obf_____4804";
         cmdPocket.labelPlacement = "right";
         cmdPocket.selected = false;
         cmdPocket.toggle = false;
         cmdPocket.visible = true;
         try
         {
            cmdPocket["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

