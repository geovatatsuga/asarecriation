package obf_d_v_1084
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class BossTypeList
   {
      
      public static var NOMAL:int = 0;
      
      public static var MAGIC:int = 1;
      
      public static var FANTASY:int = 2;
      
      public static var EPIC:int = 3;
      
      public function BossTypeList()
      {
         super();
      }
      
      public static function getRankName(param1:int, param2:Boolean = false) : String
      {
         var _loc3_:String = "";
         if(!param2)
         {
            _loc3_ = DiversityManager.getString("bossFeedUI","se");
         }
         return DiversityManager.getString("bossFeedUI",param1 + "",[_loc3_]);
      }
   }
}

