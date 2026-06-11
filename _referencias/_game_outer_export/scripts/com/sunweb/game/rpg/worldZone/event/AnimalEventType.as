package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.animal.CommandCodePlayerAnimal;
   
   public class AnimalEventType
   {
      
      public static const ANIMAL_MOVE_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_MOVE_NOTIFY.toString(16);
      
      public static const ANIMAL_USE_SKILL_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_USE_SKILL_NOTIFY.toString(16);
      
      public static const ANIMAL_HP_CHANGE_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_HP_CHANGE_NOTIFY.toString(16);
      
      public static const ANIMAL_ATTRIBUTES_CHANGE_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_ATTRIBUTES_CHANGE_NOTIFY.toString(16);
      
      public static const ANIMAL_ENTER_TRAINER_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_ENTER_TRAINER_NOTIFY.toString(16);
      
      public static const ANIMAL_BUFF_CHANGE_NOTIFY:String = CommandCodePlayerAnimal.ANIMAL_BUFF_CHANGE_NOTIFY.toString(16);
      
      public function AnimalEventType()
      {
         super();
      }
   }
}

