package com.sunweb.game.rpg.worldZone.command.player.vacantSpace
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class VacantSpaceBallInRequest extends obf_O_8_1034
   {
      
      public var index:int;
      
      public var itemCode:String;
      
      public var itemId:String;
      
      public var itemCount:int;
      
      public function VacantSpaceBallInRequest()
      {
         super(CommandCodeVacantSpace.VACANT_SPACE_BALL_IN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:byte","itemCode:string","itemId:string","itemCount:int"];
      }
   }
}

