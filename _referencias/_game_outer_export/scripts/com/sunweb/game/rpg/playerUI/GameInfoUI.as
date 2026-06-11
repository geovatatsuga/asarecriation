package com.sunweb.game.rpg.playerUI
{
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_M_z_1692;
   import obf_g_A_3629.obf_g_u_3212;
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.managers.obf_N_g_4386;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ComponentEvent;
   import fl.managers.FocusManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import playerUI.GameInfoUIMC;
   import playerUI.SpeakerEffect;
   
   public class GameInfoUI extends GameInfoUIMC implements IPlayerUI
   {
      
      private var allMsg:Array = new Array();
      
      private var privateMsg:Array = new Array();
      
      private var teamMsg:Array = new Array();
      
      private var familyMsg:Array = new Array();
      
      private var mapMsg:Array = new Array();
      
      private var worldMsg:Array = new Array();
      
      private var systemMsg:Array = new Array();
      
      private var currentScope:int;
      
      private var sendScope:int;
      
      private var clickToMap:Boolean;
      
      private var clearOverflowMsgTime:TimeLimiter = new TimeLimiter(10000);
      
      private var msgLimit:int = 100;
      
      private var talkSaveList:Array = new Array();
      
      private var obf_w_8_2850:int = 0;
      
      private var speakerMsg:Array = new Array();
      
      private var speakerTime:TimeLimiter;
      
      private var speakerTimeInv:TimeLimiter = new TimeLimiter(1000);
      
      private var worldFaceShow:obf_M_z_1692;
      
      private var infoFaceShow:obf_M_z_1692;
      
      private var infoLinkInput:obf_g_u_3212;
      
      private var faceSprite:Sprite = new Sprite();
      
      private var novicePromptTimeInv:TimeLimiter = new TimeLimiter(5 * 60 * 1000);
      
      private var novicePromptIndex:int = 0;
      
      private var novicePromptMsg:Array;
      
      private var obf_r_P_3321:int = 183;
      
      private var maxInfoHeight:int = 300;
      
      private var obf_z_2_1200:Boolean;
      
      private var whisperPlayerIds:Array = new Array();
      
      private var sendMsgTimeInv:TimeLimiter;
      
      private var sendMapMsgTimeInv:TimeLimiter;
      
      private var sendWorldMsgTimeInv:TimeLimiter;
      
      public function GameInfoUI()
      {
         super();
         this.initDiversity();
         DiversityManager.setTextFormat(contentLayer.txtInfo);
         this.addListener();
         this.novicePromptMsg = WorldConfig.getValue("novicePrompt");
         var _loc1_:int = WorldConfig.getValue("sendMsgCDInMS");
         this.sendMsgTimeInv = new TimeLimiter(_loc1_);
         this.sendMapMsgTimeInv = new TimeLimiter(WorldConfig.getValue("sendMsgMapCDInMS") > 0 ? int(WorldConfig.getValue("sendMsgMapCDInMS")) : _loc1_);
         this.sendWorldMsgTimeInv = new TimeLimiter(WorldConfig.getValue("sendMsgWorldCDInMS") > 0 ? int(WorldConfig.getValue("sendMsgWorldCDInMS")) : _loc1_);
         contentLayer.scrollInfo.scrollTarget = contentLayer.txtInfo;
         this.infoFaceShow = new obf_M_z_1692(contentLayer.txtInfo);
         this.worldFaceShow = new obf_M_z_1692(worldBox.txtWorld);
         this.infoFaceShow.getFace = obf_N_g_4386.getFaceDisplay;
         this.worldFaceShow.getFace = obf_N_g_4386.getFaceDisplay;
         this.infoLinkInput = new obf_g_u_3212(txtInput.textField);
         this.changeSendScope(MessageScope.CHANNEL_NEARBY);
         this.changeDisplayScope(-1);
         this.hideReceiveScopeButton(null);
         this.initFace();
         faceBox.visible = false;
         this.onResize(null);
         cmdSendSpeaker.visible = !WorldConfig.getValue("functionSwitch","worldSpeaker");
         txtDeySendWorldTV.visible = cmdSendSpeaker.visible;
         cmdSendPrivate.mouseEnabled = VersionConfig.enableWhisper;
         contentLayer.scopeLayer.cmdReceivePrivate.mouseEnabled = VersionConfig.enableWhisper;
         if(!VersionConfig.enableWhisper)
         {
            txtDeySendWhisper.visible = false;
            contentLayer.scopeLayer.txtDeyScopeWhisper.visible = false;
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeySendNearby,"GameInfoBoxUI","txtSendChannelNearby");
         DiversityManager.setTextField(txtDeySendWhisper,"GameInfoBoxUI","txtSendChannelWhisper");
         DiversityManager.setTextField(txtDeySendTeam,"GameInfoBoxUI","txtSendChannelTeam");
         DiversityManager.setTextField(txtDeySendFamily,"GameInfoBoxUI","txtSendChannelFamily");
         DiversityManager.setTextField(txtDeySendWorld,"GameInfoBoxUI","txtSendChannelWrold");
         DiversityManager.setTextField(txtDeySendWorldTV,"GameInfoBoxUI","txtSendChannelWroldTV");
         DiversityManager.setTextField(contentLayer.scopeLayer.txtDeyScopeAll,"GameInfoBoxUI","txtScopeChannelAll");
         DiversityManager.setTextField(contentLayer.scopeLayer.txtDeyScopeWhisper,"GameInfoBoxUI","txtScopeChannelWhisper");
         DiversityManager.setTextField(contentLayer.scopeLayer.txtDeyScopeTeam,"GameInfoBoxUI","txtScopeChannelTeam");
         DiversityManager.setTextField(contentLayer.scopeLayer.txtDeyScopeFamily,"GameInfoBoxUI","txtScopeChannelFamily");
         DiversityManager.setTextField(contentLayer.scopeLayer.txtDeyScopeWorld,"GameInfoBoxUI","txtScopeChannelWrold");
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         contentLayer.scopeLayer.cmdReceiveAll.addEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceivePrivate.addEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveTeam.addEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveFamily.addEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveWorld.addEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         cmdSendNomal.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendPrivate.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendSpeaker.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendTeam.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendFamily.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendWorld.addEventListener(MouseEvent.CLICK,this.onClickSendScope);
         txtInput.addEventListener(KeyboardEvent.KEY_DOWN,this.onEnterContent);
         txtInput.addEventListener(KeyboardEvent.KEY_UP,this.onInputKeyUp);
         txtInput.addEventListener(FocusEvent.FOCUS_IN,this.onInputFocus);
         txtInput.addEventListener(ComponentEvent.ENTER,this.obf_8_k_1647);
         cmdEnter.addEventListener(MouseEvent.CLICK,this.onClickCmdEnter);
         contentLayer.txtInfo.addEventListener(TextEvent.LINK,this.onInfoLink);
         worldBox.txtWorld.addEventListener(TextEvent.LINK,this.onInfoLink);
         contentLayer.addEventListener(MouseEvent.MOUSE_OVER,this.showReceiveScopeButton);
         contentLayer.addEventListener(MouseEvent.MOUSE_OUT,this.hideReceiveScopeButton);
         contentLayer.cmdHide.addEventListener(MouseEvent.CLICK,this.onSHContent);
         contentLayer.cmdResize.addEventListener(MouseEvent.CLICK,this.obf_0_6_l_130);
         faceBox.addEventListener(MouseEvent.CLICK,this.onFaceSelected);
         cmdFace.addEventListener(MouseEvent.CLICK,this.onOpenFace);
         faceBox.cmdClose.addEventListener(MouseEvent.CLICK,this.onCloseFace);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         contentLayer.scopeLayer.cmdReceiveAll.removeEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceivePrivate.removeEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveTeam.removeEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveFamily.removeEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         contentLayer.scopeLayer.cmdReceiveWorld.removeEventListener(MouseEvent.CLICK,this.onClickReceiveScope);
         cmdSendNomal.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendPrivate.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendSpeaker.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendTeam.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendFamily.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         cmdSendWorld.removeEventListener(MouseEvent.CLICK,this.onClickSendScope);
         txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.onEnterContent);
         txtInput.removeEventListener(KeyboardEvent.KEY_UP,this.onInputKeyUp);
         txtInput.removeEventListener(FocusEvent.FOCUS_IN,this.onInputFocus);
         txtInput.removeEventListener(ComponentEvent.ENTER,this.obf_8_k_1647);
         cmdEnter.removeEventListener(MouseEvent.CLICK,this.onClickCmdEnter);
         contentLayer.txtInfo.removeEventListener(TextEvent.LINK,this.onInfoLink);
         worldBox.txtWorld.removeEventListener(TextEvent.LINK,this.onInfoLink);
         contentLayer.removeEventListener(MouseEvent.MOUSE_OVER,this.showReceiveScopeButton);
         contentLayer.removeEventListener(MouseEvent.MOUSE_OUT,this.hideReceiveScopeButton);
         contentLayer.cmdHide.removeEventListener(MouseEvent.CLICK,this.onSHContent);
         contentLayer.cmdResize.removeEventListener(MouseEvent.CLICK,this.obf_0_6_l_130);
         faceBox.addEventListener(MouseEvent.CLICK,this.onFaceSelected);
         cmdFace.removeEventListener(MouseEvent.CLICK,this.onOpenFace);
         faceBox.cmdClose.removeEventListener(MouseEvent.CLICK,this.onCloseFace);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         GameContext.gameFocusManager = txtInput.focusManager as FocusManager;
         GameContext.gameFocusManager.deactivate();
      }
      
      private function onResize(param1:Event) : void
      {
         this.y = GameContext.gameStage.stageHeight - 70;
      }
      
      private function initFace() : void
      {
         var _loc4_:DisplayObject = null;
         var _loc1_:int = 8;
         var _loc2_:int = 25;
         faceBox.bgBox.width = _loc1_ * _loc2_ + 15;
         var _loc3_:int = 0;
         while(_loc3_ < 50)
         {
            _loc4_ = obf_N_g_4386.getFaceDisplay(obf_L_l_4100.obf_1_m_1767(_loc3_ + "",2,"0"));
            if(_loc4_)
            {
               _loc4_.name = obf_L_l_4100.obf_1_m_1767(_loc3_ + "",2,"0");
               _loc4_.x = 10 + _loc3_ % _loc1_ * _loc2_;
               _loc4_.y = 10 + int(_loc3_ / _loc1_) * _loc2_;
               this.faceSprite.addChild(_loc4_);
               faceBox.bgBox.height = _loc4_.y + _loc2_ + 5;
            }
            _loc3_++;
         }
         faceBox.bgBox.x = faceBox.bgBox.width / 2;
         faceBox.bgBox.y = faceBox.bgBox.height / 2;
         faceBox.y = -faceBox.bgBox.height;
         faceBox.cmdClose.x = faceBox.bgBox.width - 10;
      }
      
      private function onFaceSelected(param1:Event) : void
      {
         if(txtInput.text.length + 3 > txtInput.maxChars)
         {
            return;
         }
         if(param1.target is MovieClip && param1.target != faceBox.bgBox)
         {
            this.onCloseFace(null);
            txtInput.htmlText += "#" + param1.target.name;
            txtInput.focusManager.setFocus(txtInput);
            txtInput.setSelection(txtInput.text.length,txtInput.text.length);
         }
      }
      
      private function onOpenFace(param1:Event) : void
      {
         faceBox.addChild(this.faceSprite);
         faceBox.visible = true;
      }
      
      private function obf_0_2_W_85(param1:Event) : void
      {
         if(!obf_K_e_3075.magicMotionUI)
         {
            return;
         }
         if(obf_K_e_3075.magicMotionUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.magicMotionUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.magicMotionUI);
         }
      }
      
      private function onCloseFace(param1:Event) : void
      {
         faceBox.visible = false;
         faceBox.removeChild(this.faceSprite);
         txtInput.focusManager.setFocus(txtInput);
         txtInput.setSelection(txtInput.text.length,txtInput.text.length);
      }
      
      public function setInfoHeight(param1:int) : void
      {
         contentLayer.txtInfo.height = param1;
         contentLayer.scrollInfo.height = param1;
         contentLayer.scrollInfo.scrollTarget = contentLayer.txtInfo;
         contentLayer.scrollInfo.update();
         contentLayer.bgBox.height = param1 + 26;
         contentLayer.y = -(contentLayer.bgBox.y + contentLayer.bgBox.height + 26);
         worldBox.y = contentLayer.y - worldBox.height;
         this.infoFaceShow.obf_q_a_4150();
         this.infoFaceShow.refresh();
      }
      
      private function obf_0_6_l_130(param1:Event) : void
      {
         if(contentLayer.txtInfo.height > this.obf_r_P_3321)
         {
            this.setInfoHeight(this.obf_r_P_3321);
         }
         else
         {
            this.setInfoHeight(this.maxInfoHeight);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.showSpeakerInfo();
         if(this.clearOverflowMsgTime.checkTimeout())
         {
            this.clearOverflowMsg();
         }
         if(Boolean(this.novicePromptMsg && this.novicePromptMsg.length > 0) && Boolean(JSONUtil.getInt(GameContext.localPlayer,["fullInfo","level"]) <= 30) && this.novicePromptTimeInv.checkTimeout())
         {
            this.receiveMsg(this.novicePromptMsg[this.novicePromptIndex],MessageScope.CHANNEL_SYSTEM,DiversityManager.getString("CommonPrompt","system"));
            ++this.novicePromptIndex;
            if(this.novicePromptIndex > this.novicePromptMsg.length - 1)
            {
               this.novicePromptIndex = 0;
            }
         }
      }
      
      public function getInputFocus() : void
      {
         txtInput.focusManager.setFocus(txtInput);
         txtInput.textField.setSelection(txtInput.text.length,txtInput.text.length);
      }
      
      public function addItemLink(param1:String, param2:String, param3:String, param4:int) : void
      {
         if(txtInput.text.length + param3.length > txtInput.maxChars)
         {
            return;
         }
         this.infoLinkInput.insertLink(obf_g_u_3212.getItemLinkCode(param3,param1,param2),param4.toString(16));
         this.getInputFocus();
      }
      
      public function addMapPointLink(param1:String, param2:String, param3:int, param4:int) : void
      {
         if(txtInput.text.length + param1.length > txtInput.maxChars)
         {
            return;
         }
         this.infoLinkInput.insertLink(obf_g_u_3212.getMapLinkCode(param1,param2,param3,param4),ChatDecoder.obf_l_W_4297);
         this.getInputFocus();
      }
      
      public function addNPCPointLink(param1:String, param2:String, param3:String) : void
      {
         if(txtInput.text.length + param1.length > txtInput.maxChars)
         {
            return;
         }
         this.infoLinkInput.insertLink(obf_g_u_3212.getNpcLinkCode(param1,param3,param2),ChatDecoder.obf_0_4_R_115);
         this.getInputFocus();
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = null;
         var _loc3_:Point = null;
         if(param1.target != this && param1.target != contentLayer.txtInfo && param1.target != worldBox.txtWorld)
         {
            return;
         }
         if(Boolean(GameContext.currentMap) && this.clickToMap)
         {
            _loc2_ = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
            _loc3_ = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
            _loc2_.localX = _loc3_.x;
            _loc2_.localY = _loc3_.y;
            GameContext.currentMap.dispatchEvent(_loc2_);
         }
      }
      
      private function onMouseDown(param1:Event) : void
      {
         PlayerMenuUI.closeMenuById("whisperMenu");
         this.clickToMap = true;
      }
      
      private function showReceiveScopeButton(param1:Event) : void
      {
         contentLayer.scopeLayer.visible = true;
         contentLayer.scrollInfo.visible = true;
         contentLayer.bgBox.visible = true;
         contentLayer.cmdHide.visible = true;
         contentLayer.cmdResize.visible = true;
      }
      
      private function hideReceiveScopeButton(param1:Event) : void
      {
         contentLayer.scopeLayer.visible = false;
         contentLayer.scrollInfo.visible = false;
         contentLayer.bgBox.visible = false;
         contentLayer.cmdResize.visible = false;
         if(contentLayer.x >= 0)
         {
            contentLayer.cmdHide.visible = false;
         }
      }
      
      private function onSHContent(param1:Event) : void
      {
         if(contentLayer.x < 0)
         {
            contentLayer.x = 0;
         }
         else
         {
            contentLayer.x = -contentLayer.cmdHide.x;
         }
      }
      
      private function resetReceiveScopeButton() : void
      {
         contentLayer.scopeLayer.cmdReceiveAll.gotoAndStop(1);
         contentLayer.scopeLayer.cmdReceivePrivate.gotoAndStop(1);
         contentLayer.scopeLayer.cmdReceiveTeam.gotoAndStop(1);
         contentLayer.scopeLayer.cmdReceiveFamily.gotoAndStop(1);
         contentLayer.scopeLayer.cmdReceiveWorld.gotoAndStop(1);
      }
      
      private function resetSendScopeButton() : void
      {
         cmdSendNomal.gotoAndStop(1);
         cmdSendPrivate.gotoAndStop(1);
         cmdSendSpeaker.gotoAndStop(1);
         cmdSendTeam.gotoAndStop(1);
         cmdSendFamily.gotoAndStop(1);
         cmdSendWorld.gotoAndStop(1);
      }
      
      private function clearOverflowMsg() : void
      {
         if(this.allMsg.length > this.msgLimit)
         {
            this.allMsg.splice(0,this.allMsg.length - this.msgLimit);
         }
         if(this.privateMsg.length > this.msgLimit)
         {
            this.privateMsg.splice(0,this.privateMsg.length - this.msgLimit);
         }
         if(this.teamMsg.length > this.msgLimit)
         {
            this.teamMsg.splice(0,this.teamMsg.length - this.msgLimit);
         }
         if(this.familyMsg.length > this.msgLimit)
         {
            this.familyMsg.splice(0,this.familyMsg.length - this.msgLimit);
         }
         if(this.mapMsg.length > this.msgLimit)
         {
            this.mapMsg.splice(0,this.mapMsg.length - this.msgLimit);
         }
         if(this.worldMsg.length > this.msgLimit)
         {
            this.worldMsg.splice(0,this.worldMsg.length - this.msgLimit);
         }
         if(contentLayer.txtInfo.numLines > this.msgLimit)
         {
            this.refreshDisplay();
         }
      }
      
      private function showSpeakerInfo() : void
      {
         var _loc1_:String = null;
         var _loc2_:obf_6_t_3568 = null;
         if(this.speakerTimeInv.checkTimeout())
         {
            if(!this.speakerTime || this.speakerTime.checkTimeout() || this.speakerMsg.length > 0 && this.speakerTime.totalTimeInMS > 1000)
            {
               worldBox.txtWorld.htmlText = "";
               this.worldFaceShow.refresh();
               if(this.speakerMsg.length > 0)
               {
                  _loc1_ = this.speakerMsg.shift() as String;
                  worldBox.txtWorld.htmlText = _loc1_;
                  if(this.speakerMsg.length == 0)
                  {
                     this.speakerTime = new TimeLimiter(60 * 1000);
                  }
                  else
                  {
                     this.speakerTime = new TimeLimiter(10000);
                  }
                  this.worldFaceShow.refresh();
                  _loc2_ = new obf_6_t_3568(new SpeakerEffect());
                  _loc2_.allowRepeat = false;
                  _loc2_.autoRemove = true;
                  worldBox.addChild(_loc2_);
                  _loc1_ = "<font color=\'#" + obf_0_3_0_538.obf_H_k_2174.toString(16) + "\'>" + _loc1_ + "</font><br>";
                  this.worldMsg.push(_loc1_);
                  this.allMsg.push(_loc1_);
                  if(this.currentScope == -1 || this.currentScope == MessageScope.CHANNEL_WORLD)
                  {
                     this.addMsgToShow(_loc1_);
                  }
               }
               else
               {
                  this.speakerTime = null;
               }
            }
         }
      }
      
      private function onInputKeyUp(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
         if(param1.keyCode == Keyboard.ESCAPE || this.obf_z_2_1200)
         {
            txtInput.focusManager.setFocus(null);
            this.obf_z_2_1200 = false;
         }
         if(this.talkSaveList.length > 0 && (param1.keyCode == Keyboard.UP || param1.keyCode == Keyboard.DOWN))
         {
            if(param1.keyCode == Keyboard.UP)
            {
               --this.obf_w_8_2850;
            }
            else if(param1.keyCode == Keyboard.DOWN)
            {
               ++this.obf_w_8_2850;
            }
            if(this.obf_w_8_2850 < 0)
            {
               this.obf_w_8_2850 = 0;
            }
            else if(this.obf_w_8_2850 > this.talkSaveList.length - 1)
            {
               this.obf_w_8_2850 = this.talkSaveList.length - 1;
            }
            txtInput.htmlText = this.talkSaveList[this.obf_w_8_2850];
         }
      }
      
      private function obf_8_k_1647(param1:Event) : void
      {
         if(txtInput.text != "")
         {
            this.enterContent(this.infoLinkInput.sendText);
         }
         else
         {
            this.obf_z_2_1200 = true;
         }
      }
      
      private function onClickCmdEnter(param1:Event) : void
      {
         this.enterContent(this.infoLinkInput.sendText);
      }
      
      private function onEnterContent(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function onInputFocus(param1:Event) : void
      {
         txtInput.focusManager.deactivate();
      }
      
      public function enterContent(param1:String) : void
      {
         if(!param1 || param1 == "")
         {
            return;
         }
         if(param1.charAt(0) == "\\")
         {
            obf_F_2_2975.obf_O_p_3236(param1.substr(1));
            txtInput.text = "";
            return;
         }
         if(!DiversityManager.obf_4_9_1545(param1,true))
         {
            txtInput.text = "";
            return;
         }
         if(this.talkSaveList.length == 0 || txtInput.htmlText != this.talkSaveList[this.talkSaveList.length - 1])
         {
            this.talkSaveList.push(txtInput.htmlText);
            if(this.talkSaveList.length > 20)
            {
               this.talkSaveList.shift();
            }
         }
         this.obf_w_8_2850 = this.talkSaveList.length;
         txtInput.text = "";
         var _loc2_:String = "";
         if(param1.charAt(0) == "/" && param1.indexOf(" ") > -1)
         {
            _loc2_ = param1.substring(1,param1.indexOf(" "));
            param1 = param1.substr(param1.indexOf(" "));
            if(_loc2_ != "")
            {
               txtInput.text = "/" + _loc2_ + " ";
               txtInput.setSelection(txtInput.length,txtInput.length);
               this.changeSendScope(MessageScope.CHANNEL_PRIVATE);
               if(this.whisperPlayerIds.indexOf(_loc2_) == -1)
               {
                  this.whisperPlayerIds.push(_loc2_);
               }
               if(this.whisperPlayerIds.length > 6)
               {
                  this.whisperPlayerIds.shift();
               }
            }
         }
         else if(this.sendScope == MessageScope.CHANNEL_PRIVATE)
         {
            this.changeSendScope(MessageScope.CHANNEL_NEARBY);
         }
         var _loc3_:RegExp = /#([0-9]{2})/ig;
         var _loc4_:Object = _loc3_.exec(param1);
         var _loc5_:int = 0;
         var _loc6_:String = param1;
         while(_loc4_ != null)
         {
            if(_loc5_ >= 2)
            {
               param1 = param1.replace(_loc4_[0],"");
            }
            _loc4_ = _loc3_.exec(_loc6_);
            _loc5_++;
         }
         this.sendMsg(obf_L_l_4100.obf_I_C_3435(param1),this.sendScope,_loc2_);
      }
      
      private function onClickReceiveScope(param1:MouseEvent) : void
      {
         if(param1.currentTarget == contentLayer.scopeLayer.cmdReceiveAll)
         {
            this.changeDisplayScope();
         }
         else if(param1.currentTarget == contentLayer.scopeLayer.cmdReceivePrivate)
         {
            this.changeDisplayScope(MessageScope.CHANNEL_PRIVATE);
         }
         else if(param1.currentTarget == contentLayer.scopeLayer.cmdReceiveTeam)
         {
            this.changeDisplayScope(MessageScope.CHANNEL_TEAM);
         }
         else if(param1.currentTarget == contentLayer.scopeLayer.cmdReceiveFamily)
         {
            this.changeDisplayScope(MessageScope.CHANNEL_FAMILY);
         }
         else if(param1.currentTarget == contentLayer.scopeLayer.cmdReceiveWorld)
         {
            this.changeDisplayScope(MessageScope.CHANNEL_WORLD);
         }
      }
      
      private function onClickSendScope(param1:MouseEvent) : void
      {
         if(param1.currentTarget == cmdSendNomal)
         {
            this.changeSendScope(MessageScope.CHANNEL_NEARBY);
         }
         else if(param1.currentTarget == cmdSendPrivate)
         {
            this.changeSendScope(MessageScope.CHANNEL_PRIVATE);
            this.showWhisperMenu();
         }
         else if(param1.currentTarget == cmdSendTeam)
         {
            this.changeSendScope(MessageScope.CHANNEL_TEAM);
         }
         else if(param1.currentTarget == cmdSendFamily)
         {
            this.changeSendScope(MessageScope.CHANNEL_FAMILY);
         }
         else if(param1.currentTarget == cmdSendWorld)
         {
            this.changeSendScope(MessageScope.CHANNEL_WORLD);
         }
         else if(param1.currentTarget == cmdSendSpeaker)
         {
            this.changeSendScope(MessageScope.TV_WORLD);
         }
      }
      
      private function onInfoLink(param1:TextEvent) : void
      {
         this.clickToMap = false;
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function whisper(param1:String) : void
      {
         this.changeSendScope(MessageScope.CHANNEL_PRIVATE);
         txtInput.text = "/" + param1 + " ";
         txtInput.setFocus();
         txtInput.setSelection(txtInput.length,txtInput.length);
      }
      
      public function showWhisperMenu() : void
      {
         var _loc2_:String = null;
         var _loc3_:Point = null;
         var _loc4_:PlayerMenuItem = null;
         if(this.whisperPlayerIds.length == 0)
         {
            return;
         }
         var _loc1_:PlayerMenuUI = new PlayerMenuUI("whisperMenu");
         for each(_loc2_ in this.whisperPlayerIds)
         {
            _loc4_ = new PlayerMenuItem(_loc2_,this.whisper,[_loc2_]);
            _loc1_.addMenuItem(_loc4_,_loc2_);
         }
         _loc3_ = new Point(this.mouseX,this.mouseY - _loc1_.height);
         _loc3_ = this.localToGlobal(_loc3_);
         PlayerMenuUI.showMenu(_loc1_,_loc3_.x,_loc3_.y);
      }
      
      private function getScopeMsgArray(param1:int) : Array
      {
         var _loc2_:Array = null;
         if(param1 == -1)
         {
            _loc2_ = this.allMsg;
         }
         else if(param1 == MessageScope.CHANNEL_PRIVATE)
         {
            _loc2_ = this.privateMsg;
         }
         else if(param1 == MessageScope.CHANNEL_TEAM)
         {
            _loc2_ = this.teamMsg;
         }
         else if(param1 == MessageScope.CHANNEL_FAMILY)
         {
            _loc2_ = this.familyMsg;
         }
         else if(param1 == MessageScope.CHANNEL_MAP)
         {
            _loc2_ = this.mapMsg;
         }
         else if(param1 == MessageScope.CHANNEL_WORLD)
         {
            _loc2_ = this.worldMsg;
         }
         return _loc2_;
      }
      
      private function refreshDisplay() : void
      {
         var _loc3_:String = null;
         contentLayer.txtInfo.htmlText = "";
         var _loc1_:Array = this.getScopeMsgArray(this.currentScope);
         var _loc2_:String = "";
         if(_loc1_)
         {
            for each(_loc3_ in _loc1_)
            {
               _loc2_ += _loc3_;
            }
         }
         this.addMsgToShow(_loc2_);
         if(contentLayer.txtInfo.scrollV >= contentLayer.txtInfo.maxScrollV - 1)
         {
            contentLayer.txtInfo.scrollV = contentLayer.txtInfo.maxScrollV;
         }
      }
      
      private function changeDisplayScope(param1:int = -1) : void
      {
         if(param1 == this.currentScope)
         {
            return;
         }
         this.currentScope = param1;
         this.resetReceiveScopeButton();
         if(param1 == -1)
         {
            contentLayer.scopeLayer.cmdReceiveAll.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_PRIVATE)
         {
            contentLayer.scopeLayer.cmdReceivePrivate.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_TEAM)
         {
            contentLayer.scopeLayer.cmdReceiveTeam.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_FAMILY)
         {
            contentLayer.scopeLayer.cmdReceiveFamily.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_WORLD)
         {
            contentLayer.scopeLayer.cmdReceiveWorld.gotoAndStop(2);
         }
         this.refreshDisplay();
      }
      
      private function changeSendScope(param1:int) : void
      {
         this.sendScope = param1;
         this.resetSendScopeButton();
         if(param1 == MessageScope.CHANNEL_NEARBY)
         {
            cmdSendNomal.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_PRIVATE)
         {
            cmdSendPrivate.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_TEAM)
         {
            cmdSendTeam.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_FAMILY)
         {
            cmdSendFamily.gotoAndStop(2);
         }
         else if(param1 == MessageScope.CHANNEL_WORLD)
         {
            cmdSendWorld.gotoAndStop(2);
         }
         else if(param1 == MessageScope.TV_WORLD)
         {
            cmdSendSpeaker.gotoAndStop(2);
         }
         if(param1 != MessageScope.CHANNEL_PRIVATE && txtInput.text.charAt(0) == "/")
         {
            txtInput.text = "";
         }
      }
      
      public function receiveMsg(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param2 == MessageScope.CHANNEL_PRIVATE && !VersionConfig.enableWhisper)
         {
            return;
         }
         if(param2 != MessageScope.CHANNEL_SYSTEM && param2 < 100)
         {
            param1 = obf_L_l_4100.obf_r_1236(param1);
         }
         param1 = ChatDecoder.decode(param1,null,param2 == MessageScope.CHANNEL_SYSTEM || param2 == MessageScope.obf_P_s_1792 || param2 == MessageScope.SCROLL_SYSTEM || param2 == MessageScope.LOTTERY_SYSTEM ? null : [ChatDecoder.obf_E_4_4245,ChatDecoder.obf_9_K_1802,ChatDecoder.obf_W_v_983]);
         if(param2 != MessageScope.CHANNEL_SYSTEM && param2 != MessageScope.SCROLL_SYSTEM && param2 != MessageScope.obf_P_s_1792)
         {
            if(FriendManager.obf_0_2_R_182(param3))
            {
               return;
            }
            param1 = obf_r_Y_1874.obf_y_Q_3915(param1);
         }
         if(param2 == MessageScope.CHANNEL_SYSTEM)
         {
            param1 = param3 + ":" + param1;
         }
         else if(param2 == MessageScope.CHANNEL_PRIVATE)
         {
            param1 = DiversityManager.getString("GameInfoBoxUI","whisperToMe",["<a href=\'event:" + ChatDecoder.obf_W_v_983 + "^" + param3 + "\'>[" + param3 + "]</a>"]) + param1;
         }
         else if(param2 < 100)
         {
            param1 = "<a href=\'event:" + ChatDecoder.obf_W_v_983 + "^" + param3 + "\'>[" + param3 + "]：</a>" + param1;
         }
         if(param2 == MessageScope.TV_WORLD)
         {
            this.speakerMsg.push(param1);
         }
         if(param2 == MessageScope.CHANNEL_NEARBY)
         {
            param1 += "<BR>";
         }
         else if(param2 == MessageScope.CHANNEL_PRIVATE)
         {
            param1 = "<FONT COLOR=\'#" + obf_0_3_0_538.obf_B_j_2838.toString(16) + "\'>" + param1 + "</FONT><BR>";
            this.privateMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_TEAM)
         {
            param1 = "<FONT COLOR=\'#" + obf_0_3_0_538.obf_r_b_4612.toString(16) + "\'>" + param1 + "</FONT><BR>";
            this.teamMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_FAMILY)
         {
            param1 = "<FONT COLOR=\'#" + obf_0_3_0_538.obf_i_p_2678.toString(16) + "\'>" + param1 + "</FONT><BR>";
            this.familyMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_MAP)
         {
            _loc4_ = obf_0_3_0_538.obf_n_t_1588.toString(16);
            param1 = "<FONT COLOR=\'#" + _loc4_ + "\'>" + param1 + "</FONT><BR>";
            this.mapMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_WORLD)
         {
            _loc5_ = obf_0_3_0_538.obf_n_t_1588.toString(16);
            param1 = "<FONT COLOR=\'#" + _loc5_ + "\'>" + param1 + "</FONT><BR>";
            this.worldMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_SYSTEM)
         {
            param1 = "<FONT COLOR=\'#" + obf_0_3_0_538.obf_S_I_2152.toString(16) + "\'>" + param1 + "</FONT><BR>";
            this.systemMsg.push(param1);
         }
         if(param2 == MessageScope.SCROLL_SYSTEM)
         {
            obf_K_e_3075.showSystemInfo(param1);
         }
         else if(param2 == MessageScope.obf_P_s_1792 || param2 == MessageScope.LOTTERY_SYSTEM)
         {
            obf_K_e_3075.systemInfoUI.showFixedInfo(param1);
         }
         if(param2 < 100 && param2 != MessageScope.TV_WORLD)
         {
            this.allMsg.push(param1);
            if(this.currentScope == -1 || this.currentScope == param2 || param2 == MessageScope.CHANNEL_SYSTEM)
            {
               this.addMsgToShow(param1);
            }
         }
      }
      
      private function addMsgToShow(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(contentLayer.txtInfo.scrollV == contentLayer.txtInfo.maxScrollV)
         {
            _loc2_ = true;
         }
         contentLayer.txtInfo.htmlText += param1;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.letterSpacing = 1;
         TextField(contentLayer.txtInfo).setTextFormat(_loc3_);
         if(_loc2_)
         {
            contentLayer.txtInfo.scrollV = contentLayer.txtInfo.maxScrollV;
         }
         contentLayer.scrollInfo.update();
         this.infoFaceShow.refresh();
      }
      
      public function sendMsg(param1:String, param2:int, param3:String = "") : void
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         if(param2 == MessageScope.CHANNEL_MAP)
         {
            if(!this.sendMapMsgTimeInv.checkTimeout())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GameInfoBoxUI","promptError_SayTooFast"));
               return;
            }
         }
         else if(param2 == MessageScope.CHANNEL_WORLD)
         {
            if(!this.sendWorldMsgTimeInv.checkTimeout())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GameInfoBoxUI","promptError_SayTooFast"));
               return;
            }
         }
         else if(!this.sendMsgTimeInv.checkTimeout())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GameInfoBoxUI","promptError_SayTooFast"));
            return;
         }
         if(!GameContext.localPlayer || param1 == "")
         {
            return;
         }
         var _loc4_:String = param1;
         if(param2 == MessageScope.CHANNEL_PRIVATE)
         {
            param1 = obf_L_l_4100.obf_r_1236(param1);
            param1 = ChatDecoder.decode(param1,null,[ChatDecoder.obf_E_4_4245,ChatDecoder.obf_9_K_1802,ChatDecoder.obf_W_v_983]);
            param1 = "<FONT COLOR=\'#" + obf_0_3_0_538.obf_B_j_2838.toString(16) + "\'>" + DiversityManager.getString("GameInfoBoxUI","iWhisperTo",["<a href=\'event:" + ChatDecoder.obf_W_v_983 + "^" + param3 + "\'>[" + param3 + "]</a>"]) + param1 + "</FONT><BR>";
            this.addMsgToShow(param1);
            this.privateMsg.push(param1);
            this.allMsg.push(param1);
         }
         else if(param2 == MessageScope.CHANNEL_WORLD)
         {
            if(!ConditionScript.checkCondition(WorldConfig.getValue("sendMsgWorldCond"),null,true))
            {
               return;
            }
            if(WorldConfig.getStringSetting("worldChannelSpeakItem") != "" && !ConditionScript.hasAnyItem(WorldConfig.getStringSetting("worldChannelSpeakItem").split(",")))
            {
               _loc5_ = "";
               _loc6_ = WorldConfig.getStringSetting("worldChannelSpeakItem").split(",");
               for each(_loc7_ in _loc6_)
               {
                  _loc5_ += " " + GameItemManager.getItemName(_loc7_);
               }
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GameInfoBoxUI","promptError_NeedItem",[_loc5_]));
               return;
            }
         }
         else if(param2 == MessageScope.TV_WORLD)
         {
            if(!ConditionScript.checkCondition(WorldConfig.getValue("worldSpeakCondition"),null,true))
            {
               return;
            }
            if(WorldConfig.getStringSetting("worldTVSpeakItem") != "" && !ConditionScript.hasAnyItem(WorldConfig.getStringSetting("worldTVSpeakItem").split(",")))
            {
               _loc8_ = "";
               _loc9_ = WorldConfig.getStringSetting("worldTVSpeakItem").split(",");
               for each(_loc10_ in _loc9_)
               {
                  _loc8_ += " " + GameItemManager.getItemName(_loc10_);
               }
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GameInfoBoxUI","promptError_NeedItem",[_loc8_]));
               return;
            }
         }
         else
         {
            this.receiveMsg(param1,param2,GameContext.localPlayer.id);
         }
         GameContext.localPlayer.sendMsg(_loc4_,param2,param3);
         this.sendMsgTimeInv = new TimeLimiter(WorldConfig.getNumberSetting("sendMsgCDInMS"));
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.infoFaceShow.destroy();
         this.infoLinkInput.destroy();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

