package com.sunweb.game.rpg.world.ui
{
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.util.TimeLimiter;
   
   public class ViewPortManager
   {
      
      private static var _mapManager:MapManager;
      
      private static var _player:obf_U_6_3454;
      
      private static var _intervalTime:TimeLimiter = new TimeLimiter(50);
      
      public function ViewPortManager()
      {
         super();
      }
      
      public static function init(param1:MapManager, param2:obf_U_6_3454) : void
      {
         _mapManager = param1;
         _player = param2;
         if(_mapManager.map)
         {
            _mapManager.map.setViewPortCenterToObject(_player,true);
         }
      }
      
      public static function showViewPort() : void
      {
         if(!_intervalTime.checkTimeout() || !_mapManager || !_mapManager.map || !_player)
         {
            return;
         }
         _mapManager.map.setViewPortCenterToObject(_player);
      }
   }
}

