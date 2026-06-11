package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class PlayerUseItemRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var itemIndex:int;
      
      public var mapId:String;
      
      public var targetPoint:MapPoint;
      
      public var targetObjectId:String;
      
      public var parameters:Object;
      
      public function PlayerUseItemRequest()
      {
         super(CommandCodeBag.PLAYER_USE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","itemIndex:ubyte","mapId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint","targetObjectId:string","parameters:map(string, string)"];
      }
      
      override public function getDigestKey() : int
      {
         return 62468;
      }
   }
}

