package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDevilExpCheckNotify extends obf_O_8_1034
   {
      
      public var devilId:String;
      
      public var devilCode:String;
      
      public var exp:int;
      
      public var addExp:int;
      
      public function PlayerDevilExpCheckNotify()
      {
         super(CommandCodePlayerDevil.PLAYER_DEVIL_EXP_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string","devilCode:string","exp:int","addExp:int"];
      }
   }
}

