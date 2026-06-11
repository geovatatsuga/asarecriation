package obf_a_l_3879
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playingCard.BounRuleKind;
   import com.sunweb.game.rpg.playingCard.CardFaceKind;
   import com.sunweb.game.rpg.playingCard.obf_V_N_2158;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import playerUI.PlayingCardUIMC;
   
   public class PlayingCardUI extends PlayingCardUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var cardBags:Array;
      
      private var pointCards:Array;
      
      private var obf_C_P_1323:Array;
      
      public var obf_0_1_Y_208:Array = new Array();
      
      private var startBool:Boolean = false;
      
      public function PlayingCardUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.onResize(null);
         cmdStart.visible = true;
         cmdReset.visible = false;
         this.initBags();
         this.addListener();
      }
      
      private function initBags() : void
      {
         var _loc2_:MovieClip = null;
         this.pointCards = [this.pointCard0,this.pointCard1,this.pointCard2,this.pointCard3,this.pointCard4,this.pointCard5,this.pointCard6,this.pointCard7,this.pointCard8];
         this.cardBags = new Array();
         this.bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = this["bag" + _loc1_];
            this.cardBags.push(_loc2_);
            this.bags.push(this["bag" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdReceive.addEventListener(MouseEvent.CLICK,this.obf_L_R_1398);
         cmdStart.addEventListener(MouseEvent.CLICK,this.onStart);
         cmdReset.addEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         txtRewards.addEventListener(TextEvent.LINK,this.onInfoLink);
         obf_K_e_3075.addUIMouseToolTip(cmdRule,"playingCardRule");
         for each(_loc1_ in this.bags)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_H_y_2745);
         }
         cmdCardRule.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         cmdCardRule.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdReceive.removeEventListener(MouseEvent.CLICK,this.obf_L_R_1398);
         cmdStart.removeEventListener(MouseEvent.CLICK,this.onStart);
         cmdReset.removeEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         txtRewards.removeEventListener(TextEvent.LINK,this.onInfoLink);
         obf_K_e_3075.removeUIMouseToolTip(cmdRule);
         for each(_loc1_ in this.bags)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_H_y_2745);
         }
         cmdCardRule.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         cmdCardRule.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
      }
      
      private function obf_L_R_1398(param1:Event) : void
      {
         obf_V_N_2158.sendReward(obf_V_N_2158.ruleKind);
      }
      
      private function onStart(param1:Event) : void
      {
         this.obf_0_1_Y_208 = new Array();
         if(GameContext.localPlayer.fullInfo.gameTimes == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayingCardUI","buyGame"));
            obf_V_N_2158._playingCardConfig = null;
         }
         else
         {
            obf_V_N_2158.sendStart();
         }
      }
      
      private function obf_W_g_1639(param1:Event) : void
      {
         this.obf_0_1_Y_208 = new Array();
         this.obf_2_b_1076();
         if(GameContext.localPlayer.fullInfo.gameTimes == 0 && obf_V_N_2158.turnTimes == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayingCardUI","buyGame"));
            obf_V_N_2158._playingCardConfig = null;
         }
         obf_V_N_2158.sendStart();
      }
      
      private function confirmReset(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_V_N_2158.sendStart();
         }
      }
      
      private function obf_b_i_1293(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.gameTimes == 0)
         {
            if(GameContext.localPlayer.fullInfo.money < obf_V_N_2158.sixCost())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayingCardUI","not_EnoughMoney"));
               return;
            }
            WindowManager.showConfirmBox(DiversityManager.getString("PlayingCardUI","confirmReset"),this.confirmBuy);
         }
      }
      
      private function confirmBuy(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_V_N_2158.sendAddTimes();
         }
      }
      
      private function onInfoLink(param1:TextEvent) : void
      {
         var _loc2_:String = param1.text;
         var _loc3_:Array = _loc2_.split("^");
         if(_loc3_[0] == ChatDecoder.obf_W_v_983)
         {
            GameContext.localPlayer.sendViewRemote(_loc3_[1]);
         }
         else
         {
            obf_7_6_4416.obf_2_F_3313(param1.text);
         }
      }
      
      private function obf_a_a_3635(param1:Event) : void
      {
      }
      
      private function obf_H_y_2745(param1:Event) : void
      {
         if(!obf_V_N_2158._playingCardConfig)
         {
            this.obf_0_1_Y_208 = new Array();
            return;
         }
         if(this.obf_0_1_Y_208.length < 6)
         {
            this.showIcon(this.cardBags.indexOf(param1.currentTarget));
            return;
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayingCardUI","not_Translate"));
      }
      
      private function obf_Z_l_1286(param1:Event) : void
      {
         var _loc2_:Point = null;
         var _loc4_:Number = NaN;
         if(!_loc2_)
         {
            _loc2_ = new Point(GameContext.gameStage.mouseX + 5,GameContext.gameStage.mouseY - obf_K_e_3075.obf_Z_G_2885.height - 10);
         }
         var _loc3_:int = obf_K_e_3075.obf_Z_G_2885.width;
         if(obf_K_e_3075.obf_Z_G_2885.width > GameContext.gameStage.stageWidth || obf_K_e_3075.obf_Z_G_2885.height > GameContext.gameStage.stageHeight)
         {
            _loc4_ = 0;
            if(obf_K_e_3075.obf_Z_G_2885.width - GameContext.gameStage.stageWidth > obf_K_e_3075.obf_Z_G_2885.height - GameContext.gameStage.stageHeight)
            {
               _loc4_ = GameContext.gameStage.stageWidth / obf_K_e_3075.obf_Z_G_2885.width;
            }
            else
            {
               _loc4_ = GameContext.gameStage.stageHeight / obf_K_e_3075.obf_Z_G_2885.height;
            }
            obf_K_e_3075.obf_Z_G_2885.scaleX = _loc4_;
            obf_K_e_3075.obf_Z_G_2885.scaleY = _loc4_;
         }
         if(_loc2_.x > this.stage.stageWidth - _loc3_)
         {
            _loc2_.x = this.stage.stageWidth - _loc3_;
         }
         if(_loc2_.x < 0)
         {
            _loc2_.x = 0;
         }
         if(_loc2_.y > this.stage.stageHeight - obf_K_e_3075.obf_Z_G_2885.height)
         {
            _loc2_.y -= obf_K_e_3075.obf_Z_G_2885.height + 1;
         }
         if(_loc2_.y < 0)
         {
            _loc2_.y = 20;
         }
         obf_K_e_3075.obf_Z_G_2885.x = _loc2_.x;
         obf_K_e_3075.obf_Z_G_2885.y = _loc2_.y;
         obf_K_e_3075.showUI(obf_K_e_3075.obf_Z_G_2885);
      }
      
      private function obf_0_6_9_109(param1:Event) : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.obf_Z_G_2885);
      }
      
      private function showIcon(param1:int) : void
      {
         var _loc2_:String = null;
         this.obf_0_1_Y_208.push(param1);
         var _loc3_:Array = obf_V_N_2158._playingCardConfig as Array;
         if(!_loc3_)
         {
            return;
         }
         _loc2_ = _loc3_[param1].cardId;
         if(this.obf_0_1_Y_208.length == 6)
         {
            if(GameContext.localPlayer.fullInfo.money < obf_V_N_2158.sixCost())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayingCardUI","not_EnoughMoney"));
               this.obf_0_1_Y_208.pop();
               return;
            }
            WindowManager.showConfirmBox(DiversityManager.getString("PlayingCardUI","confirmTranslate"),this.confirmTranslate,{
               "index1":param1,
               "iconId1":_loc2_
            });
         }
         else
         {
            obf_V_N_2158.sendTurn(param1,_loc2_);
         }
      }
      
      private function confirmTranslate(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_V_N_2158.sendTurn(param1.par.index1,param1.par.iconId1);
         }
      }
      
      public function setShowAward(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         txtRewards.text = "";
         var _loc2_:String = "";
         var _loc3_:Array = obf_V_N_2158.obf_M_B_1743;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = int(param1[_loc4_]);
            _loc6_ = _loc3_[_loc5_].ruleExplain;
            _loc7_ = JSONUtil.getNumber(_loc3_[_loc5_].doMacro,["addRoleExpUnit"]);
            _loc8_ = _loc7_ * NumberConfig.getPlayerLevelExpGemValue(GameContext.localPlayer.fullInfo.level);
            _loc9_ = JSONUtil.getObject(_loc3_[_loc5_].doMacro,["receiveItems"]);
            _loc2_ += "\n" + BounRuleKind.getCardRewardName(_loc3_[_loc5_].ruleKind) + ":\n";
            _loc2_ += DiversityManager.getString("PlayingCardUI","addGold",[JSONUtil.getInt(_loc3_[_loc5_].doMacro,["addGold"])]) + "\n";
            _loc2_ += DiversityManager.getString("PlayingCardUI","addMoney",[JSONUtil.getInt(_loc3_[_loc5_].doMacro,["addMoney"])]) + "\n";
            _loc2_ += DiversityManager.getString("PlayingCardUI","addRoleExpUnit",[_loc8_]) + "\n";
            _loc10_ = "";
            for(_loc11_ in _loc9_)
            {
               _loc12_ = int(GameItemManager.getItemConfig(_loc11_).rank);
               _loc13_ = GameItemRank.getRankColor(_loc12_).toString(16);
               _loc10_ += "<FONT COLOR=\'#" + _loc13_ + "\'><A HREF=\"event:" + ChatDecoder.obf_d_Y_2785 + "^" + _loc11_ + "\">[<U>" + GameItemManager.getItemName(_loc11_) + "</U>]</A></FONT>" + "X" + _loc9_[_loc11_] + " ";
            }
            _loc2_ += DiversityManager.getString("PlayingCardUI","receiveItems",[_loc10_]) + "\n";
            _loc4_++;
         }
         txtRewards.htmlText += _loc2_;
         rewardScrollBar.update();
      }
      
      public function showInfo() : void
      {
         DiversityManager.setTextField(txtLeavings,"PlayingCardUI","txtLeavings",[obf_V_N_2158.turnTimes]);
         DiversityManager.setTextField(txtReset,"PlayingCardUI","txtReset",[GameContext.localPlayer.fullInfo.gameTimes]);
      }
      
      public function obf_2_X_1632(param1:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:GlowFilter = null;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            while(this.pointCards[_loc2_].numChildren > 0)
            {
               this.pointCards[_loc2_].removeChildAt(0);
            }
            (this.cardBags[_loc2_] as MovieClip).gotoAndStop("disable");
            _loc2_++;
         }
         var _loc3_:Array = obf_V_N_2158._playingCardConfig as Array;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            (this.cardBags[param1[_loc4_]] as MovieClip).gotoAndStop("enable");
            _loc5_ = obf_V_N_2158.getIdConfig(_loc3_[param1[_loc4_]].cardId);
            if(_loc5_)
            {
               _loc6_ = _loc5_.cardIcon;
               obf_0_P_4381.obf_m_X_1194(_loc6_,this.pointCards[param1[_loc4_]]);
               _loc7_ = new GlowFilter(CardFaceKind.getCardColor(_loc3_[param1[_loc4_]].face),1,8,8,2,2);
               this.pointCards[param1[_loc4_]].filters = [_loc7_];
            }
            _loc4_++;
         }
      }
      
      public function obf_2_b_1076() : void
      {
         txtRewards.text = "";
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            while(this.pointCards[_loc1_].numChildren > 0)
            {
               this.pointCards[_loc1_].removeChildAt(0);
            }
            (this.cardBags[_loc1_] as MovieClip).gotoAndStop("disable");
            this.pointCards[_loc1_].filters = null;
            _loc1_++;
         }
      }
      
      public function showButtonState() : void
      {
         if(!obf_V_N_2158._playingCardConfig)
         {
            cmdStart.visible = true;
            cmdReset.visible = false;
            cmdReceive.enabled = false;
         }
         else
         {
            cmdStart.visible = false;
            cmdReset.visible = true;
            if(obf_V_N_2158.ruleKind.length > 0)
            {
               cmdReceive.enabled = true;
            }
            else
            {
               cmdReceive.enabled = false;
            }
         }
         if(GameContext.localPlayer.fullInfo.gameTimes == 0)
         {
            cmdBuy.enabled = true;
         }
         else
         {
            cmdBuy.enabled = false;
         }
         DiversityManager.setTextField(txtLeavings,"PlayingCardUI","txtLeavings",[obf_V_N_2158.turnTimes]);
         DiversityManager.setTextField(txtReset,"PlayingCardUI","txtReset",[GameContext.localPlayer.fullInfo.gameTimes]);
         this.obf_2_X_1632(this.obf_0_1_Y_208);
      }
      
      public function getIconItemBags() : Array
      {
         return null;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtLeavings,"PlayingCardUI","txtLeavings");
         DiversityManager.setTextField(txtReset,"PlayingCardUI","txtReset");
         cmdReceive.label = DiversityManager.getString("PlayingCardUI","cmdReceive");
         cmdStart.label = DiversityManager.getString("PlayingCardUI","cmdStart");
         cmdReset.label = DiversityManager.getString("PlayingCardUI","cmdReset");
         cmdBuy.label = DiversityManager.getString("PlayingCardUI","cmdBuy");
         cmdRule.label = DiversityManager.getString("PlayingCardUI","cmdRule");
         cmdCardRule.label = DiversityManager.getString("PlayingCardUI","cmdCardRule");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showButtonState();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

