package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
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
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.RewardShopBoxOneMC;
   
   public class obf_S_4645 extends RewardShopBoxOneMC implements IIconItemUI
   {
      
      private var _itemConfig:Object;
      
      public var iconBag:IconItemBag;
      
      public function obf_S_4645()
      {
         super();
         this.initDiversity();
         this.iconBag = new IconItemBag(iconBar,this,0);
         this.iconBag.addValidType(GameItemType.ALL);
         this.iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function get itemConfig() : Object
      {
         return this._itemConfig;
      }
      
      public function setItemConfig(param1:Object) : void
      {
         this._itemConfig = param1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtSp,"rewardShopBoxUI","txtSp");
         cmdBuy.label = DiversityManager.getString("rewardShopBoxUI","cmdBuy");
      }
      
      public function obf_5_d_847(param1:Object) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         this._itemConfig = param1;
         var _loc2_:String = JSONUtil.getStr(param1,["code"]);
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(_loc2_,"");
         if(!_loc3_)
         {
            return;
         }
         this.iconBag.pushIconItem(_loc3_);
         txtName.text = GameItemManager.getItemName(_loc2_);
         var _loc4_:int = JSONUtil.getInt(param1,["sp"]);
         txtSpNum.text = _loc4_ + "";
         var _loc5_:Object = JSONUtil.getObject(param1,["items"]);
         for(_loc6_ in _loc5_)
         {
            _loc8_ = GameItemManager.getItemName(_loc6_);
            txtItem.htmlText = obf_Z_j_930.getItemLinkCode(_loc8_,_loc6_);
            _loc9_ = int(_loc5_[_loc6_]);
            txtItemNum.text = "x" + _loc9_;
         }
         _loc7_ = this.getRankName(JSONUtil.getInt(param1,["rank"]));
         DiversityManager.setTextField(txtCondition,"rewardShopBoxUI","txtCondition",[_loc7_]);
      }
      
      public function getRankName(param1:int) : String
      {
         var _loc2_:Object = obf_Z_j_930.obf_0_y_1225[param1 - 1];
         return JSONUtil.getStr(_loc2_,["name"]);
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_0_3_s_174);
         txtItem.addEventListener(TextEvent.LINK,this.onInfoLink);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_0_3_s_174);
         txtItem.removeEventListener(TextEvent.LINK,this.onInfoLink);
      }
      
      public function obf_0_3_s_174(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         if(!this._itemConfig)
         {
            return;
         }
         var _loc2_:int = JSONUtil.getInt(this._itemConfig,["rank"]);
         if(obf_K_e_3075.obf_w_0_3587.getRank < _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardShopBoxUI","txtCondition",[this.getRankName(_loc2_)]));
            return;
         }
         var _loc3_:int = JSONUtil.getInt(this._itemConfig,["sp"]);
         if(GameContext.localPlayer.fullInfo.attributes.sp < _loc3_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardShopBoxUI","noSp"));
            return;
         }
         var _loc4_:Object = JSONUtil.getObject(this._itemConfig,["items"]);
         if(_loc4_)
         {
            for(_loc6_ in _loc4_)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc6_) < _loc4_[_loc6_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("rewardShopBoxUI","noItem"));
                  return;
               }
            }
         }
         var _loc5_:String = JSONUtil.getStr(this._itemConfig,["code"]);
         obf_Z_j_930.obf_N_4662(_loc5_);
      }
      
      public function onInfoLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

