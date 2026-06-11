package com.sunweb.game.rpg.worldZone.command.mate
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.mate.MateRelationInfo;
   
   public class PlayerMateRelationCheckNotify extends obf_O_8_1034
   {
      
      public var mateRelationInfo:MateRelationInfo;
      
      public function PlayerMateRelationCheckNotify()
      {
         super(CommandCodePlayerMate.PLAYER_MATE_RELATION_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mateRelationInfo:com.sunweb.game.rpg.mate.MateRelationInfo"];
      }
   }
}

