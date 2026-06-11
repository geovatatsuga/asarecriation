package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmBuildingRenewRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmBuildingId:String;
      
      public var renewDays:int;
      
      public var useMoney:Boolean;
      
      public function FarmBuildingRenewRequest()
      {
         super(CommandCodeFarm.FARM_BUILDING_RENEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmBuildingId:string","renewDays:ubyte","useMoney:boolean"];
      }
   }
}

