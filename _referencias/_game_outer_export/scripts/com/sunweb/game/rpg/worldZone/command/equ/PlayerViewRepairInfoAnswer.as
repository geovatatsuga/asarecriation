package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewRepairInfoAnswer extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public var isWornOut:Boolean;
      
      public var isFullDurability:Boolean;
      
      public var repairGold:int;
      
      public var perfectRepairGold:int;
      
      public function PlayerViewRepairInfoAnswer()
      {
         super(CommandCodePlayerEquip.PLAYER_VIEW_REPAIR_INFO_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string","isWornOut:boolean","isFullDurability:boolean","repairGold:int","perfectRepairGold:int"];
      }
   }
}

