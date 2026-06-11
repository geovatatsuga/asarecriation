package com.sunweb.game.rpg.worldZone.command.magicCircle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MagicCircleUseAnswer extends obf_O_8_1034
   {
      
      public var magicCircleIndex:int;
      
      public function MagicCircleUseAnswer()
      {
         super(CommandCodeMagicCircle.MAGIC_CIRCLE_USE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["magicCircleIndex:byte"];
      }
   }
}

