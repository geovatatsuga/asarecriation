package com.sunweb.game.rpg.worldZone.command.npc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class NpcAssembleItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var assembleRuleIndex:int;
      
      public var addedItems:Array;
      
      public var baseItemIds:Array;
      
      public var priorityEqualItem:Boolean;
      
      public var protectionItem:String;
      
      public function NpcAssembleItemRequest()
      {
         super(CommandCodeNpc.NPC_ASSEMBLE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","assembleRuleIndex:ushort","addedItems:array(string)","baseItemIds:array(string)","priorityEqualItem:boolean","protectionItem:string"];
      }
   }
}

