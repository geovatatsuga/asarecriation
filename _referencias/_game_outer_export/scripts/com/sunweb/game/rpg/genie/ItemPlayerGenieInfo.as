package com.sunweb.game.rpg.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ItemPlayerGenieInfo extends obf_2_M_853
   {
      
      public var level:int = 1;
      
      public var exp:int = 0;
      
      public var physicsAttackAptAdded:int = 0;
      
      public var magicAttackAptAdded:int = 0;
      
      public var physicsDefenseAptAdded:int = 0;
      
      public var magicDefenseAptAdded:int = 0;
      
      public var lifeAptAdded:int = 0;
      
      public var cureAptAdded:int = 0;
      
      public var upgradeRate:int = 0;
      
      public function ItemPlayerGenieInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["level:byte","exp:int","physicsAttackAptAdded:short","magicAttackAptAdded:short","physicsDefenseAptAdded:short","magicDefenseAptAdded:short","lifeAptAdded:short","cureAptAdded:short","upgradeRate:short"];
      }
   }
}

