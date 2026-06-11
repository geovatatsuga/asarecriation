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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4745")]
   public dynamic class PlayerAttrFastApplyUIMC extends MovieClip
   {
      
      public var cmdAgiAddAllPoint:SimpleButton;
      
      public var txtAttrPoint:TextField;
      
      public var cmdVitAddPoint:SimpleButton;
      
      public var cmdStrAddAllPoint:SimpleButton;
      
      public var cmdOK:MainButton;
      
      public var txtDeyAgility:TextField;
      
      public var cmdWisRemovePoint:SimpleButton;
      
      public var cmdStrAddPoint:SimpleButton;
      
      public var cmdVitAddAllPoint:SimpleButton;
      
      public var txtAgility:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var cmdAgiRemovePoint:SimpleButton;
      
      public var cmdPointAuto:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyStamina:TextField;
      
      public var cmdWigAddPoint:SimpleButton;
      
      public var cmdStrRemovePoint:SimpleButton;
      
      public var txtDeyIntellect:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtStamina:TextField;
      
      public var txtStrength:TextField;
      
      public var cmdVitRemovePoint:SimpleButton;
      
      public var cmdWisAddAllPoint:SimpleButton;
      
      public var txtDeyStrength:TextField;
      
      public var cmdAgiAddPoint:SimpleButton;
      
      public var txtDeyAttrPoint:TextField;
      
      public var txtIntellect:TextField;
      
      public function PlayerAttrFastApplyUIMC()
      {
         super();
         obf_z_G_3042();
         obf_c_0_1062();
      }
      
      internal function obf_z_G_3042() : *
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
      
      internal function obf_c_0_1062() : *
      {
         try
         {
            cmdPointAuto["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPointAuto.emphasized = false;
         cmdPointAuto.enabled = true;
         cmdPointAuto.label = "obf___4948";
         cmdPointAuto.labelPlacement = "right";
         cmdPointAuto.selected = false;
         cmdPointAuto.toggle = false;
         cmdPointAuto.visible = true;
         try
         {
            cmdPointAuto["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

