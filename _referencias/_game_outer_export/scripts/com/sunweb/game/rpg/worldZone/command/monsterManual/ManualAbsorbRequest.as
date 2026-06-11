package com.sunweb.game.rpg.worldZone.command.monsterManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ManualAbsorbRequest extends obf_O_8_1034
   {
      
      public var isMoney:Boolean;
      
      public var manualCode:String;
      
      public function ManualAbsorbRequest()
      {
         super(CommandCodeMonsterManual.MANUAL_ABSORB_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["isMoney:boolean","manualCode:string"];
      }
   }
}

