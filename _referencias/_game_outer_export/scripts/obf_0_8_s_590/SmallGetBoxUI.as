package obf_0_8_s_590
{
   import obf_l_I_3561.obf_g_0_3344;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import playerUI.SmallGetBoxUIMC;
   
   public class SmallGetBoxUI extends SmallGetBoxUIMC
   {
      
      private var _iconBag:IconItemBag;
      
      private var condition:Object;
      
      private var type:int;
      
      private var isShowTip:Boolean;
      
      public function SmallGetBoxUI(param1:IIconItemUI, param2:int, param3:Object = null, param4:Boolean = false)
      {
         super();
         this.type = param2;
         this.condition = param3;
         this.isShowTip = param4;
         this._iconBag = new IconItemBag(icon,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.showInfoTip = this.isShowTip;
         this._iconBag.lockDrag = true;
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         if(this.type == 3)
         {
            _loc1_ = JSONUtil.getInt(this.condition,["totalNum"]);
            conditionTxt.htmlText = DiversityManager.getString("SmallGetBoxUI","hasBuy",[_loc1_]);
            conditionTxt.textColor = obf_g_0_3344.buyNum >= _loc1_ ? 3407616 : 16711680;
         }
         else
         {
            _loc2_ = JSONUtil.getValue(this.condition,["condition"]) as Object;
            _loc3_ = JSONUtil.getInt(_loc2_,["roleLevel>="]);
            conditionTxt.htmlText = ConditionScript.getConditionHTML("roleLevel>=",_loc3_);
            conditionTxt.textColor = GameContext.localPlayer.fullInfo.level >= _loc3_ ? 3407616 : 16711680;
         }
         moneyTxt.text = JSONUtil.getStr(this.condition,["explanation"]);
         cmdBuy.label = DiversityManager.getString("MonthCardUI","get");
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(this.condition)
         {
            _loc2_ = JSONUtil.getValue(this.condition,["condition"]) as Object;
         }
         if(this.type == 1)
         {
            if(!obf_g_0_3344.isbuyFund)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("SmallGetBoxUI","noBuy"));
               return;
            }
            if(ConditionScript.checkCondition(_loc2_,null,true))
            {
               obf_g_0_3344.sendFundRewardRequest(JSONUtil.getStr(this.condition,["id"]));
            }
         }
         else if(this.type == 2)
         {
            if(!obf_g_0_3344.isbuyLocalTyrantFund)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("SmallGetBoxUI","noBuy"));
               return;
            }
            if(ConditionScript.checkCondition(_loc2_,null,true))
            {
               obf_g_0_3344.sendFundRewardRequest(JSONUtil.getStr(this.condition,["id"]));
            }
         }
         else if(this.type == 3)
         {
            if(obf_g_0_3344.buyNum >= JSONUtil.getInt(this.condition,["totalNum"]))
            {
               obf_g_0_3344.sendBoonRewardRequest(JSONUtil.getStr(this.condition,["id"]));
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("SmallGetBoxUI","cantGet"));
            }
         }
      }
      
      public function obf_O_L_2941(param1:Boolean) : void
      {
         cmdBuy.label = param1 ? DiversityManager.getString("MonthCardUI","getted") : DiversityManager.getString("MonthCardUI","get");
         cmdBuy.mouseEnabled = !param1;
         cmdBuy.enabled = !param1;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
   }
}

