package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarUpLevelAnswer extends obf_O_8_1034
   {
      
      public var attackLevel:int;
      
      public var attackExp:int;
      
      public var defenseLevel:int;
      
      public var defenseExp:int;
      
      public function BloodyWarUpLevelAnswer()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_UP_LEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["attackLevel:ubyte","attackExp:int","defenseLevel:ubyte","defenseExp:int"];
      }
   }
}

