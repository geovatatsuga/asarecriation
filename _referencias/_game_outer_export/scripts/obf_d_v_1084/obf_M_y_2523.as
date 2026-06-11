package obf_d_v_1084
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FeedBossUIMC;
   
   public class obf_M_y_2523 extends FeedBossUIMC implements IIconItemUI
   {
      
      private var iconBag:IconItemBag;
      
      private var obf_5_P_1620:obf_9_c_4534;
      
      private var curLv:int = 0;
      
      private var petImageActiveTimeInv:TimeLimiter = new TimeLimiter(2000);
      
      private var frist:Boolean;
      
      public function obf_M_y_2523()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.iconBag = new IconItemBag(iconBar,this,0);
         this.iconBag.lockDrag = true;
         this.iconBag.addValidType(GameItemType.COLLECTION | GameItemType.EXPENDABLE);
         expBar.gotoAndStop(1);
         this.obf_x_v_2806();
         cmdCallBoss.enabled = false;
         this.showIcon(0);
      }
      
      private function obf_x_v_2806() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdFeed.addEventListener(MouseEvent.CLICK,this.obf_0_2_K_469);
         cmdCallBoss.addEventListener(MouseEvent.CLICK,this.obf_S_N_2849);
         pointMC.addEventListener(MouseEvent.MOUSE_OVER,this.obf_u_P_4566);
         pointMC.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_0_q_682);
      }
      
      private function removerListen() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdFeed.removeEventListener(MouseEvent.CLICK,this.obf_0_2_K_469);
         cmdCallBoss.removeEventListener(MouseEvent.CLICK,this.obf_S_N_2849);
         pointMC.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_u_P_4566);
         pointMC.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_0_q_682);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_u_P_4566(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("bossUI");
         _loc2_.addTipInfo(JSONUtil.getStr(obf_F_9_1495.bossFeedConfig[this.curLv],["picture"]),250,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_0_q_682(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("bossUI");
      }
      
      private function obf_0_2_K_469(param1:MouseEvent) : void
      {
         if(!this.iconBag.haveIconItem)
         {
            return;
         }
         if(obf_F_9_1495.obf_n_R_3309 < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("bossFeedUI","overTimes"));
            return;
         }
         if(this.curLv >= obf_F_9_1495.bossFeedConfig.length - 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("bossFeedUI","maxLv"));
            return;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(this.iconBag.haveIconItem.itemCode) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("bossFeedUI","noMoreMaterial",[GameItemManager.getItemName(this.iconBag.haveIconItem.itemCode)]));
            return;
         }
         obf_F_9_1495.sendBossFeed(this.iconBag.haveIconItem.itemCode);
      }
      
      private function obf_S_N_2849(param1:MouseEvent) : void
      {
         if(!ConditionScript.checkCondition(obf_F_9_1495.callBossCondition,null,true))
         {
            return;
         }
         if(!JSONUtil.obf_P_M_2133(obf_F_9_1495.allowCallInMapIDList as Object) && obf_F_9_1495.allowCallInMapIDList.indexOf(GameContext.currentMap.mapId) == -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("bossFeedUI","notCallBoss"));
            return;
         }
         if(this.curLv < obf_F_9_1495.bossFeedConfig.length - 1)
         {
            return;
         }
         obf_F_9_1495.sendCallBoss();
      }
      
      private function obf_p_O_2652(param1:IconItem) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:Boolean = false;
         for each(_loc4_ in obf_F_9_1495.materialList)
         {
            if(param1.itemCode == JSONUtil.getStr(_loc4_,["itemCode"]))
            {
               _loc2_ = true;
               _loc3_ = _loc4_.doMacro;
               break;
            }
         }
         if(!_loc2_)
         {
            return;
         }
         this.iconBag.dropIconItem();
         txtHortation.text = "";
         param1.itemCount = 1;
         this.iconBag.pushIconItem(param1);
         txtHortation.htmlText = DiversityManager.getString("bossFeedUI","txtHortation",[JSONUtil.getInt(_loc3_,["addFamilyGold"]),JSONUtil.getInt(_loc3_,["addFamilyGx"]),JSONUtil.getInt(_loc3_,["addBossGrow"]),JSONUtil.getInt(_loc3_,["addRoleExp"])]);
         rewardScrollBar.update();
      }
      
      public function showBoss(param1:int) : void
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         this.obf_E_j_2700();
         this.curLv = obf_F_9_1495.getBossValue(param1);
         if(this.curLv < 0)
         {
            this.curLv = 0;
         }
         var _loc2_:Object = obf_F_9_1495.bossFeedConfig[this.curLv];
         var _loc3_:int = this.curLv + 1;
         var _loc4_:Object = obf_F_9_1495.bossFeedConfig[obf_F_9_1495.bossFeedConfig.length - 1];
         var _loc5_:int = JSONUtil.getInt(_loc4_,["bossGrow"]);
         if(_loc3_ >= obf_F_9_1495.bossFeedConfig.length)
         {
            _loc3_ = this.curLv;
            txtBossExp.htmlText = DiversityManager.getString("bossFeedUI","bossMaxLv");
            expBar.gotoAndStop(100);
            txtExp.text = _loc5_ + "/" + _loc5_;
            cmdCallBoss.enabled = true;
         }
         else
         {
            _loc6_ = obf_F_9_1495.bossFeedConfig[_loc3_];
            txtBossExp.htmlText = DiversityManager.getString("bossFeedUI","txtBossExp",[JSONUtil.getInt(_loc6_,["bossGrow"]) - param1,BossTypeList.getRankName(_loc3_)]);
            _loc7_ = 100 * Number(param1 / _loc5_);
            if(_loc7_ < 2)
            {
               _loc7_ = 2;
            }
            expBar.gotoAndStop(_loc7_);
            txtExp.text = param1 + "/" + _loc5_;
            cmdCallBoss.enabled = false;
         }
         txtLv.htmlText = BossTypeList.getRankName(this.curLv,true);
         this.obf_5_P_1620 = new obf_9_c_4534(JSONUtil.getStr(_loc2_,["visualize"]));
         if(this.obf_5_P_1620)
         {
            this.obf_5_P_1620.x = 0;
            pointMC.addChild(this.obf_5_P_1620);
         }
         this.showIcon(this.curLv);
         DiversityManager.setTextField(txtdayFeedTimes,"bossFeedUI","txtdayFeedTimes",[obf_F_9_1495.obf_n_R_3309]);
      }
      
      private function showIcon(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this["icon" + _loc2_].filters = [obf_9_V_1635.getGrayFilter()];
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            this["jian" + _loc3_].filters = [obf_9_V_1635.getGrayFilter()];
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ <= param1)
         {
            this["icon" + _loc4_].filters = [];
            if(_loc4_ < 3)
            {
               this["jian" + _loc4_].filters = [];
            }
            _loc4_++;
         }
      }
      
      private function obf_E_j_2700() : void
      {
         txtBossExp.text = "";
         expBar.gotoAndStop(1);
         txtExp.text = "";
         while(pointMC.numChildren > 0)
         {
            pointMC.removeChildAt(0);
         }
         if(this.obf_5_P_1620)
         {
            this.obf_5_P_1620.destroy();
         }
         this.obf_5_P_1620 = null;
         txtLv.text = "";
         txtdayFeedTimes.text = "";
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_5_P_1620) && this.petImageActiveTimeInv.checkTimeout())
         {
            this.obf_5_P_1620.onUpdate();
            this.obf_5_P_1620.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
      }
      
      public function getIconItemBags() : Array
      {
         return [this.iconBag];
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1 == this.iconBag)
         {
            this.obf_p_O_2652(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"bossFeedUI","txtDeyTitle");
         DiversityManager.setTextField(txtDeyFeed,"bossFeedUI","txtDeyFeed");
         DiversityManager.setTextField(txtDeyHortation,"bossFeedUI","txtDeyHortation");
         DiversityManager.setTextField(txtDeyPicture,"bossFeedUI","txtDeyPicture");
         pictureScrollBar.update();
         cmdFeed.label = DiversityManager.getString("bossFeedUI","cmdFeed");
         cmdCallBoss.label = DiversityManager.getString("bossFeedUI","cmdCallBoss");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(!this.frist)
         {
            this.frist = true;
            DiversityManager.setTextField(txtdayFeedTimes,"bossFeedUI","txtdayFeedTimes",[obf_F_9_1495.obf_n_R_3309]);
         }
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removerListen();
      }
   }
}

