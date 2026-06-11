package obf_E_p_2386
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   
   public class obf_S_Q_3707
   {
      
      public function obf_S_Q_3707()
      {
         super();
      }
      
      public static function getRebornSkillPoint(param1:int) : int
      {
         return WorldConfig.getValue("rebornConfig","rebornTimeArray",param1 - 1,"jobSkillPtAdded");
      }
      
      public static function getRebornAttrPTPoint(param1:int) : int
      {
         return WorldConfig.getValue("rebornConfig","rebornTimeArray",param1 - 1,"attrPtAdded");
      }
      
      public static function getRebornName(param1:int) : String
      {
         return DiversityManager.getString("PlayerReborn",param1 + "");
      }
   }
}

