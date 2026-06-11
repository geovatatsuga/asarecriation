package playerUI
{
   import adobe.utils.*;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol488")]
   public dynamic class SoulWeaponEmbedUIMC extends MovieClip
   {
      
      public var obf_i_o_2596:UIScrollBar;
      
      public var txtChance:TextField;
      
      public var bagEquip:IconBarMC;
      
      public var pointGold:MovieClip;
      
      public var txtDeyPrompt:TextField;
      
      public var txtDeyGold:TextField;
      
      public var bagMaterial:IconBarMC;
      
      public var cmdAction:MainButton;
      
      public var txtDeyGroup:TextField;
      
      public var txtDeyGroupPrompt:TextField;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var txtDeyMaterial:TextField;
      
      public var txtDeyEquip:TextField;
      
      public function SoulWeaponEmbedUIMC()
      {
         super();
         obf_Z_c_2760();
         obf_9_m_1193();
      }
      
      internal function obf_Z_c_2760() : *
      {
         try
         {
            obf_i_o_2596["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_i_o_2596.direction = "vertical";
         obf_i_o_2596.scrollTargetName = "txtDeyGroupPrompt";
         obf_i_o_2596.visible = true;
         try
         {
            obf_i_o_2596["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_9_m_1193() : *
      {
         try
         {
            cmdAction["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAction.emphasized = false;
         cmdAction.enabled = true;
         cmdAction.label = "obf___4982";
         cmdAction.labelPlacement = "right";
         cmdAction.selected = false;
         cmdAction.toggle = false;
         cmdAction.visible = true;
         try
         {
            cmdAction["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

