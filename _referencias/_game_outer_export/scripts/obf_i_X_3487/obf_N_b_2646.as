package obf_I_x_2551
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.SlotUIMC;
   
   public class obf_N_b_2646
   {
      
      private var obf_d_N_1472:SlotUIMC;
      
      private var _bag:IconItemBag;
      
      private var obf_X_Y_3310:Array;
      
      private var _index:int;
      
      private var itemConfig:Object;
      
      public function obf_N_b_2646(param1:obf_C_5_3793, param2:SlotUIMC, param3:Array, param4:int)
      {
         super();
         this.obf_d_N_1472 = param2;
         this.obf_d_N_1472.iconName.mouseEnabled = false;
         this.obf_X_Y_3310 = param3;
         this._index = param4;
         this._bag = new IconItemBag(this.obf_d_N_1472.icon,param1,this._index);
         this._bag.addValidType(GameItemType.ALL);
         this._bag.lockDrag = true;
      }
      
      public function get obf_Z_H_3327() : Array
      {
         return this.obf_X_Y_3310;
      }
      
      public function get item() : Object
      {
         return this.itemConfig;
      }
      
      public function setItem(param1:Object) : void
      {
         this.itemConfig = param1;
         var _loc2_:String = JSONUtil.getStr(param1,["code"]);
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(_loc2_,"");
         if(!_loc3_)
         {
            return;
         }
         this._bag.pushIconItem(_loc3_);
         this.obf_d_N_1472.iconName.htmlText = "<P><FONT COLOR=\'#" + GameItemRank.getRankColor(param1.rank).toString(16) + "\'>" + param1.name + "</FONT></P>";
      }
      
      public function get bag() : IconItemBag
      {
         return this._bag;
      }
      
      public function clearItem() : void
      {
         this.itemConfig = null;
         if(this._bag.haveIconItem)
         {
            this._bag.dropIconItem();
         }
         this.obf_d_N_1472.iconName.htmlText = "";
      }
      
      public function obf_0_1_R_518(param1:Event) : void
      {
         if(this._bag.haveIconItem)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_X_Y_3310.length)
         {
            if(_loc3_ > 0)
            {
               _loc2_ += ",";
            }
            if(this.obf_X_Y_3310[_loc3_] == 0)
            {
               _loc2_ += "<font color=\'#FF0000\'>" + DiversityManager.getString("pocketSlotUI","type0") + "</font>";
            }
            else if(this.obf_X_Y_3310[_loc3_] == 1)
            {
               _loc2_ += "<font color=\'#0096FF\'>" + DiversityManager.getString("pocketSlotUI","type1") + "</font>";
            }
            else if(this.obf_X_Y_3310[_loc3_] == 2)
            {
               _loc2_ += "<font color=\'#C8FFC8\'>" + DiversityManager.getString("pocketSlotUI","type2") + "</font>";
            }
            else if(this.obf_X_Y_3310[_loc3_] == 3)
            {
               _loc2_ += "<font color=\'#FFC800\'>" + DiversityManager.getString("pocketSlotUI","type3") + "</font>";
            }
            _loc3_++;
         }
         var _loc4_:GameTipUI = new GameTipUI("slotUITip");
         _loc4_.addTipInfo(DiversityManager.getString("pocketSlotUI","canPut",[_loc2_]),250,0);
         GameTipManager.showTip(_loc4_);
      }
      
      public function obf_F_O_2978(param1:Event) : void
      {
         GameTipManager.closeTip("slotUITip");
      }
      
      public function addListener() : void
      {
         this.obf_d_N_1472.icon.addEventListener(MouseEvent.MOUSE_OVER,this.obf_0_1_R_518);
         this.obf_d_N_1472.icon.addEventListener(MouseEvent.MOUSE_OUT,this.obf_F_O_2978);
      }
      
      public function removeListener() : void
      {
         this.obf_d_N_1472.icon.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_0_1_R_518);
         this.obf_d_N_1472.icon.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_F_O_2978);
      }
   }
}

