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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol334")]
   public dynamic class TreeBoxUIMC extends MovieClip
   {
      
      public var cmdUpRank:MainButton;
      
      public var bg:MovieClip;
      
      public var pointTree:MovieClip;
      
      public var txtCost:TextField;
      
      public var txtLvAttr0:TextField;
      
      public var txtLvAttr1:TextField;
      
      public var txtLvAttr2:TextField;
      
      public var txtLvAttr3:TextField;
      
      public var txtLvAttr4:TextField;
      
      public var txtLvAttr5:TextField;
      
      public var txtLvAttr6:TextField;
      
      public var txtLvAttr8:TextField;
      
      public var txtLvAttr7:TextField;
      
      public var icon:IconBarMC;
      
      public var txtRaValue0:TextField;
      
      public var txtRaValue1:TextField;
      
      public var txtRaValue2:TextField;
      
      public var txtRaValue3:TextField;
      
      public var txtRaValue5:TextField;
      
      public var txtRaValue6:TextField;
      
      public var txtRaValue7:TextField;
      
      public var txtRaValue8:TextField;
      
      public var txtRaValue4:TextField;
      
      public var txtExp:TextField;
      
      public var cmdAddExp:MainButton;
      
      public var txtLvValue0:TextField;
      
      public var txtLvValue1:TextField;
      
      public var txtLvValue2:TextField;
      
      public var txtLvValue3:TextField;
      
      public var txtLvValue4:TextField;
      
      public var txtLvValue5:TextField;
      
      public var txtLvValue6:TextField;
      
      public var txtLvValue7:TextField;
      
      public var txtLvValue8:TextField;
      
      public var expBar:MovieClip;
      
      public var txtRank:TextField;
      
      public var txtTitle:TextField;
      
      public var txtTreeName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtRaAttr0:TextField;
      
      public var txtRaAttr1:TextField;
      
      public var txtRaAttr2:TextField;
      
      public var txtRaAttr3:TextField;
      
      public var txtRaAttr4:TextField;
      
      public var txtRaAttr6:TextField;
      
      public var txtRaAttr7:TextField;
      
      public var txtRaAttr5:TextField;
      
      public var cmdGetItem:MainButton;
      
      public var txtLevel:TextField;
      
      public var txtRaAttr8:TextField;
      
      public var txtTreeInfo:TextField;
      
      public function TreeBoxUIMC()
      {
         super();
         obf_0_5_E_655();
         obf_s_C_4237();
         obf_0_J_1420();
      }
      
      internal function obf_0_5_E_655() : *
      {
         try
         {
            cmdAddExp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAddExp.emphasized = false;
         cmdAddExp.enabled = true;
         cmdAddExp.label = " obf_____4771";
         cmdAddExp.labelPlacement = "right";
         cmdAddExp.selected = false;
         cmdAddExp.toggle = false;
         cmdAddExp.visible = true;
         try
         {
            cmdAddExp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_J_1420() : *
      {
         try
         {
            cmdGetItem["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGetItem.emphasized = false;
         cmdGetItem.enabled = true;
         cmdGetItem.label = "obf_____4831";
         cmdGetItem.labelPlacement = "right";
         cmdGetItem.selected = false;
         cmdGetItem.toggle = false;
         cmdGetItem.visible = true;
         try
         {
            cmdGetItem["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_C_4237() : *
      {
         try
         {
            cmdUpRank["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpRank.emphasized = false;
         cmdUpRank.enabled = true;
         cmdUpRank.label = "obf_____4785";
         cmdUpRank.labelPlacement = "right";
         cmdUpRank.selected = false;
         cmdUpRank.toggle = false;
         cmdUpRank.visible = true;
         try
         {
            cmdUpRank["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

