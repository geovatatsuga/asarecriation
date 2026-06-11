package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarInfoNotify extends obf_O_8_1034
   {
      
      public var attackLevel:int;
      
      public var attackExp:int;
      
      public var defenseLevel:int;
      
      public var defenseExp:int;
      
      public var attack:int;
      
      public var defense:int;
      
      public var attackTemp:int;
      
      public var defenseTemp:int;
      
      public function BloodyWarInfoNotify()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["attackLevel:ubyte","attackExp:int","defenseLevel:ubyte","defenseExp:int","attack:int","defense:int","attackTemp:int","defenseTemp:int"];
      }
   }
}

