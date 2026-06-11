package com.sunweb.game.rpg.worldZone.command.magicCircle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MagicCircleUpAnswer extends obf_O_8_1034
   {
      
      public var magicCircleIndex:int;
      
      public var magicCircleLevel:int;
      
      public function MagicCircleUpAnswer()
      {
         super(CommandCodeMagicCircle.MAGIC_CIRCLE_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["magicCircleIndex:ubyte","magicCircleLevel:ubyte"];
      }
   }
}

