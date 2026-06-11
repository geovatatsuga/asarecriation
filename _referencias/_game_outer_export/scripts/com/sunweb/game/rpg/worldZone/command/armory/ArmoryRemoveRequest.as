package com.sunweb.game.rpg.worldZone.command.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArmoryRemoveRequest extends obf_O_8_1034
   {
      
      public var gridToMCName:String;
      
      public var toBagItemIndex:int;
      
      public function ArmoryRemoveRequest()
      {
         super(CommandCodeArmory.PLAYER_ARMORY_REMOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["gridToMCName:string","toBagItemIndex:byte"];
      }
   }
}

