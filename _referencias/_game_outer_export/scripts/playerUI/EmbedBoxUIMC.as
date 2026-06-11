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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4416")]
   public dynamic class EmbedBoxUIMC extends MovieClip
   {
      
      public var txtDeyGemType:TextField;
      
      public var txtChance:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDeyEquip:TextField;
      
      public var txtDeyPrompt:TextField;
      
      public var bagMaterial:IconBarMC;
      
      public var titleBox:MovieClip;
      
      public var bagEquip:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyMaterial:TextField;
      
      public var cmdAction:MainButton;
      
      public function EmbedBoxUIMC()
      {
         super();
         obf_5_z_2789();
      }
      
      internal function obf_5_z_2789() : *
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

