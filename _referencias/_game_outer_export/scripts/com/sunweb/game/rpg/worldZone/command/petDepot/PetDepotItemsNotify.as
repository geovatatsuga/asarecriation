package com.sunweb.game.rpg.worldZone.command.petDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetDepotItemsNotify extends obf_O_8_1034
   {
      
      public var items:Array;
      
      public var attrs:Object;
      
      public function PetDepotItemsNotify()
      {
         super(CommandCodePlayerPetDepot.PETDEPOT_ITEMS_NOYIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:array(com.sunweb.game.rpg.petDepot.PetDepotItemInfo)","attrs:map(ushort,int)"];
      }
   }
}

