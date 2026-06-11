package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetUsingGenieRequest extends obf_O_8_1034
   {
      
      public var genieId:String;
      
      public function PlayerSetUsingGenieRequest()
      {
         super(CommandCodePlayerGenie.PLAYER_SET_USING_GENIE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string"];
      }
   }
}

