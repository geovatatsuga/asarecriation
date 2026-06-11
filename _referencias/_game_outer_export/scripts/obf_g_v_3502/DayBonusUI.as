package obf_g_v_3502
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.misc.obf_0_5_9_486;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerVipCheckNotify;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.DayBonusUIMC;
   
   public class DayBonusUI extends DayBonusUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var _coin:int;
      
      private var _offlineExp:int;
      
      private var _offlineTime:int;
      
      public function DayBonusUI()
      {
         var _loc1_:int = 0;
         var _loc2_:IconItemBag = null;
         var _loc3_:IconItem = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.coinBonus = 0;
         barVipExp.gotoAndStop(1);
         this.bags = new Array();
         for each(_loc1_ in [4,2,1])
         {
            _loc2_ = new IconItemBag(this["bar" + _loc1_ + "xExp"],this,_loc1_);
            _loc2_.lockDrag = true;
            _loc2_.addValidType(GameItemType.ALL);
            _loc3_ = IconItemManager.getIconItemByCode(WorldConfig.getValue("offlineBonus","itemCostPerHour" + _loc1_ + "x"),"");
            if(_loc3_)
            {
               _loc2_.pushIconItem(_loc3_);
            }
            this.bags.push(_loc2_);
         }
         this.addListener();
         if(WorldConfig.getValue("functionSwitch","showPlayerVIP"))
         {
            this.setChildIndex(vipBgBox,this.numChildren - 1);
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DayBonusUI","txtTitle");
         DiversityManager.setTextField(txtDeyOnlineCoin,"DayBonusUI","txtOnlineCoin");
         DiversityManager.setTextField(txtDeyCoin,"DayBonusUI","txtCoin");
         DiversityManager.setTextField(txtDeyCoinPrompt,"DayBonusUI","prompt_Coin");
         DiversityManager.setTextField(txtDeyOfflineBonus,"DayBonusUI","txtOfflineBonus");
         DiversityManager.setTextField(txtDeyOfflineTime,"DayBonusUI","txtOfflineTime");
         DiversityManager.setTextField(txtDeyCanGetOfflineBonus,"DayBonusUI","txtCanGetOfflineBonus");
         DiversityManager.setTextField(txtDey4xPrompt,"DayBonusUI","txtOfflineExpPrompt4x");
         DiversityManager.setTextField(txtDey2xPrompt,"DayBonusUI","txtOfflineExpPrompt2x");
         DiversityManager.setTextField(txtDey1xPrompt,"DayBonusUI","txtOfflineExpPrompt1x");
         DiversityManager.setTextField(txtDeyVip,"DayBonusUI","txtVip");
         DiversityManager.setTextField(txtDeyVipLevel,"DayBonusUI","txtVipLevel");
         DiversityManager.setTextField(txtDeyVipExp,"DayBonusUI","txtVipExp");
         DiversityManager.setTextField(txtVipPrompt,"DayBonusUI","txtVipPrompt");
         cmdCoin.label = DiversityManager.getString("DayBonusUI","cmdCoin");
         cmdToVIP.label = DiversityManager.getString("DayBonusUI","cmdToVIP");
         cmdExp4x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdExp2x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdExp1x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdInputBonusCode.label = DiversityManager.getString("DayBonusUI","cmdInputBonusCode");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdCoin.addEventListener(MouseEvent.CLICK,this.obf_q_5_3697);
         cmdToVIP.addEventListener(MouseEvent.CLICK,this.onClickToVIP);
         cmdExp4x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp2x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp1x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdInputBonusCode.addEventListener(MouseEvent.CLICK,this.obf_O_J_3157);
         obf_K_e_3075.addUIMouseToolTip(txtVipExp,"Vip_AddExp");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdCoin.removeEventListener(MouseEvent.CLICK,this.obf_q_5_3697);
         cmdToVIP.removeEventListener(MouseEvent.CLICK,this.onClickToVIP);
         cmdExp4x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp2x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp1x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdInputBonusCode.removeEventListener(MouseEvent.CLICK,this.obf_O_J_3157);
         obf_K_e_3075.removeUIMouseToolTip(txtVipExp);
      }
      
      public function get coinBonus() : int
      {
         return this._coin;
      }
      
      public function set coinBonus(param1:int) : void
      {
         this._coin = param1;
         txtCoin.text = param1 + "";
         cmdCoin.enabled = this._coin > 0;
      }
      
      public function get offlineExp() : int
      {
         return this._offlineExp;
      }
      
      public function set offlineExp(param1:int) : void
      {
         this._offlineExp = param1;
         DiversityManager.setTextField(txt4xExp,"DayBonusUI","offlineExp",[param1 * 4],true);
         DiversityManager.setTextField(txt2xExp,"DayBonusUI","offlineExp",[param1 * 2],true);
         DiversityManager.setTextField(txt1xExp,"DayBonusUI","offlineExp",[param1 * 1],true);
         cmdExp4x.enabled = param1 > 0;
         cmdExp2x.enabled = param1 > 0;
         cmdExp1x.enabled = param1 > 0;
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
      
      public function setOfflineTime(param1:int) : void
      {
         var _loc2_:IconItemBag = null;
         this._offlineTime = param1;
         DiversityManager.setTextField(txtOfflineTime,"DayBonusUI","offlineTime",[param1],true);
         for each(_loc2_ in this.bags)
         {
            if(_loc2_.haveIconItem)
            {
               _loc2_.haveIconItem.itemCount = this._offlineTime;
            }
         }
      }
      
      public function obf_e_9_2604(param1:PlayerVipCheckNotify = null) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:int = GameContext.localPlayer.fullInfo.vipLevel;
         var _loc3_:int = GameContext.localPlayer.fullInfo.vipExp;
         if(WorldConfig.getValue("vip","vipMode") == 1)
         {
            txtVipExpiredTime.htmlText = DiversityManager.getString("DayBonusUI",_loc2_ > 0 ? "prompt_VipActive" : "prompt_VipInactive");
         }
         var _loc4_:Array = WorldConfig.getValue("vip","vipLevelArray") as Array;
         var _loc5_:int = JSONUtil.getInt(_loc4_,[_loc2_,"paidMoney"]) - JSONUtil.getInt(_loc4_,[_loc2_ - 1,"paidMoney"]);
         _loc5_ = Math.max(_loc5_,0);
         var _loc6_:int = _loc3_ - JSONUtil.getInt(_loc4_,[_loc2_ - 1,"paidMoney"]);
         txtVipLevel.text = "";
         if(_loc2_ > 0)
         {
            txtVipLevel.htmlText = DiversityManager.getString("CommonPrompt","vipTitle",[_loc2_]);
         }
         txtVipExp.text = _loc6_ + "/" + _loc5_;
         var _loc7_:int = _loc6_ / _loc5_ * 100;
         barVipExp.gotoAndStop(_loc7_);
         txtVipPrompt.htmlText = JSONUtil.getStr(_loc4_,[_loc2_ - 1,"funIntro"],txtVipPrompt.htmlText);
         obf_M_f_995.update();
      }
      
      private function obf_q_5_3697(param1:Event) : void
      {
         if(this._coin <= 0)
         {
            return;
         }
         obf_v_1_1352.sendGetOnlineCoin();
      }
      
      private function onClickToVIP(param1:Event) : void
      {
         obf_C_o_3363.openActionURL("ToVip");
      }
      
      private function obf_m_Y_3488(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.currentTarget == cmdExp4x)
         {
            _loc2_ = WorldConfig.getValue("offlineBonus","itemCostPerHour4x");
            if(!obf_L_l_4100.isEmpty(_loc2_) && obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < this._offlineTime)
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("DayBonusUI","offlineExpError_NeedItem",[GameItemManager.getItemName(_loc2_),this._offlineTime,4]),this,new Point(0,-100));
               return;
            }
            obf_v_1_1352.obf_D_V_3352(4);
         }
         else if(param1.currentTarget == cmdExp2x)
         {
            _loc3_ = WorldConfig.getValue("offlineBonus","itemCostPerHour2x");
            if(!obf_L_l_4100.isEmpty(_loc3_) && obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < this._offlineTime)
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("DayBonusUI","offlineExpError_NeedItem",[GameItemManager.getItemName(_loc3_),this._offlineTime,2]),this,new Point(0,-100));
               return;
            }
            obf_v_1_1352.obf_D_V_3352(2);
         }
         else if(param1.currentTarget == cmdExp1x)
         {
            _loc4_ = WorldConfig.getValue("offlineBonus","itemCostPerHour1x");
            if(!obf_L_l_4100.isEmpty(_loc4_) && obf_K_e_3075.playerBagUI.getItemCount(_loc4_) < this._offlineTime)
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("DayBonusUI","offlineExpError_NeedItem",[GameItemManager.getItemName(_loc4_),this._offlineTime,1]),this,new Point(0,-100));
               return;
            }
            obf_v_1_1352.obf_D_V_3352(1);
         }
      }
      
      private function obf_O_J_3157(param1:Event) : void
      {
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("MiscPrompt","inputCDKey")),obf_0_5_9_486.confirmUseGiftCDKEY);
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
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
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

