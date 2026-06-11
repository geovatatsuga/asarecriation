package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3967")]
   public dynamic class GameInfoUIMC extends MovieClip
   {
      
      public var cmdSendPrivate:MovieClip;
      
      public var faceBox:MovieClip;
      
      public var txtDeySendWorld:TextField;
      
      public var txtDeySendWorldTV:TextField;
      
      public var txtDeySendNearby:TextField;
      
      public var cmdSendWorld:MovieClip;
      
      public var txtInput:MJInput;
      
      public var contentLayer:MovieClip;
      
      public var worldBox:MovieClip;
      
      public var cmdSendTeam:MovieClip;
      
      public var cmdSendFamily:MovieClip;
      
      public var txtDeySendTeam:TextField;
      
      public var cmdSendNomal:MovieClip;
      
      public var cmdFace:SimpleButton;
      
      public var txtDeySendWhisper:TextField;
      
      public var txtDeySendFamily:TextField;
      
      public var cmdSendSpeaker:MovieClip;
      
      public var cmdEnter:SimpleButton;
      
      public function GameInfoUIMC()
      {
         super();
         __setProp_txtInput_gameInfoUI_txtInput_0();
      }
      
      internal function __setProp_txtInput_gameInfoUI_txtInput_0() : *
      {
         try
         {
            txtInput["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtInput.displayAsPassword = false;
         txtInput.editable = true;
         txtInput.enabled = true;
         txtInput.maxChars = 180;
         txtInput.restrict = "";
         txtInput.text = "";
         txtInput.visible = true;
         try
         {
            txtInput["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

