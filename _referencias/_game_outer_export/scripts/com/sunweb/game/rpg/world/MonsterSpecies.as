package com.sunweb.game.rpg.world
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import flash.display.DisplayObject;
   import img.HeadIcon_000;
   
   public class MonsterSpecies
   {
      
      public static const HUMAN:int = 0;
      
      public static const NATURE:int = 1;
      
      public static const DEMON:int = 2;
      
      public static const ELEMENT:int = 3;
      
      public static const UNDEAD:int = 4;
      
      public static const GOD:int = 5;
      
      private static var obf_E_R_3538:Array = [HUMAN,NATURE,DEMON,ELEMENT,UNDEAD];
      
      public function MonsterSpecies()
      {
         super();
      }
      
      public static function getMonsterSpeciesIcon(param1:int) : DisplayObject
      {
         if(param1 == HUMAN)
         {
            return ResourceManager.instance.getDisplayObject("c02@ta2");
         }
         if(param1 == NATURE)
         {
            return ResourceManager.instance.getDisplayObject("c01@ta2");
         }
         if(param1 == DEMON)
         {
            return ResourceManager.instance.getDisplayObject("c05@ta2");
         }
         if(param1 == ELEMENT)
         {
            return ResourceManager.instance.getDisplayObject("c06@ta2");
         }
         if(param1 == UNDEAD)
         {
            return ResourceManager.instance.getDisplayObject("c04@ta2");
         }
         if(param1 == GOD)
         {
            return ResourceManager.instance.getDisplayObject("c03@ta2");
         }
         return new HeadIcon_000();
      }
      
      public static function getSpeciesName(param1:int) : String
      {
         return DiversityManager.getString("MonsterSpecies",param1 + "");
      }
      
      public static function getRestraintSpecies(param1:int) : int
      {
         var _loc2_:int = obf_E_R_3538.indexOf(param1);
         if(_loc2_ <= -1)
         {
            return -1;
         }
         var _loc3_:int = _loc2_ + 1;
         if(_loc3_ >= obf_E_R_3538.length)
         {
            _loc3_ = 0;
         }
         return obf_E_R_3538[_loc3_];
      }
   }
}

