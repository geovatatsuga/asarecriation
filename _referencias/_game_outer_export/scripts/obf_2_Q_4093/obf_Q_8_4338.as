package obf_2_Q_4093
{
   import obf_0_6_Z_584.obf_5_M_1027;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import playerUI.VarShopOneUIMC;
   
   public class obf_Q_8_4338 extends VarShopOneUIMC implements IIconItemUI
   {
      
      private var _itemConfig:Object;
      
      public var iconBag:IconItemBag;
      
      public function obf_Q_8_4338()
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
         cmdBuy.label = DiversityManager.getString("varShopBoxUI","cmdBuy");
      }
      
      public function obf_5_d_847(param1:Object) : void
      {
         this._itemConfig = param1;
         var _loc2_:String = JSONUtil.getStr(param1,["itemCode"]);
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(_loc2_,"");
         if(!_loc3_)
         {
            return;
         }
         this.iconBag.pushIconItem(_loc3_);
         txtName.text = GameItemManager.getItemName(_loc2_);
         txtPrice.text = JSONUtil.getInt(param1,["price"]) + "";
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_0_3_s_174);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_0_3_s_174);
      }
      
      public function obf_0_3_s_174(param1:MouseEvent) : void
      {
         if(!this._itemConfig)
         {
            return;
         }
         var _loc2_:VarShopBoxUI = obf_K_e_3075.varShopBoxUI;
         var _loc3_:Object = obf_5_M_1027.shopTypes[_loc2_.id];
         var _loc4_:int = int(GameContext.localPlayer.dynamicVars.intVars[JSONUtil.getStr(_loc3_,["var"])]);
         if(_loc4_ < JSONUtil.getInt(this._itemConfig,["price"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("varShopBoxUI","noBuy"));
         }
         var _loc5_:String = JSONUtil.getStr(this._itemConfig,["itemCode"]);
         obf_5_M_1027.obf_e_f_2690(_loc2_.id,_loc2_.kind,_loc5_);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
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

