package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AnimalMoveRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var pathArrayReversed:Array;
      
      public function AnimalMoveRequest()
      {
         super(CommandCodePlayerAnimal.ANIMAL_MOVE_REQUEST);
      }
      
      public function get pathArray() : Array
      {
         return this.pathArrayReversed != null ? this.pathArrayReversed.concat().reverse() : null;
      }
      
      public function set pathArray(param1:Array) : void
      {
         if(param1)
         {
            this.pathArrayReversed = param1.concat().reverse();
         }
         else
         {
            this.pathArrayReversed = null;
         }
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)"];
      }
      
      override public function getDigestKey() : int
      {
         return 27441;
      }
   }
}

