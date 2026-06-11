package
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.utils.JSONUtil;
   import flash.external.ExternalInterface;
   
   public class obf_r_8_1121
   {
      
      private static var parameters:Object;
      
      public function obf_r_8_1121()
      {
         super();
      }
      
      public static function getParameter(param1:Array, param2:String = "") : String
      {
         if(ExternalInterface.available)
         {
            return JSONUtil.getStr(GameContext.gameStage.loaderInfo.parameters,param1,param2);
         }
         return JSONUtil.getStr(parameters,param1,param2);
      }
      
      public static function setParameters(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         parameters = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            switch(_loc2_)
            {
               case 0:
                  parameters["host"] = param1[0];
                  break;
               case 1:
                  parameters["sso"] = param1[1];
                  break;
               case 2:
                  parameters["sid"] = param1[2];
                  break;
               case 3:
                  parameters["cookie"] = param1[3];
            }
            _loc2_++;
         }
      }
   }
}

