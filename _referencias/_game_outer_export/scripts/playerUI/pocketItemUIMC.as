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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4431")]
   public dynamic class pocketItemUIMC extends MovieClip
   {
      
      public var txtAttrName1:TextField;
      
      public var txtAttrName3:TextField;
      
      public var cmdPre:MainButton;
      
      public var txtAttrName0:TextField;
      
      public var txtAttrName2:TextField;
      
      public var txtAttrName4:TextField;
      
      public var lockItem1:LockItemUIMC;
      
      public var lockItem2:LockItemUIMC;
      
      public var lockItem3:LockItemUIMC;
      
      public var lockItem4:LockItemUIMC;
      
      public var lockItem5:LockItemUIMC;
      
      public var lockItem6:LockItemUIMC;
      
      public var lockItem0:LockItemUIMC;
      
      public var txtPage:TextField;
      
      public var lockItem7:LockItemUIMC;
      
      public var txtAllAttr:TextField;
      
      public var txtAttrValue0:TextField;
      
      public var txtAttrValue1:TextField;
      
      public var txtAttrValue2:TextField;
      
      public var txtAttrValue3:TextField;
      
      public var txtAttrValue4:TextField;
      
      public var bg:MovieClip;
      
      public var txtTitle:TextField;
      
      public var cmdNext:MainButton;
      
      public var cmdRefinery:MainButton;
      
      public var titleBox:MovieClip;
      
      public var txtInfo:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function pocketItemUIMC()
      {
         super();
         obf_i_N_2179();
         obf_Q_I_1232();
         obf_l_z_3460();
      }
      
      internal function obf_i_N_2179() : *
      {
         try
         {
            cmdPre["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPre.emphasized = false;
         cmdPre.enabled = true;
         cmdPre.label = "obf____4858";
         cmdPre.labelPlacement = "right";
         cmdPre.selected = false;
         cmdPre.toggle = false;
         cmdPre.visible = true;
         try
         {
            cmdPre["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Q_I_1232() : *
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
         cmdNext.label = "obf____4854";
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
      
      internal function obf_l_z_3460() : *
      {
         try
         {
            cmdRefinery["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRefinery.emphasized = false;
         cmdRefinery.enabled = true;
         cmdRefinery.label = "obf___4970";
         cmdRefinery.labelPlacement = "right";
         cmdRefinery.selected = false;
         cmdRefinery.toggle = false;
         cmdRefinery.visible = true;
         try
         {
            cmdRefinery["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

