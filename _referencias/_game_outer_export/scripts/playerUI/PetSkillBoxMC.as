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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5249")]
   public dynamic class PetSkillBoxMC extends MovieClip
   {
      
      public var iconBar:IconBarMC;
      
      public var cmdReset:MainButton;
      
      public function PetSkillBoxMC()
      {
         super();
         obf_o_O_741();
      }
      
      internal function obf_o_O_741() : *
      {
         try
         {
            cmdReset["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReset.emphasized = false;
         cmdReset.enabled = true;
         cmdReset.label = "obf__4983";
         cmdReset.labelPlacement = "right";
         cmdReset.selected = false;
         cmdReset.toggle = false;
         cmdReset.visible = true;
         try
         {
            cmdReset["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

