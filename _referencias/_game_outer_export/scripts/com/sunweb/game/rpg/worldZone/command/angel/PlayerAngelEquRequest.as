package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelEquRequest extends obf_O_8_1034
   {
      
      public var rankId:String;
      
      public var angelId:String;
      
      public function PlayerAngelEquRequest()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_EQU_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rankId:string","angelId:string"];
      }
   }
}

