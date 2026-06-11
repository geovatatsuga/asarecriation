package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelUpRequest extends obf_O_8_1034
   {
      
      public var angelId:String;
      
      public function PlayerAngelUpRequest()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["angelId:string"];
      }
   }
}

