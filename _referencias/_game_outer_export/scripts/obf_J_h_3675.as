package
{
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   
   public class obf_J_h_3675
   {
      
      public function obf_J_h_3675()
      {
         super();
      }
      
      public static function loadLocalResource(param1:String) : ByteArray
      {
         var _loc2_:File = File.documentsDirectory.resolvePath("./mszj-Asa" + param1);
         if(!_loc2_.exists)
         {
            return null;
         }
         var _loc3_:FileStream = new FileStream();
         _loc3_.open(_loc2_,FileMode.READ);
         var _loc4_:ByteArray = new ByteArray();
         _loc3_.readBytes(_loc4_);
         _loc3_.close();
         return _loc4_;
      }
      
      public static function saveLocalResource(param1:ByteArray, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:File = File.documentsDirectory.resolvePath("./mszj-Asa" + param2);
         var _loc4_:FileStream = new FileStream();
         _loc4_.open(_loc3_,FileMode.WRITE);
         _loc4_.writeBytes(param1);
         _loc4_.close();
      }
   }
}

