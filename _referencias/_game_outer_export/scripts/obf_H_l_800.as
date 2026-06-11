package
{
   import flash.external.ExternalInterface;
   
   public class obf_H_l_800
   {
      
      public function obf_H_l_800()
      {
         super();
      }
      
      public static function call(param1:String, ... rest) : *
      {
         if(ExternalInterface.available)
         {
            return ExternalInterface.call(param1,rest);
         }
         return null;
      }
      
      public static function addCallback(param1:String, param2:Function) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback(param1,param2);
         }
      }
   }
}

