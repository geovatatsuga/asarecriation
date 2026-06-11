package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEditFamilyDeclarationRequest extends obf_O_8_1034
   {
      
      public var declaration:String;
      
      public function PlayerEditFamilyDeclarationRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_EDIT_FAMILY_DECLARATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["declaration:string"];
      }
   }
}

