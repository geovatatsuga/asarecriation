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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4435")]
   public dynamic class SoulWeaponAssembleUIMC extends MovieClip
   {
      
      public var bagMaterial0:IconBarMC;
      
      public var bagMaterial1:IconBarMC;
      
      public var bagMaterial2:IconBarMC;
      
      public var bagMaterial3:IconBarMC;
      
      public var bagMaterial4:IconBarMC;
      
      public var txtAssembleSoulAttr:TextField;
      
      public var txtDeyGold:TextField;
      
      public var txtDeyAssembleMaterial:TextField;
      
      public var txtSoulAttr:TextField;
      
      public var pointGold:MovieClip;
      
      public var bagSoul:IconBarMC;
      
      public var bagAssembleSoul:IconBarMC;
      
      public var cmdSoulWeaponAssemble:MainButton;
      
      public function SoulWeaponAssembleUIMC()
      {
         super();
         obf_I_b_1266();
      }
      
      internal function obf_I_b_1266() : *
      {
         try
         {
            cmdSoulWeaponAssemble["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSoulWeaponAssemble.emphasized = false;
         cmdSoulWeaponAssemble.enabled = true;
         cmdSoulWeaponAssemble.label = "obf_____4718";
         cmdSoulWeaponAssemble.labelPlacement = "right";
         cmdSoulWeaponAssemble.selected = false;
         cmdSoulWeaponAssemble.toggle = false;
         cmdSoulWeaponAssemble.visible = true;
         try
         {
            cmdSoulWeaponAssemble["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

