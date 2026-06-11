package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamRollResultNotify extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int = 1;
      
      public var rollPlayers:Object = new Object();
      
      public var ownerPlayerId:String;
      
      public function PlayerTeamRollResultNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_ROLL_RESULT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","itemCode:string","itemCount:ubyte","rollPlayers:map(string,byte)","ownerPlayerId:string"];
      }
   }
}

