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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4146")]
   public dynamic class MapUIMC extends MovieClip
   {
      
      public var txtLocation:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtMapName:TextField;
      
      public var cmdWorld:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var npcList:MovieClip;
      
      public function MapUIMC()
      {
         super();
         __setProp_cmdWorld_mapUI_title_0();
      }
      
      internal function __setProp_cmdWorld_mapUI_title_0() : *
      {
         try
         {
            cmdWorld["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdWorld.emphasized = false;
         cmdWorld.enabled = true;
         cmdWorld.label = "obf_____4827";
         cmdWorld.labelPlacement = "right";
         cmdWorld.selected = false;
         cmdWorld.toggle = false;
         cmdWorld.visible = true;
         try
         {
            cmdWorld["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

