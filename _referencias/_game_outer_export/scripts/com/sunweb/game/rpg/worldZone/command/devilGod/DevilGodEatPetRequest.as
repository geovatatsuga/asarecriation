package com.sunweb.game.rpg.worldZone.command.devilGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DevilGodEatPetRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public function DevilGodEatPetRequest()
      {
         super(CommandCodeDevilGod.DEVIL_GOD_EAT_PET_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string"];
      }
   }
}

