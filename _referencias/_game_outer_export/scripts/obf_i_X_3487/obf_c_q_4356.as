package obf_I_x_2551
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.LockItemUIMC;
   
   public class obf_c_q_4356
   {
      
      private var _lockItem:LockItemUIMC;
      
      private var _itemConfig:Object;
      
      private var _bag:IconItemBag;
      
      public function obf_c_q_4356(param1:obf_z_4632, param2:LockItemUIMC, param3:int)
      {
         super();
         this._lockItem = param2;
         this._bag = new IconItemBag(this._lockItem.icon,param1,param3);
         this._bag.addValidType(GameItemType.ALL);
         this._bag.lockDrag = true;
         this.initDiversity();
         this.addListener();
      }
      
      public function get lockItem() : MovieClip
      {
         return this._lockItem;
      }
      
      public function get itemConfig() : Object
      {
         return this._itemConfig;
      }
      
      public function get bag() : IconItemBag
      {
         return this._bag;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this._lockItem.txtNum,"lockItemUI","txtNum");
         this._lockItem.cmdIn.label = DiversityManager.getString("lockItemUI","cmdIn");
         this._lockItem.cmdOut.label = DiversityManager.getString("lockItemUI","cmdOut");
      }
      
      public function addListener() : void
      {
         this._lockItem.cmdIn.addEventListener(MouseEvent.CLICK,this.obf_4_r_879);
         this._lockItem.cmdOut.addEventListener(MouseEvent.CLICK,this.obf_8_S_1706);
      }
      
      private function removeListener() : void
      {
         this._lockItem.cmdIn.removeEventListener(MouseEvent.CLICK,this.obf_4_r_879);
         this._lockItem.cmdOut.removeEventListener(MouseEvent.CLICK,this.obf_8_S_1706);
      }
      
      public function obf_4_r_879(param1:Event) : void
      {
         param1.stopPropagation();
         if(obf_K_e_3075.inOutItemUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.inOutItemUI);
         }
         else
         {
            obf_K_e_3075.inOutItemUI.setType(1);
            obf_K_e_3075.inOutItemUI.setItemConfig(this._itemConfig);
            obf_K_e_3075.showUI(obf_K_e_3075.inOutItemUI);
         }
      }
      
      public function obf_8_S_1706(param1:Event) : void
      {
         param1.stopPropagation();
         if(obf_K_e_3075.inOutItemUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.inOutItemUI);
         }
         else
         {
            obf_K_e_3075.inOutItemUI.setType(2);
            obf_K_e_3075.inOutItemUI.setItemConfig(this._itemConfig);
            obf_K_e_3075.showUI(obf_K_e_3075.inOutItemUI);
         }
      }
      
      public function setItem(param1:Object, param2:Number, param3:Boolean) : void
      {
         this._itemConfig = param1;
         if(this._bag.haveIconItem)
         {
            this._bag.dropIconItem();
         }
         var _loc4_:String = JSONUtil.getStr(param1,["code"]);
         var _loc5_:IconItem = IconItemManager.getIconItemByCode(_loc4_,"");
         if(!_loc5_)
         {
            return;
         }
         this._bag.pushIconItem(_loc5_);
         this._lockItem.iconName.htmlText = "<P><FONT COLOR=\'#" + GameItemRank.getRankColor(param1.rank).toString(16) + "\'>" + param1.name + "</FONT></P>";
         this._lockItem.txtNumValue.text = param2 + "";
         this._lockItem.cmdIn.enabled = param3;
         this._lockItem.cmdOut.enabled = param3;
      }
      
      public function clearItem() : void
      {
         this._itemConfig = null;
         if(this._bag.haveIconItem)
         {
            this._bag.dropIconItem();
         }
         this._lockItem.iconName.htmlText = "";
         this._lockItem.txtNumValue.text = "";
      }
   }
}

