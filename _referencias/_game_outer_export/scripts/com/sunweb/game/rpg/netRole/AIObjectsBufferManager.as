package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   
   public class AIObjectsBufferManager
   {
      
      private static var resBags:Object = new Object();
      
      public function AIObjectsBufferManager()
      {
         super();
      }
      
      public static function getResBag(param1:String) : ResourceBag
      {
         var _loc2_:ResourceBag = resBags[param1];
         if(!_loc2_)
         {
            _loc2_ = ResourceManager.instance.getBag(param1,true);
         }
         resBags[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function clearBag() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in resBags)
         {
            ResourceManager.instance.destroyBag(_loc1_);
         }
         resBags = new Object();
      }
   }
}

