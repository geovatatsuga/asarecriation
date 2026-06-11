package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmTeleportRequest extends obf_O_8_1034
   {
      
      public var toFarmFullId:String;
      
      public var toFarmOfPlayerId:String;
      
      public var useItem:Boolean;
      
      public function FarmTeleportRequest()
      {
         super(CommandCodeMap.FARM_TELEPORT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["toFarmFullId:string","toFarmOfPlayerId:string","useItem:boolean"];
      }
   }
}

