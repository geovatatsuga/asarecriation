package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class PlayerDropItemRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var itemIndex:int;
      
      public var mapId:String;
      
      public var targetPoint:MapPoint;
      
      public function PlayerDropItemRequest()
      {
         super(CommandCodeBag.PLAYER_DROP_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","itemIndex:ubyte","mapId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint"];
      }
      
      override public function getDigestKey() : int
      {
         return 62471;
      }
   }
}

