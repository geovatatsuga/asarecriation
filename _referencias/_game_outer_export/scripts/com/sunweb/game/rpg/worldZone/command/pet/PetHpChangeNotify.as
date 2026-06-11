package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetHpChangeNotify extends obf_O_8_1034
   {
      
      public var petOwnerName:String;
      
      public var hpChanged:int;
      
      public var hpCurrent:int;
      
      public var hpMax:int;
      
      public var skillCode:String;
      
      public var isCriticalStrike:Boolean;
      
      public function PetHpChangeNotify()
      {
         super(CommandCodePlayerPet.PET_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["petOwnerName:string","hpChanged:int","hpCurrent:int","hpMax:int","skillCode:string","isCriticalStrike:boolean"];
      }
   }
}

