package obf_0_0_k_571
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.ConsumeInfo;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.activityBox.ConsumeRankItemNotify;
   import com.sunweb.game.rpg.worldZone.command.activityBox.ConsumeRankNotify;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import playerUI.ConsumeRankingUIMC;
   
   public class ConsumeRankingUI extends ConsumeRankingUIMC implements IPlayerUI
   {
      
      public var cmdLooksButtons:Array;
      
      public var rankLvObj:Object;
      
      public var serverDate:String;
      
      public var serverTime:String;
      
      public function ConsumeRankingUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.cmdLooksButtons = [this.cmd1,this.cmd2,this.cmd3,this.cmd4,this.cmd5,this.cmd6,this.cmd7,this.cmd8,this.cmd9,this.cmd10];
         this.addListener();
         this.obf_V_T_3922();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtLv1,"AstrictTimeUI","txtLv1");
         DiversityManager.setTextField(txtLv2,"AstrictTimeUI","txtLv2");
         DiversityManager.setTextField(txtLv3,"AstrictTimeUI","txtLv3");
         DiversityManager.setTextField(txtLv4,"AstrictTimeUI","txtLv4");
         DiversityManager.setTextField(txtLv5,"AstrictTimeUI","txtLv5");
         DiversityManager.setTextField(txtLv6,"AstrictTimeUI","txtLv6");
         DiversityManager.setTextField(txtLv7,"AstrictTimeUI","txtLv7");
         DiversityManager.setTextField(txtLv8,"AstrictTimeUI","txtLv8");
         DiversityManager.setTextField(txtLv9,"AstrictTimeUI","txtLv9");
         DiversityManager.setTextField(txtLv10,"AstrictTimeUI","txtLv10");
         cmd1.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd2.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd3.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd4.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd5.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd6.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd7.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd8.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd9.label = DiversityManager.getString("AstrictTimeUI","cmd");
         cmd10.label = DiversityManager.getString("AstrictTimeUI","cmd");
         DiversityManager.setTextField(textTime,"AstrictTimeUI","textTime");
         DiversityManager.setTextField(txtDeyTitle,"AstrictTimeUI","txtDeyTitle");
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         for each(_loc1_ in this.cmdLooksButtons)
         {
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onShowItemTip);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.obf_v_B_1237);
         }
         GameContext.gameStage.addEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         for each(_loc1_ in this.cmdLooksButtons)
         {
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onShowItemTip);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_v_B_1237);
         }
         GameContext.gameStage.removeEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
      }
      
      private function onShowItemTip(param1:Event) : void
      {
         if(!this.rankLvObj)
         {
            return;
         }
         var _loc2_:int = int(this.rankLvObj[param1.target.name]);
         var _loc3_:Object = activityBoxManager.getConsumeRank();
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Array = _loc3_.playerRankconfig;
         var _loc5_:Array = _loc3_.awardCondition;
         var _loc6_:Array = _loc3_.awardItemCode;
         if(_loc2_ - 1 < 0)
         {
            return;
         }
         var _loc7_:String = _loc4_[_loc2_ - 1];
         var _loc8_:int = int(_loc5_[_loc2_ - 1]);
         var _loc9_:String = _loc6_[_loc2_ - 1];
         var _loc10_:GameTipUI = new GameTipUI("Item");
         if(!GameItemManager.getItemConfig(_loc7_))
         {
            return;
         }
         if(!GameItemManager.getItemConfig(_loc9_))
         {
            return;
         }
         var _loc11_:String = GameItemRank.getRankColor(GameItemManager.getItemConfig(_loc7_).rank).toString(16);
         var _loc12_:String = GameItemRank.getRankColor(GameItemManager.getItemConfig(_loc9_).rank).toString(16);
         _loc10_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("AstrictTimeUI","award") + "</P>",150,_loc10_.maxRow);
         _loc10_.addTipObject(GameItemManager.getItemIcon(_loc7_),_loc10_.maxRow);
         _loc10_.addTipInfo("<P align=\'right\'><FONT color=\'#" + _loc11_ + "\'>" + GameItemManager.getItemConfig(_loc7_).name + "</FONT></P>",150,_loc10_.maxRow);
         _loc10_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("AstrictTimeUI","eAward",[_loc8_]) + "</P>",150,_loc10_.maxRow + 1);
         _loc10_.addTipObject(GameItemManager.getItemIcon(_loc9_),_loc10_.maxRow);
         _loc10_.addTipInfo("<P align=\'right\'><FONT color=\'#" + _loc12_ + "\'>" + GameItemManager.getItemConfig(_loc9_).name + "</FONT></P>",150,_loc10_.maxRow);
         GameTipManager.showTip(_loc10_);
      }
      
      private function obf_v_B_1237(param1:Event) : void
      {
         GameTipManager.closeTip("Item");
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
      
      private function obf_V_T_3922() : void
      {
         var _loc1_:Object = activityBoxManager.getConsumeRank();
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Object = obf_J_F_3431.getActConfig(_loc1_.activityCode);
         remark.htmlText = JSONUtil.getStr(_loc2_,["activityRemark"]);
      }
      
      public function obf_N_n_916(param1:ConsumeRankNotify) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:DisplayObject = null;
         this.clear();
         this.rankLvObj = {};
         var _loc2_:Array = new Array();
         var _loc3_:Array = param1.rankInfo;
         for(_loc4_ in _loc3_)
         {
            _loc6_ = {};
            _loc6_.lv = _loc4_ + 1;
            _loc6_.rankInfo = _loc3_[_loc4_] as ConsumeInfo;
            _loc2_.push(_loc6_);
         }
         _loc2_.sortOn("lv",Array.NUMERIC);
         _loc5_ = 1;
         while(_loc5_ <= _loc2_.length)
         {
            this.rankLvObj["cmd" + _loc5_] = _loc2_[_loc5_ - 1].lv;
            (this["txtName" + _loc5_] as TextField).text = _loc2_[_loc5_ - 1].rankInfo.playerName;
            while(this["playerIcon" + _loc5_].numChildren > 0)
            {
               this["playerIcon" + _loc5_].removeChildAt(0);
            }
            _loc7_ = HeadIconCode.getHeadIconByInt(_loc2_[_loc5_ - 1].rankInfo.headIconIndex);
            if(_loc7_)
            {
               _loc7_.scaleX = 1;
               _loc7_.scaleY = 1;
               this["playerIcon" + _loc5_].addChild(_loc7_);
               (this["playerIcon" + _loc5_] as MovieClip).mouseChildren = false;
               (this["playerIcon" + _loc5_] as MovieClip).mouseEnabled = false;
            }
            while(this["moneyPoint" + _loc5_].numChildren > 0)
            {
               this["moneyPoint" + _loc5_].removeChildAt(0);
            }
            _loc8_ = obf_a_f_2935.getMoneyDisplay(_loc2_[_loc5_ - 1].rankInfo.consume);
            this["moneyPoint" + _loc5_].addChild(_loc8_);
            _loc5_++;
         }
      }
      
      private function clear() : void
      {
         txtName1.text = "";
         txtName2.text = "";
         txtName3.text = "";
         txtName4.text = "";
         txtName5.text = "";
         txtName6.text = "";
         txtName7.text = "";
         txtName8.text = "";
         txtName9.text = "";
         txtName10.text = "";
      }
      
      public function showAwerdsTip(param1:ConsumeRankItemNotify) : void
      {
         WindowManager.showMessageBox(DiversityManager.getString("AstrictTimeUI","jiawardsTip",[param1.rank]));
      }
      
      public function setServerTime(param1:String, param2:String) : void
      {
         this.serverDate = param1;
         this.serverTime = param2;
      }
      
      private function obf_0_2_B_370(param1:Event) : void
      {
         var _loc2_:Object = activityBoxManager.getConsumeRank();
         if(!_loc2_)
         {
            return;
         }
         if(!obf_J_F_3431.obf_4_4696(_loc2_.activityCode))
         {
            return;
         }
         var _loc3_:String = obf_J_F_3431.getActConfig(_loc2_.activityCode).dateLimit;
         var _loc4_:Array = String(_loc3_).split("~");
         var _loc5_:Array = String(_loc4_[_loc4_.length - 1]).split("-");
         var _loc6_:Date = new Date();
         var _loc7_:int = int(_loc5_[1]) - 1;
         _loc6_.setFullYear(int(_loc5_[0]),_loc7_,int(_loc5_[2]));
         _loc6_.setHours(23);
         _loc6_.setMinutes(59);
         var _loc8_:Date = new Date();
         var _loc9_:Array = String(this.serverDate).split("-");
         var _loc10_:Array = String(this.serverTime).split(":");
         var _loc11_:int = int(_loc9_[1]) - 1;
         _loc8_.setFullYear(int(_loc9_[0]),_loc11_,int(_loc9_[2]));
         _loc8_.setHours(int(_loc10_[0]));
         _loc8_.setMinutes(int(_loc10_[1]));
         var _loc12_:Number = _loc8_.getTime();
         txtTime.htmlText = obf_l_y_733.getTimeStringMin(_loc6_.getTime() - _loc12_);
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
   }
}

