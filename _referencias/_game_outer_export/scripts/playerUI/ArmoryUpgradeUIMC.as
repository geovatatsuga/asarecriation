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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4289")]
   public dynamic class ArmoryUpgradeUIMC extends MovieClip
   {
      
      public var txtExp:TextField;
      
      public var mbag0:iconBarNen;
      
      public var mbag1:iconBarNen;
      
      public var mbag2:iconBarNen;
      
      public var mbag3:iconBarNen;
      
      public var mbag4:iconBarNen;
      
      public var mbag6:iconBarNen;
      
      public var mbag7:iconBarNen;
      
      public var mbag8:IconBarKill;
      
      public var mbag9:IconBarKill;
      
      public var btnUpgrade:MainButton;
      
      public var mbag5:iconBarNen;
      
      public var tipButton:MainButton;
      
      public var expBar:MovieClip;
      
      public var moneyPoint:MovieClip;
      
      public var txtNeedMoney:TextField;
      
      public var bagMaterial1:IconBarMC;
      
      public var bagMaterial2:IconBarMC;
      
      public var txtNeedMagicInt:TextField;
      
      public var txtArmoryName:TextField;
      
      public var mbag11:IconBarKill;
      
      public var mbag12:iconBarCom;
      
      public var mbag10:IconBarKill;
      
      public var txtUpgradeExp:TextField;
      
      public function ArmoryUpgradeUIMC()
      {
         super();
         obf_g_Y_3877();
         obf_E_c_3719();
      }
      
      internal function obf_E_c_3719() : *
      {
         try
         {
            btnUpgrade["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         btnUpgrade.emphasized = false;
         btnUpgrade.enabled = true;
         btnUpgrade.label = "obf___4963";
         btnUpgrade.labelPlacement = "right";
         btnUpgrade.selected = false;
         btnUpgrade.toggle = false;
         btnUpgrade.visible = true;
         try
         {
            btnUpgrade["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_g_Y_3877() : *
      {
         try
         {
            tipButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         tipButton.emphasized = false;
         tipButton.enabled = true;
         tipButton.label = "obf_________48";
         tipButton.labelPlacement = "right";
         tipButton.selected = false;
         tipButton.toggle = false;
         tipButton.visible = true;
         try
         {
            tipButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

