package mmorpg
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol196")]
   public dynamic class ConfirmSmallBoxUI extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var cmdYes:MainButton;
      
      public var txtTip:TextField;
      
      public var cmdNo:MainButton;
      
      public var txtInfo:TextField;
      
      public function ConfirmSmallBoxUI()
      {
         super();
         obf_R_p_2797();
         obf_N_C_3743();
      }
      
      internal function obf_N_C_3743() : *
      {
         try
         {
            cmdNo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNo.emphasized = false;
         cmdNo.enabled = true;
         cmdNo.label = "obf__4986";
         cmdNo.labelPlacement = "right";
         cmdNo.selected = false;
         cmdNo.toggle = false;
         cmdNo.visible = true;
         try
         {
            cmdNo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_p_2797() : *
      {
         try
         {
            cmdYes["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdYes.emphasized = false;
         cmdYes.enabled = true;
         cmdYes.label = "obf__4984";
         cmdYes.labelPlacement = "right";
         cmdYes.selected = false;
         cmdYes.toggle = false;
         cmdYes.visible = true;
         try
         {
            cmdYes["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

