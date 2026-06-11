package obf_g_v_3502
{
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
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.LeaveHortationUIMC;
   
   public class obf_9_I_2505 extends LeaveHortationUIMC implements IIconItemUI
   {
      
      private var _offlineExp:int;
      
      private var _offlineTime:int;
      
      private var bags:Array;
      
      public function obf_9_I_2505()
      {
         var _loc1_:int = 0;
         var _loc2_:IconItemBag = null;
         var _loc3_:IconItem = null;
         super();
         this.initDiversity();
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
      }
      
      private function addListener() : void
      {
         cmdExp4x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp2x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp1x.addEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdInputBonusCode.addEventListener(MouseEvent.CLICK,this.obf_O_J_3157);
      }
      
      private function removeListener() : void
      {
         cmdExp4x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp2x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdExp1x.removeEventListener(MouseEvent.CLICK,this.obf_m_Y_3488);
         cmdInputBonusCode.removeEventListener(MouseEvent.CLICK,this.obf_O_J_3157);
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
      
      private function obf_m_Y_3488(param1:MouseEvent) : void
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
      
      private function obf_O_J_3157(param1:MouseEvent) : void
      {
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("MiscPrompt","inputCDKey")),obf_0_5_9_486.confirmUseGiftCDKEY);
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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
         DiversityManager.setTextField(txtDeyOfflineTime,"DayBonusUI","txtOfflineTime");
         DiversityManager.setTextField(txtDey4Bonus,"DayBonusUI","txtDey4Bonus");
         DiversityManager.setTextField(txtDey2Bonus,"DayBonusUI","txtDey2Bonus");
         DiversityManager.setTextField(txtDey1Bonus,"DayBonusUI","txtDey1Bonus");
         DiversityManager.setTextField(txtDey4xPrompt,"DayBonusUI","txtOfflineExpPrompt4x");
         DiversityManager.setTextField(txtDey2xPrompt,"DayBonusUI","txtOfflineExpPrompt2x");
         DiversityManager.setTextField(txtDey1xPrompt,"DayBonusUI","txtOfflineExpPrompt1x");
         cmdExp4x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdExp2x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdExp1x.label = DiversityManager.getString("DayBonusUI","cmdExp");
         cmdInputBonusCode.label = DiversityManager.getString("DayBonusUI","cmdInputBonusCode");
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
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
      }
   }
}

