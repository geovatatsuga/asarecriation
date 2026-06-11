package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGenieExpCheckNotify extends obf_O_8_1034
   {
      
      public var genieId:String;
      
      public var genieCode:String;
      
      public var exp:int;
      
      public var addExp:int;
      
      public function PlayerGenieExpCheckNotify()
      {
         super(CommandCodePlayerGenie.PLAYER_GENIE_EXP_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string","genieCode:string","exp:int","addExp:int"];
      }
   }
}

