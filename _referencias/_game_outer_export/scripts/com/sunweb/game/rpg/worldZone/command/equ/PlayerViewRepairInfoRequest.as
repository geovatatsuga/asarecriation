package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewRepairInfoRequest extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public function PlayerViewRepairInfoRequest()
      {
         super(CommandCodePlayerEquip.PLAYER_VIEW_REPAIR_INFO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string"];
      }
   }
}

