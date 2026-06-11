package somcUI_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4143")]
   public dynamic class mapNpcList_423 extends MovieClip
   {
      
      public var txtPort:TextField;
      
      public var scrollNpc:UIScrollBar;
      
      public var scrollPort:UIScrollBar;
      
      public var txtDeyDoor:TextField;
      
      public var txtDeyNPCList:TextField;
      
      public var txtList:TextField;
      
      public function mapNpcList_423()
      {
         super();
         obf_G_S_4134();
         obf_W_6_1451();
      }
      
      internal function obf_G_S_4134() : *
      {
         try
         {
            scrollNpc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollNpc.direction = "vertical";
         scrollNpc.scrollTargetName = "txtList";
         scrollNpc.visible = true;
         try
         {
            scrollNpc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_W_6_1451() : *
      {
         try
         {
            scrollPort["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollPort.direction = "vertical";
         scrollPort.scrollTargetName = "txtPort";
         scrollPort.visible = true;
         try
         {
            scrollPort["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

