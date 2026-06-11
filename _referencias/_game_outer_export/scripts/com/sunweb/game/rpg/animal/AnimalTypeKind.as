package com.sunweb.game.rpg.animal
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class AnimalTypeKind
   {
      
      public static const DEFEND:int = 0;
      
      public static const ATTACK:int = 1;
      
      public static const ASSISTANT:int = 2;
      
      public static const DOT_STYLE:int = 3;
      
      public function AnimalTypeKind()
      {
         super();
      }
      
      public static function getAnimalShow(param1:int) : String
      {
         switch(param1)
         {
            case DEFEND:
               return DiversityManager.getString("AnimalTypeKind","DEFEND");
            case ATTACK:
               return DiversityManager.getString("AnimalTypeKind","ATTACK");
            case ASSISTANT:
               return DiversityManager.getString("AnimalTypeKind","ASSISTANT");
            case DOT_STYLE:
               return DiversityManager.getString("AnimalTypeKind","DOT_STYLE");
            default:
               return "";
         }
      }
   }
}

