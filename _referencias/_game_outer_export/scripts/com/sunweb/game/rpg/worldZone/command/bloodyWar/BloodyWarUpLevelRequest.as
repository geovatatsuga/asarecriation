package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarUpLevelRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function BloodyWarUpLevelRequest()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

