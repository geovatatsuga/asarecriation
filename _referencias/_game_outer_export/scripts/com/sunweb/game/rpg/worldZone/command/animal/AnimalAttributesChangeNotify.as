package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.animal.AnimalAttributesInfo;
   
   public class AnimalAttributesChangeNotify extends obf_O_8_1034
   {
      
      public var animal:AnimalAttributesInfo;
      
      public function AnimalAttributesChangeNotify()
      {
         super(CommandCodePlayerAnimal.ANIMAL_ATTRIBUTES_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["animal:com.sunweb.game.rpg.animal.AnimalAttributesInfo"];
      }
   }
}

