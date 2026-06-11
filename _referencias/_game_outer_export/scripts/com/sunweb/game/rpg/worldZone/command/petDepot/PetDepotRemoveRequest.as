package com.sunweb.game.rpg.worldZone.command.petDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetDepotRemoveRequest extends obf_O_8_1034
   {
      
      public var index:int;
      
      public var itemId:String;
      
      public function PetDepotRemoveRequest()
      {
         super(CommandCodePlayerPetDepot.PETDEPOT_REMOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:ushort","itemId:string"];
      }
   }
}

