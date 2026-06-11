package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakMeltRequest extends obf_O_8_1034
   {
      
      public var cloakId:String;
      
      public var code1:String;
      
      public var code2:String;
      
      public function PlayerCloakMeltRequest()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_MELT_REQEUST);
      }
      
      override public function getFieldList() : Array
      {
         return ["cloakId:string","code1:string","code2:string"];
      }
   }
}

