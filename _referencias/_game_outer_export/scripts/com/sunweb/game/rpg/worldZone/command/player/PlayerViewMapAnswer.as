package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.script.DynamicVars;
   
   public class PlayerViewMapAnswer extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var remotePlayers:Array;
      
      public var monsters:Array;
      
      public var traps:Array;
      
      public var items:Array;
      
      public var farmsInUse:Array;
      
      public var farmBuildings:Array;
      
      public var farmHarvests:Array;
      
      public var mapVars:DynamicVars;
      
      public function PlayerViewMapAnswer()
      {
         super(CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","remotePlayers:array(com.sunweb.game.rpg.role.RemotePlayerInfo)","monsters:array(com.sunweb.game.rpg.world.info.MonsterInfo)","traps:array(com.sunweb.game.rpg.role.MapTrapInfo)","items:array(com.sunweb.game.rpg.world.map.MapItemInfo)","farmsInUse:array(com.sunweb.game.rpg.farm.FarmInfo)","farmBuildings:array(com.sunweb.game.rpg.farm.FarmBuildingInfo)","farmHarvests:array(com.sunweb.game.rpg.farm.FarmHarvestInfo)","mapVars:com.sunweb.game.rpg.script.DynamicVars"];
      }
   }
}

