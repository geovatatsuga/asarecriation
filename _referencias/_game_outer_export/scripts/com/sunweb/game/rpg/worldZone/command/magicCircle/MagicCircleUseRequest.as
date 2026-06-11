package com.sunweb.game.rpg.worldZone.command.magicCircle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MagicCircleUseRequest extends obf_O_8_1034
   {
      
      public var magicCircleIndex:int;
      
      public function MagicCircleUseRequest()
      {
         super(CommandCodeMagicCircle.MAGIC_CIRCLE_USE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["magicCircleIndex:byte"];
      }
   }
}

