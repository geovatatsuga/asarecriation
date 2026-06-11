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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4727")]
   public dynamic class SoulWeaponLevelUpUIMC extends MovieClip
   {
      
      public var txtLevelUpAttr:TextField;
      
      public var txtDeySp:TextField;
      
      public var txtDeyLevelUpExp:TextField;
      
      public var barExp:MovieClip;
      
      public var bagM0:IconBarMC;
      
      public var txtExp:TextField;
      
      public var bagM1:IconBarMC;
      
      public var bagM2:IconBarMC;
      
      public var txtDeyLevelUpMaterial:TextField;
      
      public var txtDeyCurrentAttr:TextField;
      
      public var cmdLevelUp:MainButton;
      
      public var txtDeyLevelUpAttr:TextField;
      
      public var txtSp:TextField;
      
      public var txtDeyCurrentLevel:TextField;
      
      public var bagCurrentSW:IconBarMC;
      
      public var txtCurrentAttr:TextField;
      
      public function SoulWeaponLevelUpUIMC()
      {
         super();
         obf_z_r_3606();
      }
      
      internal function obf_z_r_3606() : *
      {
         try
         {
            cmdLevelUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLevelUp.emphasized = false;
         cmdLevelUp.enabled = true;
         cmdLevelUp.label = "obf___4963";
         cmdLevelUp.labelPlacement = "right";
         cmdLevelUp.selected = false;
         cmdLevelUp.toggle = false;
         cmdLevelUp.visible = true;
         try
         {
            cmdLevelUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

