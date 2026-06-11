package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.utils.getTimer;
   
   public class RemotePlayerBuffer
   {
      
      private static var _remoteBuffer:Object = new Object();
      
      private static var _remoteBufferMaxCount:int = 20;
      
      private static var _remoteBufferCount:int = 0;
      
      public function RemotePlayerBuffer()
      {
         super();
      }
      
      public static function addRemoteToBuffer(param1:RemotePlayer) : Boolean
      {
         if(!_remoteBuffer[param1.id])
         {
            param1.bufferTime = getTimer();
            ++_remoteBufferCount;
            _remoteBuffer[param1.id] = param1;
            return true;
         }
         return false;
      }
      
      public static function removeRemoteFromBuffer(param1:String) : void
      {
         if(_remoteBuffer[param1])
         {
            delete _remoteBuffer[param1];
            --_remoteBufferCount;
         }
      }
      
      public static function getRemoteFromBuffer(param1:String) : RemotePlayer
      {
         return _remoteBuffer[param1];
      }
      
      public static function scanBufferOverload() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:RemotePlayer = null;
         if(_remoteBufferCount > _remoteBufferMaxCount)
         {
            _loc1_ = new Array();
            for(_loc2_ in _remoteBuffer)
            {
               _loc1_.push({
                  "time":_remoteBuffer[_loc2_].bufferTime,
                  "id":_loc2_
               });
            }
            _loc1_.sortOn("time");
            _loc3_ = _remoteBufferCount - _remoteBufferMaxCount;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _remoteBuffer[_loc1_.shift().id];
               if(_loc5_.parent)
               {
                  obf_x_0_1295.obf_r_w_3556("Waring. Has parent RemoteObject(" + _loc5_.id + ") was destored from RemoteBuffer!");
               }
               _loc5_.destroy();
               removeRemoteFromBuffer(_loc5_.id);
               obf_x_0_1295.obf_r_w_3556("Buffered Remote(" + _loc5_.id + ") destrored");
               _loc4_++;
            }
         }
      }
   }
}

