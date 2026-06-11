package com.sunweb.game.util
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.crypto.symmetric.DESKey;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class obf_m_V_1111
   {
      
      private static var defaultDesKey:DESKey = new DESKey(Hex.toArray("6bc89fe7d5a0f35f"));
      
      public function obf_m_V_1111()
      {
         super();
      }
      
      public static function obf_0_I_1938(param1:ByteArray, param2:ByteArray = null) : void
      {
         var _loc3_:DESKey = null;
         if(param2 == null)
         {
            defaultDesKey.encrypt(param1);
         }
         else
         {
            _loc3_ = new DESKey(param2);
            _loc3_.encrypt(param1);
         }
      }
      
      public static function decryptDES(param1:ByteArray, param2:ByteArray = null) : void
      {
         var _loc3_:DESKey = null;
         if(param2 == null)
         {
            defaultDesKey.decrypt(param1);
         }
         else
         {
            _loc3_ = new DESKey(param2);
            _loc3_.decrypt(param1);
         }
      }
      
      public static function md5(param1:ByteArray) : String
      {
         var _loc2_:MD5 = new MD5();
         return Hex.fromArray(_loc2_.hash(param1));
      }
      
      public static function md5Str(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return md5(_loc2_);
      }
      
      public static function sha1(param1:ByteArray) : String
      {
         var _loc2_:SHA1 = new SHA1();
         return Hex.fromArray(_loc2_.hash(param1));
      }
      
      public static function sha1Str(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return sha1(_loc2_);
      }
      
      public static function byte2hex(param1:ByteArray) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = uint(param1[_loc4_]).toString(16);
            if(_loc3_.length == 1)
            {
               _loc2_ += "0" + _loc3_;
            }
            else
            {
               _loc2_ += _loc3_;
            }
            _loc4_++;
         }
         return _loc2_.toUpperCase();
      }
   }
}

