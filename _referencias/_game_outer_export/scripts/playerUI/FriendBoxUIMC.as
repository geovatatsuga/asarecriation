package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol360")]
   public dynamic class FriendBoxUIMC extends MovieClip
   {
      
      public var txtFriendCount:TextField;
      
      public var cmdAddFriend:MainButton;
      
      public var txtDeyFriend:TextField;
      
      public var txtQinMi:TextField;
      
      public var txtDeyCouples:TextField;
      
      public var bgBox:MovieClip;
      
      public var friendPoint:MovieClip;
      
      public var txtRelation:TextField;
      
      public var txtMate:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var inputAddFriendName:MJInput;
      
      public var scrollFriend:UIScrollBar;
      
      public var txtDeyRelation:TextField;
      
      public var badPlayerBox:MovieClip;
      
      public var txtDeyQinMi:TextField;
      
      public var cmdBadPlayer:MainButton;
      
      public var txtDeyMatePlayer:TextField;
      
      public var txtDeyTitle:TextField;
      
      public function FriendBoxUIMC()
      {
         super();
         obf_0_4_g_383();
         obf_0_6_X_512();
         obf_7_T_1165();
      }
      
      internal function obf_7_T_1165() : *
      {
         try
         {
            cmdBadPlayer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBadPlayer.emphasized = false;
         cmdBadPlayer.enabled = true;
         cmdBadPlayer.label = "obf____4850>>";
         cmdBadPlayer.labelPlacement = "right";
         cmdBadPlayer.selected = false;
         cmdBadPlayer.toggle = false;
         cmdBadPlayer.visible = true;
         try
         {
            cmdBadPlayer["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_g_383() : *
      {
         try
         {
            cmdAddFriend["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAddFriend.emphasized = false;
         cmdAddFriend.enabled = true;
         cmdAddFriend.label = "obf_____4781 ";
         cmdAddFriend.labelPlacement = "right";
         cmdAddFriend.selected = false;
         cmdAddFriend.toggle = false;
         cmdAddFriend.visible = true;
         try
         {
            cmdAddFriend["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_6_X_512() : *
      {
         try
         {
            inputAddFriendName["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputAddFriendName.displayAsPassword = false;
         inputAddFriendName.editable = true;
         inputAddFriendName.enabled = true;
         inputAddFriendName.maxChars = 6;
         inputAddFriendName.restrict = "";
         inputAddFriendName.text = "";
         inputAddFriendName.visible = true;
         try
         {
            inputAddFriendName["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

