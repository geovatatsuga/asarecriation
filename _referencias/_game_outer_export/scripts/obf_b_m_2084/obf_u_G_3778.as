package obf_b_m_2084
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.challenge.ArenaRobotInfo;
   import com.sunweb.game.rpg.challenge.obf_0_5_f_69;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAddChanceAnswer;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAwardNotify;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotOpenAnswer;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotReportNotify;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import playerUI.ChallengeUIMC;
   
   public class obf_u_G_3778 extends ChallengeUIMC implements IPlayerUI, IIconItemUI
   {
      
      public var cmdButtons:Array;
      
      public var cmdLooksButtons:Array;
      
      public var cmdLookButtons:Array;
      
      public var txtranks:Array;
      
      public var txtnames:Array;
      
      public var obf_k_l_3679:Object;
      
      public var rankNmeObj:Object;
      
      private var currentLv:int;
      
      public var obf_K_N_3098:String;
      
      private var obf_M_d_1877:int;
      
      private var obf_q_X_763:int;
      
      private var awardBag:IconItemBag;
      
      private var _canAward:Boolean;
      
      private var obf_O_g_4193:TimeLimiter = new TimeLimiter(1000);
      
      public function obf_u_G_3778()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.cmdButtons = [this.cmdDare0,this.cmdDare1,this.cmdDare2,this.cmdDare3,this.cmdDare4];
         this.cmdLooksButtons = [this.cmdLook0,this.cmdLook1,this.cmdLook2,this.cmdLook3,this.cmdLook4];
         this.addListener();
         this.awardBag = new IconItemBag(award,this,0);
         this.awardBag.lockDrag = true;
         this.awardBag.addValidType(GameItemType.ALL);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyRank,"RobotChallengeUI","txtDeyRank");
         DiversityManager.setTextField(txtAwardGold,"RobotChallengeUI","txtAwardGold");
         DiversityManager.setTextField(txtReceiveTime,"RobotChallengeUI","txtReceiveTime");
         DiversityManager.setTextField(surplusTime,"RobotChallengeUI","surplusTime");
         DiversityManager.setTextField(txtAwardsRank,"RobotChallengeUI","txtAwardsRank");
         DiversityManager.setTextField(txtTitle,"RobotChallengeUI","txtTitle");
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this["cmdLook" + _loc1_].label = DiversityManager.getString("RobotChallengeUI","cmdLook");
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            this["cmdDare" + _loc2_].label = DiversityManager.getString("RobotChallengeUI","cmdChallge");
            _loc2_++;
         }
         cmdAward.label = DiversityManager.getString("RobotChallengeUI","cmdAward");
         btnObtain.label = DiversityManager.getString("RobotChallengeUI","btnObtain");
      }
      
      public function addListener() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         bgbox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         btnObtain.addEventListener(MouseEvent.CLICK,this.obf_x_9_1614);
         for each(_loc1_ in this.cmdButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_H_D_1050);
         }
         for each(_loc2_ in this.cmdLooksButtons)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.obf_0_5_444);
         }
         GameContext.gameStage.addEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
         txtRank.addEventListener(TextEvent.LINK,this.onClickLink);
         txtCommunique.addEventListener(TextEvent.LINK,this.onClickLink);
         btnObtain.addEventListener(MouseEvent.MOUSE_OVER,this.obf_3_D_1854);
         btnObtain.addEventListener(MouseEvent.MOUSE_OUT,this.obf_v_B_1237);
         txtRank0.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank2.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank3.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank4.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank0.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank2.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank3.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank4.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         cmdAward.addEventListener(MouseEvent.CLICK,this.obf_x_1085);
      }
      
      public function removeListener() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         bgbox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         btnObtain.removeEventListener(MouseEvent.CLICK,this.obf_x_9_1614);
         for each(_loc1_ in this.cmdButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_H_D_1050);
         }
         for each(_loc2_ in this.cmdLooksButtons)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.obf_0_5_444);
         }
         GameContext.gameStage.removeEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
         txtRank.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtCommunique.removeEventListener(TextEvent.LINK,this.onClickLink);
         btnObtain.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_3_D_1854);
         btnObtain.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_v_B_1237);
         txtRank0.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank1.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank2.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank3.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank4.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         txtRank0.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank1.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank2.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank3.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         txtRank4.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         cmdAward.removeEventListener(MouseEvent.CLICK,this.obf_x_1085);
      }
      
      private function obf_x_1085(param1:MouseEvent) : void
      {
         obf_0_5_f_69.sendAward();
      }
      
      private function obf_N_N_1987(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:GameTipUI = null;
         var _loc2_:String = obf_L_l_4100.obf_I_C_3435(param1.target.text);
         if(!obf_L_l_4100.isEmpty(_loc2_))
         {
            _loc3_ = int(_loc2_);
            _loc4_ = obf_0_5_f_69.getAwardConfig();
            _loc5_ = new Array();
            _loc6_ = new Object();
            for each(_loc7_ in _loc4_)
            {
               _loc5_.push(_loc7_.minRank);
               _loc6_[_loc7_.minRank] = _loc7_.awardsRemark;
            }
            _loc5_.sortOn("",Array.NUMERIC);
            _loc8_ = 0;
            _loc9_ = int(_loc5_.length - 1);
            while(_loc9_ >= 0)
            {
               if(_loc3_ >= _loc5_[_loc9_])
               {
                  _loc8_ = _loc9_;
                  break;
               }
               _loc9_--;
            }
            _loc10_ = new GameTipUI("rank");
            _loc10_.addTipInfo(_loc6_[_loc5_[_loc8_]],150,0);
            GameTipManager.showTip(_loc10_);
         }
      }
      
      private function obf_k_a_2234(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("rank");
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_x_9_1614(param1:Event) : void
      {
         if(!obf_0_5_f_69.isAddRobotNum)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","buyNum"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.money < obf_0_5_f_69.getMoney())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","dontGold"));
            return;
         }
         obf_0_5_f_69.sendRobotAddChanceRequest();
      }
      
      private function obf_H_D_1050(param1:Event) : void
      {
         if(!this.obf_k_l_3679)
         {
            return;
         }
         var _loc2_:int = int(this.obf_k_l_3679[param1.target.name]);
         this.obf_M_d_1877 = _loc2_;
         if(GameContext.localPlayer.hasTeam() == true)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","hasTeam"));
            return;
         }
         if(_loc2_ == this.currentLv)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","dontMySelf"));
            return;
         }
         if(this.obf_q_X_763 <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","noNum"));
            return;
         }
         var _loc3_:String = GameContext.currentMap.mapId;
         if(obf_0_5_f_69.getNoChallgeMapIdList().indexOf(_loc3_) >= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","noChallge"));
            return;
         }
         if(obf_0_5_f_69.getCanChallgeMapIdList().length > 0 && obf_0_5_f_69.getCanChallgeMapIdList().indexOf(_loc3_) == -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RobotChallengeUI","noChallge"));
            return;
         }
         obf_0_5_f_69.sendRobotChallengeRequest(_loc2_);
         obf_K_e_3075.closeUI(this);
         this.clear();
      }
      
      private function obf_3_D_1854(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("RobotChallengeUI");
         _loc2_.addTipInfo(DiversityManager.getString("RobotChallengeUI","cost",[obf_0_5_f_69.getMoney()]),150,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_v_B_1237(param1:Event) : void
      {
         GameTipManager.closeTip("RobotChallengeUI");
      }
      
      public function showChallengeInfo(param1:RobotOpenAnswer) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:DisplayObject = null;
         var _loc14_:Object = null;
         this.clear();
         txtName.text = GameContext.localPlayer.fullInfo.name;
         this.obf_q_X_763 = param1.robotNum;
         surplusTimeNum.text = param1.robotNum + "";
         if(param1.awardLevel == 0)
         {
            txtArards.text = DiversityManager.getString("RobotChallengeUI","noAwards");
         }
         else
         {
            txtArards.text = param1.awardLevel + "";
         }
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(param1.itemCode,"");
         this.awardBag.pushIconItem(_loc2_);
         this.currentLv = param1.robotLevel;
         txtRankLv.text = param1.robotLevel + "";
         var _loc3_:int = 0;
         this.obf_k_l_3679 = {};
         this.rankNmeObj = {};
         var _loc4_:Array = new Array();
         var _loc5_:Object = param1.robotList;
         for(_loc6_ in _loc5_)
         {
            _loc12_ = {};
            _loc12_.lv = _loc6_;
            if(!_loc5_)
            {
               _loc12_.arenaRobotInfo = null;
            }
            else
            {
               _loc12_.arenaRobotInfo = _loc5_[_loc6_] as ArenaRobotInfo;
            }
            _loc4_.push(_loc12_);
         }
         _loc4_.sortOn("lv",Array.NUMERIC);
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            this.obf_k_l_3679["cmdDare" + _loc3_] = _loc4_[_loc7_].lv;
            if(_loc4_[_loc7_].arenaRobotInfo)
            {
               this.rankNmeObj["cmdLook" + _loc3_] = _loc4_[_loc7_].arenaRobotInfo.name;
               while(this["point" + _loc3_].numChildren > 0)
               {
                  this["point" + _loc3_].removeChildAt(0);
               }
               _loc13_ = obf_I_5_1944.getJobImage(_loc4_[_loc7_].arenaRobotInfo.job,_loc4_[_loc7_].arenaRobotInfo.sex);
               if(_loc13_)
               {
                  _loc13_.scaleX = 0.4;
                  _loc13_.scaleY = 0.4;
                  this["point" + _loc3_].addChild(_loc13_);
                  (this["point" + _loc3_] as MovieClip).mouseChildren = false;
                  (this["point" + _loc3_] as MovieClip).mouseEnabled = false;
               }
               this["txtName" + _loc3_].text = _loc4_[_loc7_].arenaRobotInfo.name;
            }
            this["txtRank" + _loc3_].text = _loc4_[_loc7_].lv;
            _loc3_++;
            _loc7_++;
         }
         var _loc8_:String = "";
         var _loc9_:Array = new Array();
         for(_loc10_ in param1.heroList)
         {
            _loc14_ = {};
            _loc14_.heroRankLv = _loc10_;
            _loc14_.playerName = param1.heroList[_loc10_];
            _loc9_.push(_loc14_);
         }
         _loc11_ = 0;
         while(_loc11_ < _loc9_.length)
         {
            if(_loc9_[_loc11_].playerName != "")
            {
               _loc8_ += DiversityManager.getString("RobotChallengeUI","challengRank",[_loc9_[_loc11_].heroRankLv,obf_7_6_4416.getRoleLinkA(_loc9_[_loc11_].playerName)]) + "\n";
            }
            else
            {
               _loc8_ += DiversityManager.getString("RobotChallengeUI","challengRank",[_loc9_[_loc11_].heroRankLv,DiversityManager.getString("RobotChallengeUI","challengRankNull")]) + "\n";
            }
            _loc11_++;
         }
         txtRank.htmlText = _loc8_;
         obf_O_F_2801.update();
      }
      
      public function obf_9_z_3052(param1:RobotReportNotify) : void
      {
         var _loc2_:Array = param1.reportList;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(com.adobe.serialization.json.JSON.decode(_loc2_[_loc4_]));
            _loc4_++;
         }
         var _loc5_:String = "";
         var _loc6_:* = int(_loc3_.length - 1);
         while(_loc6_ >= 0)
         {
            if(_loc6_ == _loc3_.length - 1)
            {
               _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeNew");
            }
            else
            {
               _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeOld");
            }
            if(_loc3_[_loc6_].isInitiate == true && _loc3_[_loc6_].rusult == true)
            {
               if(_loc3_[_loc6_].resultLevel > 0)
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeWin",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName),_loc3_[_loc6_].resultLevel]) + "\n";
               }
               else
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeWinNo",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName)]) + "\n";
               }
            }
            else if(_loc3_[_loc6_].isInitiate == true && _loc3_[_loc6_].rusult == false)
            {
               if(_loc3_[_loc6_].resultLevel > 0)
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeLoss2",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName),_loc3_[_loc6_].resultLevel]) + "\n";
               }
               else
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeLoss2No",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName)]) + "\n";
               }
            }
            else if(_loc3_[_loc6_].isInitiate == false && _loc3_[_loc6_].rusult == false)
            {
               if(_loc3_[_loc6_].resultLevel > 0)
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeLoss",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName),_loc3_[_loc6_].resultLevel]) + "\n";
               }
               else
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeLossNo",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName)]) + "\n";
               }
            }
            else if(_loc3_[_loc6_].isInitiate == false && _loc3_[_loc6_].rusult == true)
            {
               if(_loc3_[_loc6_].resultLevel > 0)
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeWin2",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName),_loc3_[_loc6_].resultLevel]) + "\n";
               }
               else
               {
                  _loc5_ += DiversityManager.getString("RobotChallengeUI","challengeWin2No",[obf_7_6_4416.getRoleLinkA(_loc3_[_loc6_].playerName)]) + "\n";
               }
            }
            _loc6_--;
         }
         txtCommunique.htmlText = _loc5_;
         obf_H_w_3575.update();
      }
      
      public function obf_f_w_1077(param1:RobotAwardNotify) : void
      {
         this._canAward = param1.canAward;
      }
      
      private function setShstate(param1:Boolean) : void
      {
         if(param1)
         {
            cmdAward.enabled = true;
         }
         else
         {
            cmdAward.enabled = false;
         }
      }
      
      public function setServerTime(param1:String) : void
      {
         this.obf_K_N_3098 = param1;
      }
      
      public function obf_m_K_3062(param1:RobotAddChanceAnswer) : void
      {
         surplusTimeNum.text = param1.robotNum + "";
         this.obf_q_X_763 = param1.robotNum;
      }
      
      private function obf_0_5_444(param1:Event) : void
      {
         if(!this.rankNmeObj)
         {
            return;
         }
         var _loc2_:String = this.rankNmeObj[param1.target.name];
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            return;
         }
         obf_0_5_f_69.sendViewRemote(_loc2_);
      }
      
      private function obf_0_2_B_370(param1:Event) : void
      {
         if(!this.obf_O_g_4193.checkTimeout())
         {
            return;
         }
         var _loc2_:String = obf_0_5_f_69.getTime12();
         var _loc3_:Array = String(_loc2_).split("-");
         var _loc4_:Array = String(_loc3_[0]).split(":");
         var _loc5_:Array = String(_loc3_[1]).split(":");
         var _loc6_:Date = new Date();
         _loc6_.setHours(_loc4_[0]);
         _loc6_.setMinutes(_loc4_[1]);
         _loc6_.setSeconds(0);
         var _loc7_:Date = new Date();
         _loc7_.setHours(_loc5_[0]);
         _loc7_.setMinutes(_loc5_[1]);
         _loc7_.setSeconds(0);
         var _loc8_:Date = new Date();
         var _loc9_:Array = String(this.obf_K_N_3098).split(" ");
         var _loc10_:Array = String(_loc9_[1]).split(":");
         _loc8_.setHours(_loc10_[0]);
         _loc8_.setMinutes(_loc10_[1]);
         _loc8_.setSeconds(_loc10_[2]);
         var _loc11_:Number = _loc8_.getTime() + getTimer();
         if(_loc11_ < _loc6_.getTime())
         {
            obf_0_3_E_375.htmlText = obf_l_y_733.getTimeStringHHMMSS(_loc6_.getTime() - _loc11_);
            this.setShstate(this._canAward);
         }
         else if(_loc11_ > _loc7_.getTime())
         {
            obf_0_3_E_375.htmlText = obf_l_y_733.getTimeStringHHMMSS(_loc6_.getTime() + 24 * 60 * 60 * 1000 - _loc11_);
            this.setShstate(this._canAward);
         }
         else
         {
            obf_0_3_E_375.htmlText = DiversityManager.getString("RobotChallengeUI","award");
            this.setShstate(false);
         }
      }
      
      private function clear() : void
      {
         txtRankLv.text = "";
         txtRank.htmlText = "";
         txtCommunique.htmlText = "";
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            while(this["point" + _loc1_].numChildren > 0)
            {
               this["point" + _loc1_].removeChildAt(0);
            }
            _loc1_++;
         }
         txtName0.text = "";
         txtName1.text = "";
         txtName2.text = "";
         txtName3.text = "";
         txtName4.text = "";
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
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
      }
      
      public function getIconItemBags() : Array
      {
         return [this.awardBag];
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
   }
}

