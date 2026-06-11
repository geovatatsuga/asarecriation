package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class AnimalEnterMapAnswer extends obf_O_8_1034
   {
      
      public var toMapId:String;
      
      public var toPosition:MapPoint;
      
      public function AnimalEnterMapAnswer()
      {
         super(CommandCodePlayerAnimal.ANIMAL_ENTER_TRAINER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["toMapId:string","toPosition:com.sunweb.game.rpg.world.map.MapPoint"];
      }
   }
}

