package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AnimalBuffChangeNotify extends obf_O_8_1034
   {
      
      public var animalOwnerName:String;
      
      public var buffsAdded:Array;
      
      public var buffsRemoved:Array;
      
      public function AnimalBuffChangeNotify()
      {
         super(CommandCodePlayerAnimal.ANIMAL_BUFF_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["animalOwnerName:string","buffsAdded:array(com.sunweb.game.rpg.buff.BuffInfo)","buffsRemoved:array(ushort)"];
      }
   }
}

