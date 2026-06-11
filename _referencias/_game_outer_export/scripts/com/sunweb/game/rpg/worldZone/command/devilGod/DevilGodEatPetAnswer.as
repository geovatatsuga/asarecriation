package com.sunweb.game.rpg.worldZone.command.devilGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DevilGodEatPetAnswer extends obf_O_8_1034
   {
      
      public var devilGodPower:int;
      
      public var devilGodGrow:int;
      
      public function DevilGodEatPetAnswer()
      {
         super(CommandCodeDevilGod.DEVIL_GOD_EAT_PET_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilGodPower:int","devilGodGrow:int"];
      }
   }
}

