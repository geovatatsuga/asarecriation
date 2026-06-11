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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol302")]
   public dynamic class NPCTalkBoxUIMC extends MovieClip
   {
      
      public var playerImage:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var menuContent:MovieClip;
      
      public var talkContentScroll:UIScrollBar;
      
      public var txtNPCName:TextField;
      
      public var npcImage:MovieClip;
      
      public var txtTalkContent:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function NPCTalkBoxUIMC()
      {
         super();
         __setProp_talkContentScroll_NPCTalkBox_txt_0();
      }
      
      internal function __setProp_talkContentScroll_NPCTalkBox_txt_0() : *
      {
         try
         {
            talkContentScroll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         talkContentScroll.direction = "vertical";
         talkContentScroll.scrollTargetName = "txtTalkContent";
         talkContentScroll.visible = true;
         try
         {
            talkContentScroll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

