package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.util.TimeLimiter;
   
   public class GameItemInfoManager
   {
      
      private static var itemsInfo:Object = new Object();
      
      private static var infoTime:Object = new Object();
      
      public function GameItemInfoManager()
      {
         super();
      }
      
      public static function addItemInfo(param1:GameItemFullInfo, param2:String, param3:int = 10000) : void
      {
         if(!param1)
         {
            param1 = new GameItemFullInfo();
            param1.itemId = param2;
            param1.isEmpty = true;
         }
         itemsInfo[param2] = param1;
         if(param3 > 0)
         {
            infoTime[param2] = new TimeLimiter(param3);
         }
      }
      
      public static function removeItemInfo(param1:String) : void
      {
         delete infoTime[param1];
         delete itemsInfo[param1];
      }
      
      public static function getItemInfo(param1:String) : GameItemFullInfo
      {
         if(!infoTime[param1] || !infoTime[param1].checkTimeout())
         {
            return itemsInfo[param1];
         }
         delete infoTime[param1];
         delete itemsInfo[param1];
         return null;
      }
   }
}

