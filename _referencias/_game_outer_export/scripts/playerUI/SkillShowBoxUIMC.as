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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol776")]
   public dynamic class SkillShowBoxUIMC extends MovieClip
   {
      
      public var cmdUp:SimpleButton;
      
      public var cmdOperation:MainButton;
      
      public var iconBag:IconBarMC;
      
      public function SkillShowBoxUIMC()
      {
         super();
         obf_B_e_1410();
      }
      
      internal function obf_B_e_1410() : *
      {
         try
         {
            cmdOperation["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOperation.emphasized = false;
         cmdOperation.enabled = true;
         cmdOperation.label = "obf___4905";
         cmdOperation.labelPlacement = "right";
         cmdOperation.selected = false;
         cmdOperation.toggle = false;
         cmdOperation.visible = false;
         try
         {
            cmdOperation["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

