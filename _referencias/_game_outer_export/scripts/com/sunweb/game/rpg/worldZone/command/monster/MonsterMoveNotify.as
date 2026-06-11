package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MonsterMoveNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var monsterId:String;
      
      public var monsterCode:String;
      
      public var pathArrayReversed:Array;
      
      public function MonsterMoveNotify()
      {
         super(CommandCodeMonster.MONSTER_MOVE_NOTIFY);
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
         return ["mapId:string","monsterId:string","monsterCode:string","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)"];
      }
   }
}

