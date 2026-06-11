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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol200")]
   public dynamic class ConfirmBoxUI extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtTip:TextField;
      
      public var cmdYes:MainButton;
      
      public var pointDisplay:MovieClip;
      
      public var cmdNo:MainButton;
      
      public var txtInfo:TextField;
      
      public function ConfirmBoxUI()
      {
         super();
         __setProp_cmdYes_ConfirmBoxUI_();
         __setProp_cmdNo_ConfirmBoxUI_();
      }
      
      internal function __setProp_cmdNo_ConfirmBoxUI_() : *
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
      
      internal function __setProp_cmdYes_ConfirmBoxUI_() : *
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

