package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   
   public class obf_0_8_w_387
   {
      
      public static var localPlayer:obf_0_M_3913 = null;
      
      public static var enabledObjectTypes:int = -1;
      
      public static var disabledObjectTypes:int = 0;
      
      public function obf_0_8_w_387()
      {
         super();
      }
      
      public static function isEnabled(param1:MapInteractiveObject) : Boolean
      {
         if(localPlayer == null)
         {
            return true;
         }
         return param1.isValidSkillTarget(localPlayer,enabledObjectTypes,disabledObjectTypes);
      }
   }
}

