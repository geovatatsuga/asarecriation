package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerXpChangeNotify extends obf_O_8_1034
   {
      
      public var xpChanged:int;
      
      public var xpCurrent:int;
      
      public var skillCode:String;
      
      public function PlayerXpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_XP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["xpChanged:int","xpCurrent:int","skillCode:string"];
      }
   }
}

