package obf_0_3_h_199
{
   import obf_g_A_3629.ChatDecoder;
   import obf_q_S_2073.obf_O_a_3022;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearBonusAnswer;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearInfoCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearResultInfo;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearedNotify;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.PassBonusUIMC;
   
   public class PassBonusUI extends PassBonusUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var _mapId:String;
      
      private var _bonusIndex:int;
      
      private var _maxBonusIndex:int;
      
      private var _bagIndex:int;
      
      private var _clearRule:Object;
      
      private var obf_0_3_L_456:Boolean;
      
      public function PassBonusUI()
      {
         var _loc2_:IconItemBag = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = new IconItemBag(this.getChildByName("bag" + _loc1_) as MovieClip,this,_loc1_);
            _loc2_.lockDrag = false;
            _loc2_.addValidType(GameItemType.ALL);
            this.bags.push(_loc2_);
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         pointBonus.addEventListener(MouseEvent.CLICK,this.obf_m_m_2999);
         txtBonus.addEventListener(MouseEvent.CLICK,this.obf_m_m_2999);
         cmdCloseUI.addEventListener(MouseEvent.CLICK,this.onClose);
         txtBestPlayer.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         pointBonus.removeEventListener(MouseEvent.CLICK,this.obf_m_m_2999);
         txtBonus.removeEventListener(MouseEvent.CLICK,this.obf_m_m_2999);
         cmdCloseUI.removeEventListener(MouseEvent.CLICK,this.onClose);
         txtBestPlayer.removeEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         if(this.obf_0_3_L_456)
         {
            WindowManager.showConfirmBox(DiversityManager.getString("passBoxUI","confirmLeave"),this.obf_i_i_2042);
         }
         else
         {
            obf_K_e_3075.closeUI(this);
            obf_O_a_3022.sendLeave(this._mapId);
         }
      }
      
      private function obf_i_i_2042(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_K_e_3075.closeUI(this);
            obf_O_a_3022.sendLeave(this._mapId);
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
         param1.stopPropagation();
      }
      
      private function obf_m_m_2999(param1:MouseEvent) : void
      {
         if(!this._clearRule || !this._clearRule.clearBonusArray || this._clearRule.clearBonusArray.length <= this._bonusIndex)
         {
            return;
         }
         var _loc2_:String = this._clearRule.clearBonusArray[this._bonusIndex].costItemCode;
         if(!obf_L_l_4100.isEmpty(_loc2_))
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < 1)
            {
               if(!chkAutoBuy.selected)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("passBoxUI","lackMaterial",[GameItemManager.getItemName(_loc2_)]));
                  return;
               }
               ShopManager.sendStoreBuyItem(_loc2_,ShopManager.obf_B_9_2165,"",1);
            }
         }
         if(!obf_L_l_4100.isEmpty(_loc2_))
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < 1)
            {
               return;
            }
         }
         this.sendClearBonus();
      }
      
      public function onBonusItems(param1:MapClearBonusAnswer) : void
      {
         ++this._bonusIndex;
         this.obf_K_U_1327();
      }
      
      public function checkCleared(param1:MapClearedNotify) : void
      {
         obf_K_e_3075.closeUI(this);
         this.obf_h_L_4589();
         var _loc2_:Object = obf_O_a_3022.getMapConfig(param1.mapId);
         if(!_loc2_ || !_loc2_.clearBonusArray || _loc2_.clearBonusArray.length == 0)
         {
            return;
         }
         obf_K_e_3075.showUI(this);
         this._mapId = param1.mapId;
         this._clearRule = _loc2_;
         txtTime.text = obf_l_y_733.getTimeStringHHMMSS(param1.resultTimeInSec * 1000);
         this.obf_K_U_1327();
      }
      
      private function sendClearBonus() : void
      {
         if(pointBonus.numChildren > 0 && pointBonus.getChildAt(0) is MovieClip)
         {
            try
            {
               (pointBonus.getChildAt(0) as MovieClip).gotoAndStop(2);
            }
            catch(e:Error)
            {
            }
         }
         obf_O_a_3022.sendClearBonus(this._mapId,this._bonusIndex);
      }
      
      private function obf_K_U_1327() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc5_:String = null;
         var _loc6_:IconItem = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
            _loc1_.lockDrag = true;
            _loc1_.addValidType(GameItemType.ALL);
         }
         txtBonus.htmlText = DiversityManager.getString("passBoxUI","txtBonus0");
         this.obf_0_3_L_456 = false;
         chkAutoBuy.visible = false;
         if(!this._clearRule || !this._clearRule.clearBonusArray || this._clearRule.clearBonusArray.length <= this._bonusIndex)
         {
            return;
         }
         var _loc2_:String = this._clearRule.clearBonusArray[this._bonusIndex].costItemCode;
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            txtBonus.htmlText = DiversityManager.getString("passBoxUI","txtBonus");
         }
         else
         {
            txtBonus.htmlText = DiversityManager.getString("passBoxUI","txtBonus1",[ChatDecoder.decode("[i^" + _loc2_ + "]")]);
            chkAutoBuy.visible = true;
         }
         var _loc3_:Array = this._clearRule.clearBonusArray[this._bonusIndex].showItemList;
         var _loc4_:int = 0;
         for each(_loc5_ in _loc3_)
         {
            if(_loc4_ < this.bags.length)
            {
               _loc6_ = IconItemManager.getIconItemByCode(_loc5_,"");
               this.bags[_loc4_].pushIconItem(_loc6_);
               _loc4_++;
            }
         }
         this.obf_0_3_L_456 = true;
         while(pointBonus.numChildren > 0)
         {
            pointBonus.removeChildAt(0);
         }
         obf_0_P_4381.obf_m_X_1194(this._clearRule.clearBonusArray[this._bonusIndex].bonusIconRes,pointBonus);
      }
      
      public function obf_s_D_1287(param1:MapClearInfoCheckNotify) : void
      {
         var _loc3_:MapClearResultInfo = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc2_:Array = param1.bestResultList;
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            _loc3_ = _loc2_[0] as MapClearResultInfo;
            _loc4_ = "";
            if(_loc3_.players)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.players.split(",").length)
               {
                  _loc4_ += obf_7_6_4416.getRoleLinkA(_loc3_.players.split(",")[_loc5_]);
                  _loc5_++;
               }
            }
            txtBestPlayer.htmlText = _loc4_;
            txtBestTime.text = obf_l_y_733.getTimeStringHHMMSS(_loc3_.clearTimeInSec * 1000);
         }
      }
      
      public function obf_h_L_4589() : void
      {
         var _loc1_:IconItemBag = null;
         this._clearRule = null;
         this._bonusIndex = 0;
         this._bagIndex = 0;
         this._mapId = "";
         txtTime.text = "";
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
         while(pointBonus.numChildren > 0)
         {
            pointBonus.removeChildAt(0);
         }
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
         DiversityManager.setTextField(txtDeyTitle,"passBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyTime,"passBoxUI","txtDeyTime");
         DiversityManager.setTextField(txtDeyClearBonus,"passBoxUI","txtDeyClearBonus");
         chkAutoBuy.label = DiversityManager.getString("passBoxUI","chkAutoBuy");
         cmdCloseUI.label = DiversityManager.getString("passBoxUI","cmdCloseUI");
         DiversityManager.setTextField(txtDeyOne,"passBoxUI","txtDeyOne");
         DiversityManager.setTextField(txtDeyName,"passBoxUI","txtDeyName");
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

