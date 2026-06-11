package obf_g_v_3502
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerVipCheckNotify;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import playerUI.OnLineHortationUIMC;
   
   public class obf_p_3_4085 extends OnLineHortationUIMC implements IPlayerUI
   {
      
      private var _coin:int;
      
      public function obf_p_3_4085()
      {
         super();
         this.initDiversity();
         this._coin = 0;
         barVipExp.gotoAndStop(1);
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdCoin.addEventListener(MouseEvent.CLICK,this.obf_q_5_3697);
         cmdToVIP.addEventListener(MouseEvent.CLICK,this.onClickToVIP);
         obf_K_e_3075.addUIMouseToolTip(txtVipExp,"Vip_AddExp");
      }
      
      private function removeListener() : void
      {
         cmdCoin.removeEventListener(MouseEvent.CLICK,this.obf_q_5_3697);
         cmdToVIP.removeEventListener(MouseEvent.CLICK,this.onClickToVIP);
         obf_K_e_3075.removeUIMouseToolTip(txtVipExp);
      }
      
      public function obf_e_9_2604(param1:PlayerVipCheckNotify = null) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:int = GameContext.localPlayer.fullInfo.vipLevel;
         var _loc3_:int = GameContext.localPlayer.fullInfo.vipExp;
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
      
      private function obf_q_5_3697(param1:MouseEvent) : void
      {
         if(this._coin <= 0)
         {
            return;
         }
         obf_v_1_1352.sendGetOnlineCoin();
      }
      
      private function onClickToVIP(param1:MouseEvent) : void
      {
         obf_C_o_3363.openActionURL("ToVip");
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
         DiversityManager.setTextField(txtDeyOnlineCoin,"DayBonusUI","txtOnlineCoin");
         DiversityManager.setTextField(txtDeyCoin,"DayBonusUI","txtCoin");
         DiversityManager.setTextField(txtDeyCoinPrompt,"DayBonusUI","prompt_Coin");
         DiversityManager.setTextField(txtDeyVip,"DayBonusUI","txtVip");
         DiversityManager.setTextField(txtDeyVipLevel,"DayBonusUI","txtVipLevel");
         DiversityManager.setTextField(txtDeyVipExp,"DayBonusUI","txtVipExp");
         DiversityManager.setTextField(txtVipPrompt,"DayBonusUI","txtVipPrompt");
         cmdCoin.label = DiversityManager.getString("DayBonusUI","cmdCoin");
         cmdToVIP.label = DiversityManager.getString("DayBonusUI","cmdToVIP");
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

