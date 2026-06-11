package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.element.ItemPlayerElementInfo;
   import com.sunweb.game.rpg.genie.ItemPlayerGenieInfo;
   import com.sunweb.game.rpg.pet.ItemPlayerPetInfo;
   import com.sunweb.game.rpg.playerDevil.ItemPlayerDevilInfo;
   import flash.utils.getTimer;
   
   public class GameItemFullInfo extends obf_2_M_853
   {
      
      private var checkTime:int;
      
      public var isEmpty:Boolean;
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var expiredTimeLeftInHour:int;
      
      public var canTrade:Boolean = true;
      
      public var equipmentInfo:ItemEquipmentInfo;
      
      public var rideInfo:ItemPlayerRideInfo;
      
      public var expendableInfo:ItemExpendableInfo;
      
      public var petInfo:ItemPlayerPetInfo;
      
      public var genieInfo:ItemPlayerGenieInfo;
      
      public var elementInfo:ItemPlayerElementInfo;
      
      public var devilInfo:ItemPlayerDevilInfo;
      
      public function GameItemFullInfo()
      {
         super();
         this.checkTime = getTimer();
      }
      
      public function get timeLeftInMs() : Number
      {
         return this.expiredTimeLeftInHour * 60 * 1000 - (getTimer() - this.checkTime);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","itemCode:string","expiredTimeLeftInHour:int","canTrade:boolean","equipmentInfo:com.sunweb.game.rpg.gameItem.ItemEquipmentInfo","rideInfo:com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo","expendableInfo:com.sunweb.game.rpg.gameItem.ItemExpendableInfo","petInfo:com.sunweb.game.rpg.pet.ItemPlayerPetInfo","genieInfo:com.sunweb.game.rpg.genie.ItemPlayerGenieInfo","elementInfo:com.sunweb.game.rpg.element.ItemPlayerElementInfo","devilInfo:com.sunweb.game.rpg.playerDevil.ItemPlayerDevilInfo"];
      }
   }
}

