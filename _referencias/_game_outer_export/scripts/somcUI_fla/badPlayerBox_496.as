package somcUI_fla
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol342")]
   public dynamic class badPlayerBox_496 extends MovieClip
   {
      
      public var txtDeyTitle:TextField;
      
      public var cmdDel:MainButton;
      
      public var listBadPlayer:MJList;
      
      public function badPlayerBox_496()
      {
         super();
         obf_a_u_1370();
      }
      
      internal function obf_a_u_1370() : *
      {
         try
         {
            cmdDel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDel.emphasized = false;
         cmdDel.enabled = true;
         cmdDel.label = "obf_____4767";
         cmdDel.labelPlacement = "right";
         cmdDel.selected = false;
         cmdDel.toggle = false;
         cmdDel.visible = true;
         try
         {
            cmdDel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

