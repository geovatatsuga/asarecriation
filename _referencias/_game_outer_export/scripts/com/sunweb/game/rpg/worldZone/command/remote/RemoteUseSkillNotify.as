package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class RemoteUseSkillNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var roleName:String;
      
      public var skillSn:int;
      
      public var skillCode:String;
      
      public var skillLevel:int = 1;
      
      public var targetId:String;
      
      public var targetPoint:MapPoint;
      
      public var singTime:int;
      
      public var castTime:int;
      
      public function RemoteUseSkillNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_USE_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","roleName:string","skillSn:ushort","skillCode:string","skillLevel:byte","targetId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint","singTime:ushort","castTime:ushort"];
      }
   }
}

