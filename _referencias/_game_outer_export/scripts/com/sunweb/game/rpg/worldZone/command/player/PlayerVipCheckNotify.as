package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerVipCheckNotify extends obf_O_8_1034
   {
      
      public var vipLevel:int;
      
      public var vipExp:int;
      
      public var vipExpiredTime:String;
      
      public function PlayerVipCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_VIP_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["vipLevel:byte","vipExp:int","vipExpiredTime:string"];
      }
   }
}

