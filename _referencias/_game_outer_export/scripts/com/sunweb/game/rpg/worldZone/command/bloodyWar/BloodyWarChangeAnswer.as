package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarChangeAnswer extends obf_O_8_1034
   {
      
      public var attackTemp:int;
      
      public var defenseTemp:int;
      
      public var attack:int;
      
      public var defense:int;
      
      public function BloodyWarChangeAnswer()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_CHANGE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["attack:int","defense:int","attackTemp:int","defenseTemp:int"];
      }
   }
}

