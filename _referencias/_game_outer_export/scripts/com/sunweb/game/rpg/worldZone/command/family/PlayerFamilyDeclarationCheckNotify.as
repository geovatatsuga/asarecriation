package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyDeclarationCheckNotify extends obf_O_8_1034
   {
      
      public var declaration:String;
      
      public function PlayerFamilyDeclarationCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_DECLARATION_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["declaration:string"];
      }
   }
}

