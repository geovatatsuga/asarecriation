package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarChangeRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var value:int;
      
      public function BloodyWarChangeRequest()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_CHANGE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","value:int"];
      }
   }
}

