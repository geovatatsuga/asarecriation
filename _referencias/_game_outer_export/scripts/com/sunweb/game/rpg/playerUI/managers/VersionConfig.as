package com.sunweb.game.rpg.playerUI.managers
{
   public class VersionConfig
   {
      
      public static var pveMaps:Array;
      
      public static var enableWhisper:Boolean = true;
      
      public static var enableFamilyPost:Boolean = true;
      
      public static var enableBooth:Boolean = true;
      
      public static var enableFriendGift:Boolean = true;
      
      public static var enableJoinFamilyResume:Boolean = true;
      
      public static var enableR2_Facebook:Boolean = false;
      
      public static var enableR2_Free:Boolean = false;
      
      public static var teamNameLength:int = 10;
      
      public static const obf_t_r_u_e_2759:String = "jp_yahoo";
      
      private static var obf_0_3_Z_75:String = null;
      
      public function VersionConfig()
      {
         super();
      }
      
      public static function setVersion(param1:String) : void
      {
         obf_0_3_Z_75 = param1;
         if(obf_0_3_Z_75 == obf_t_r_u_e_2759)
         {
            enableWhisper = false;
            enableFamilyPost = false;
            enableBooth = false;
            enableFriendGift = false;
            enableJoinFamilyResume = false;
            teamNameLength = 6;
         }
      }
      
      public static function getVersion() : String
      {
         return obf_0_3_Z_75;
      }
      
      public static function isPVEMap(param1:String) : Boolean
      {
         if(!pveMaps || pveMaps.length <= 0)
         {
            return false;
         }
         return pveMaps.indexOf(param1) > -1;
      }
   }
}

