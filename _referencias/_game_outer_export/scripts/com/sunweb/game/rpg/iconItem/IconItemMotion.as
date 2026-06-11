package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.MagicMotionManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class IconItemMotion extends IconItem
   {
      
      private var _config:Object;
      
      public function IconItemMotion(param1:DisplayObject, param2:String)
      {
         super(param1);
         itemCode = param2;
         addType(GameItemType.MOTION);
         this._config = MagicMotionManager.getMagicMotionConfig(param2);
      }
      
      public static function getNewIconItem(param1:String) : IconItemMotion
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Object = MagicMotionManager.getMagicMotionConfig(param1);
         if(!_loc2_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4838(" + param1 + ")obf___4949！");
            return null;
         }
         _loc3_ = ResourceManager.instance.getDisplayObject(_loc2_.icon);
         if(!_loc3_)
         {
            _loc3_ = new Bitmap(new nullItemIcon(1,1));
         }
         var _loc4_:IconItemMotion = new IconItemMotion(_loc3_,param1);
         _loc4_.itemName = _loc2_.name;
         return _loc4_;
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         return MagicMotionManager.sendMagicMotion(itemCode);
      }
      
      override public function clone() : IconItem
      {
         return getNewIconItem(itemCode);
      }
      
      override public function showTipInfo(param1:IconItemBag) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("Items");
         var _loc3_:int = 180;
         _loc2_.addTipInfo("<P align=\'center\'>" + this._config.name + "</P>",_loc3_,1);
         if(Boolean(this._config.spCost) && this._config.spCost > 0)
         {
            _loc2_.addTipInfo("<font color=\'#EAEA00\'>SP:" + this._config.spCost + "</font>",_loc3_,_loc2_.maxRow + 2);
         }
         if(this._config.remark)
         {
            _loc2_.addTipInfo(this._config.remark,_loc3_,_loc2_.maxRow + 2);
         }
         GameTipManager.showTip(_loc2_);
      }
   }
}

