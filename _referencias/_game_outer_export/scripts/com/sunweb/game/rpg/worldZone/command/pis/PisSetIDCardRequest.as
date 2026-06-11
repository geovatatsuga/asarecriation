package com.sunweb.game.rpg.worldZone.command.pis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PisSetIDCardRequest extends obf_O_8_1034
   {
      
      public var pisIDCardNo:String;
      
      public function PisSetIDCardRequest()
      {
         super(CommandCodePIS.PIS_SET_ID_CARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["pisIDCardNo:string"];
      }
   }
}

