package com.sunweb.game.rpg.buff
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   
   public class BuffManager
   {
      
      private static var buffConfig:Object;
      
      public function BuffManager()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         buffConfig = new Object();
         for each(_loc2_ in param1)
         {
            buffConfig[_loc2_.buffId] = _loc2_;
         }
      }
      
      public static function getBuffConfigById(param1:int) : Object
      {
         return buffConfig[param1 + ""];
      }
      
      public static function getBuffName(param1:int) : String
      {
         var _loc2_:Object = getBuffConfigById(param1);
         return JSONUtil.getStr(_loc2_,["buffName"]);
      }
      
      public static function getBuffIcon(param1:int) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Object = getBuffConfigById(param1);
         if(_loc2_)
         {
            _loc3_ = ResourceManager.instance.getDisplayObject(_loc2_.iconRes);
         }
         if(!_loc3_)
         {
            _loc3_ = new Bitmap(new nullItemIcon(1,1));
         }
         if(_loc3_ is InteractiveObject)
         {
            InteractiveObject(_loc3_).mouseEnabled = false;
         }
         if(_loc3_ is DisplayObjectContainer)
         {
            DisplayObjectContainer(_loc3_).mouseChildren = false;
         }
         return _loc3_;
      }
      
      public static function showBuffTip(param1:int) : void
      {
         var _loc2_:Object = getBuffConfigById(param1);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 180;
         var _loc4_:GameTipUI = new GameTipUI("Buff");
         _loc4_.addTipInfo("<p align=\'center\'><font color=\'#" + obf_0_3_0_538.obf_J_P_1631.toString(16) + "\'>" + JSONUtil.getStr(_loc2_,["buffName"]) + "</font></p>",_loc3_,1);
         _loc4_.addTipInfo(JSONUtil.getStr(_loc2_,["buffDetail"]),_loc3_,_loc4_.maxRow + 2);
         GameTipManager.showTip(_loc4_);
      }
   }
}

