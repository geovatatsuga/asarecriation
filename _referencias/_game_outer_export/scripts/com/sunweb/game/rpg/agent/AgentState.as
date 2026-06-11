package com.sunweb.game.rpg.agent
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class AgentState
   {
      
      public static const WAITING:int = 0;
      
      public static const SELLING:int = 1;
      
      public static const SOLD:int = 2;
      
      public static const TIMEOUT:int = 3;
      
      public function AgentState()
      {
         super();
      }
      
      public static function getStateName(param1:int) : String
      {
         var _loc2_:Object = {
            (WAITING + ""):DiversityManager.getString("AgentItemUI","state_WAITING"),
            (SELLING + ""):DiversityManager.getString("AgentItemUI","state_SELLING"),
            (SOLD + ""):DiversityManager.getString("AgentItemUI","state_SOLD"),
            (TIMEOUT + ""):DiversityManager.getString("AgentItemUI","state_TIMEOUT")
         };
         return _loc2_[param1 + ""];
      }
   }
}

