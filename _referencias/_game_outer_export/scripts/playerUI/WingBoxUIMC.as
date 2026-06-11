package playerUI
{
   import adobe.utils.*;
   import fl.controls.ComboBox;
   import fl.controls.UIScrollBar;
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
   import mcRes.AssembleLuckBox;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4089")]
   public dynamic class WingBoxUIMC extends MovieClip
   {
      
      public var txtDeyWingPrv:TextField;
      
      public var txtChance:TextField;
      
      public var cmdWingSpirit:MainButton;
      
      public var txtWingName:TextField;
      
      public var listWing:ComboBox;
      
      public var bgBox:MovieClip;
      
      public var bagMaterial:IconBarMC;
      
      public var obf_0_0_I_464:UIScrollBar;
      
      public var InstanceName_0:MovieClip;
      
      public var cmdAssWing:MainButton;
      
      public var titleBox:MovieClip;
      
      public var obf_Q_0_1896:AssembleLuckBox;
      
      public var txtDeyChance:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyMaterial:TextField;
      
      public var pointImage:MovieClip;
      
      public var txtWingAttr:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var bagTargetWing:IconBarMC;
      
      public var txtTargetWingName:TextField;
      
      public var bagWing:IconBarMC;
      
      public var txtDeyPrompt1:TextField;
      
      public function WingBoxUIMC()
      {
         super();
         obf_R_X_4186();
         obf_0_1_H_606();
         obf_0_8_Y_553();
      }
      
      internal function obf_0_1_H_606() : *
      {
         try
         {
            obf_0_0_I_464["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_0_0_I_464.direction = "vertical";
         obf_0_0_I_464.scrollTargetName = "txtWingAttr";
         obf_0_0_I_464.visible = true;
         try
         {
            obf_0_0_I_464["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_X_4186() : *
      {
         try
         {
            cmdAssWing["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAssWing.emphasized = false;
         cmdAssWing.enabled = true;
         cmdAssWing.label = "obf_____4765";
         cmdAssWing.labelPlacement = "right";
         cmdAssWing.selected = false;
         cmdAssWing.toggle = false;
         cmdAssWing.visible = true;
         try
         {
            cmdAssWing["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_Y_553() : *
      {
         try
         {
            cmdWingSpirit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdWingSpirit.emphasized = false;
         cmdWingSpirit.enabled = true;
         cmdWingSpirit.label = "obf_____4726";
         cmdWingSpirit.labelPlacement = "right";
         cmdWingSpirit.selected = false;
         cmdWingSpirit.toggle = false;
         cmdWingSpirit.visible = true;
         try
         {
            cmdWingSpirit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

