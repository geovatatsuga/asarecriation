package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.pet.CommandCodePlayerPet;
   
   public class PetEventType
   {
      
      public static const PET_CHECK_NOTIFY:String = CommandCodePlayerPet.PET_CHECK_NOTIFY.toString(16);
      
      public static const PET_ATTR_INT_CHANGE_NOTIFY:String = CommandCodePlayerPet.PET_ATTR_INT_CHANGE_NOTIFY.toString(16);
      
      public static const PET_USE_SKILL_NOTIFY:String = CommandCodePlayerPet.PET_USE_SKILL_NOTIFY.toString(16);
      
      public static const PET_LEARN_SKILL_ANSWER:String = CommandCodePlayerPet.PET_LEARN_SKILL_ANSWER.toString(16);
      
      public static const PET_HP_CHANGE_NOTIFY:String = CommandCodePlayerPet.PET_HP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY:String = CommandCodePlayerPet.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY.toString(16);
      
      public static const PET_ENHANCE_ANSWER:String = CommandCodePlayerPet.PET_ENHANCE_ANSWER.toString(16);
      
      public static const PET_FUSION_ANSWER:String = CommandCodePlayerPet.PET_FUSION_ANSWER.toString(16);
      
      public function PetEventType()
      {
         super();
      }
   }
}

