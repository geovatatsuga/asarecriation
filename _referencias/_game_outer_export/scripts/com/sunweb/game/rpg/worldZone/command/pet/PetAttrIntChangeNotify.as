package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetAttrIntChangeNotify extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var attr:int;
      
      public var valueChanged:int;
      
      public var valueCurrent:int;
      
      public function PetAttrIntChangeNotify()
      {
         super(CommandCodePlayerPet.PET_ATTR_INT_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","attr:byte","valueChanged:int","valueCurrent:int"];
      }
   }
}

