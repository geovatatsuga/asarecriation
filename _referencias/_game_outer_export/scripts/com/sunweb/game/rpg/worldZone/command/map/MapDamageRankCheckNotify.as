package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapDamageRankCheckNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var damageRankList:Array;
      
      public var myRank:int;
      
      public function MapDamageRankCheckNotify()
      {
         super(CommandCodeMap.MAP_DAMAGE_RANK_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","damageRankList:array(com.sunweb.game.rpg.world.map.MapDamageRankInfo)","myRank:ushort"];
      }
   }
}

