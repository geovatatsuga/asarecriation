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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3771")]
   public dynamic class TaskTracerUIMC extends MovieClip
   {
      
      public var cmdHaveTask:TableButton;
      
      public var txtCanReceiveTask:TextField;
      
      public var obf_7_V_796:TextField;
      
      public var scrollTask:UIScrollBar;
      
      public var titleBox:MovieClip;
      
      public var pointTask:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdCanReceiveTask:TableButton;
      
      public var obf_4_a_3279:UIScrollBar;
      
      public function TaskTracerUIMC()
      {
         super();
         obf_1_W_862();
      }
      
      internal function obf_1_W_862() : *
      {
         try
         {
            obf_4_a_3279["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_4_a_3279.direction = "vertical";
         obf_4_a_3279.scrollTargetName = "txtCanReceiveTask";
         obf_4_a_3279.visible = true;
         try
         {
            obf_4_a_3279["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

