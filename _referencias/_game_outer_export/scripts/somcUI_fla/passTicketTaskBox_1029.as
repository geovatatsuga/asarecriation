package somcUI_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3402")]
   public dynamic class passTicketTaskBox_1029 extends MovieClip
   {
      
      public var cmdFinish:MainButton;
      
      public var txtName:TextField;
      
      public var txtExp:TextField;
      
      public function passTicketTaskBox_1029()
      {
         super();
         obf_c_l_2313();
      }
      
      internal function obf_c_l_2313() : *
      {
         try
         {
            cmdFinish["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFinish.emphasized = false;
         cmdFinish.enabled = true;
         cmdFinish.label = "Completed";
         cmdFinish.labelPlacement = "right";
         cmdFinish.selected = false;
         cmdFinish.toggle = false;
         cmdFinish.visible = true;
         try
         {
            cmdFinish["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

