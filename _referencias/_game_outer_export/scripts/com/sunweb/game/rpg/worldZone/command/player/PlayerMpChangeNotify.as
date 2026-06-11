package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMpChangeNotify extends obf_O_8_1034
   {
      
      public var mpChanged:int;
      
      public var mpCurrent:int;
      
      public var skillCode:String;
      
      public function PlayerMpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_MP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mpChanged:short","mpCurrent:int","skillCode:string"];
      }
   }
}

