package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import flash.utils.ByteArray;
   
   public class PlayerUseSkillRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var skillSn:int;
      
      public var skillCode:String;
      
      public var targetId:String;
      
      public var targetPoint:MapPoint;
      
      public var wrappedRequestBytes:ByteArray;
      
      public function PlayerUseSkillRequest()
      {
         super(CommandCodePlayer.PLAYER_USE_SKILL_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","skillSn:ushort","skillCode:string","targetId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint","wrappedRequestBytes:byteArray"];
      }
      
      override public function getDigestKey() : int
      {
         return 61985;
      }
   }
}

