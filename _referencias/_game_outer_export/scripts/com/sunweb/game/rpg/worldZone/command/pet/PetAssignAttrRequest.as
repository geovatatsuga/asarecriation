package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetAssignAttrRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var strAdded:int;
      
      public var wisAdded:int;
      
      public var agiAdded:int;
      
      public var vitAdded:int;
      
      public function PetAssignAttrRequest()
      {
         super(CommandCodePlayerPet.PET_ASSIGN_ATTR_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","strAdded:int","wisAdded:int","agiAdded:int","vitAdded:int"];
      }
   }
}

