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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4748")]
   public dynamic class EquipmentFastApplyUIMC extends MovieClip
   {
      
      public var cmdClose:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var bagEquip:IconBarMC;
      
      public var cmdEquipment:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var txtEquipment:TextField;
      
      public function EquipmentFastApplyUIMC()
      {
         super();
         obf_A_i_1305();
      }
      
      internal function obf_A_i_1305() : *
      {
         try
         {
            cmdEquipment["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEquipment.emphasized = false;
         cmdEquipment.enabled = true;
         cmdEquipment.label = "obf______4678";
         cmdEquipment.labelPlacement = "right";
         cmdEquipment.selected = false;
         cmdEquipment.toggle = false;
         cmdEquipment.visible = true;
         try
         {
            cmdEquipment["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

