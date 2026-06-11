package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSpChangeNotify extends obf_O_8_1034
   {
      
      public var spChanged:int;
      
      public var spCurrent:int;
      
      public var skillCode:String;
      
      public function PlayerSpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_SP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["spChanged:int","spCurrent:int","skillCode:string"];
      }
   }
}

