package com.sunweb.game.rpg.worldZone.command.player.godSoul
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.SoulAttr;
   
   public class GodSoulInfoNotify extends obf_O_8_1034
   {
      
      public var soulType:int;
      
      public var skySoulLevel:int;
      
      public var terraSoulLevel:int;
      
      public var deitySoulLevel:int;
      
      public var ancientSoulLevel:int;
      
      public var chaosSoulLevel:int;
      
      public var firstSoulLevel:int;
      
      public var skySoulAtrr:SoulAttr;
      
      public var terraSoulAttr:SoulAttr;
      
      public var deitySoulAttr:SoulAttr;
      
      public var ancientSoulAttr:SoulAttr;
      
      public var chaosSoulAttr:SoulAttr;
      
      public var firstSoulAttr:SoulAttr;
      
      public function GodSoulInfoNotify()
      {
         super(CommandPlayerGodSoul.GOD_SOUL_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["soulType:ubyte","skySoulLevel:short","terraSoulLevel:short","deitySoulLevel:short","ancientSoulLevel:short","chaosSoulLevel:short","firstSoulLevel:short","skySoulAtrr:com.sunweb.game.rpg.role.SoulAttr","terraSoulAttr:com.sunweb.game.rpg.role.SoulAttr","deitySoulAttr:com.sunweb.game.rpg.role.SoulAttr","ancientSoulAttr:com.sunweb.game.rpg.role.SoulAttr","chaosSoulAttr:com.sunweb.game.rpg.role.SoulAttr","firstSoulAttr:com.sunweb.game.rpg.role.SoulAttr"];
      }
   }
}

