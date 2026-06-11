package com.sunweb.game.rpg.sound
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class obf_q_6_3634
   {
      
      private static var _musicConfig:Object;
      
      private static var obf_2_v_1216:SoundChannel;
      
      private static var obf_p_5_2771:Sound;
      
      private static var obf_n_0_994:String;
      
      private static var _currentMusicIndex:int;
      
      private static var obf_b_C_4459:String;
      
      private static var musicErrorCount:int;
      
      public static const obf_G_y_2255:SoundTransform = new SoundTransform();
      
      public static const obf_T_T_4349:SoundTransform = new SoundTransform();
      
      private static var obf_A_0_3964:Object = new Object();
      
      public function obf_q_6_3634()
      {
         super();
      }
      
      public static function initMusicConfig(param1:Object) : void
      {
         _musicConfig = param1;
         obf_0_9_V_473.obf_r_E_2000 = obf_e_J_1876;
         obf_0_9_V_473.stopEffectSoundFun = stopEffectSound;
      }
      
      public static function obf_w_z_1201(param1:String) : void
      {
         if(!_musicConfig || obf_n_0_994 == param1)
         {
            return;
         }
         _currentMusicIndex = -1;
         obf_n_0_994 = param1;
         if(!obf_0_7_1868())
         {
            musicError(null);
         }
      }
      
      public static function updateMusicVolume() : void
      {
         if(obf_2_v_1216)
         {
            obf_2_v_1216.soundTransform = obf_T_T_4349;
         }
         if(obf_K_e_3075.obf_a_S_1814)
         {
            obf_K_e_3075.obf_a_S_1814.cmdSoundSwitch.gotoAndStop(obf_T_T_4349.volume > 0 ? 1 : 2);
         }
      }
      
      private static function obf_0_7_1868() : Boolean
      {
         var musicList:Array;
         var musicUrl:String;
         if(obf_2_v_1216)
         {
            obf_2_v_1216.stop();
         }
         try
         {
            obf_p_5_2771.removeEventListener(IOErrorEvent.IO_ERROR,musicError);
            obf_2_v_1216.removeEventListener(Event.SOUND_COMPLETE,musicComplete);
         }
         catch(e:Error)
         {
         }
         if(!_musicConfig)
         {
            return false;
         }
         musicList = _musicConfig[obf_n_0_994];
         if(!musicList)
         {
            return false;
         }
         ++_currentMusicIndex;
         if(_currentMusicIndex >= musicList.length)
         {
            _currentMusicIndex = 0;
         }
         musicUrl = GameContext.getFullResUrl(musicList[_currentMusicIndex]);
         if(obf_L_l_4100.isEmpty(musicUrl))
         {
            return false;
         }
         if(musicUrl == obf_b_C_4459)
         {
            obf_p_5_2771.addEventListener(IOErrorEvent.IO_ERROR,musicError);
         }
         else
         {
            obf_p_5_2771 = new Sound();
            obf_p_5_2771.addEventListener(IOErrorEvent.IO_ERROR,musicError);
            obf_p_5_2771.load(new URLRequest(musicUrl));
         }
         try
         {
            obf_2_v_1216 = obf_p_5_2771.play(0,0,obf_T_T_4349);
         }
         catch(e:Error)
         {
            return false;
         }
         obf_b_C_4459 = musicUrl;
         if(obf_2_v_1216)
         {
            obf_2_v_1216.addEventListener(Event.SOUND_COMPLETE,musicComplete);
         }
         return true;
      }
      
      private static function musicComplete(param1:Event) : void
      {
         musicErrorCount = 0;
         if(!obf_0_7_1868())
         {
            musicError(null);
         }
      }
      
      private static function musicError(param1:Event) : void
      {
         ++musicErrorCount;
         if(musicErrorCount < 2)
         {
            if(!obf_0_7_1868())
            {
               musicError(null);
            }
         }
      }
      
      public static function obf_e_J_1876(param1:String, param2:int = 0) : void
      {
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         var _loc3_:obf_W_4679 = getEffectSound(param1);
         if(!_loc3_)
         {
            _loc3_ = new obf_W_4679(param1);
         }
         if(!_loc3_.obf_Y_o_1862)
         {
            return;
         }
         obf_G_2_1904(param1,_loc3_);
         _loc3_.play(param2,obf_G_y_2255);
      }
      
      public static function stopEffectSound(param1:String) : void
      {
         var _loc2_:obf_W_4679 = getEffectSound(param1);
         if(_loc2_)
         {
            _loc2_.stop();
         }
      }
      
      private static function obf_G_2_1904(param1:String, param2:obf_W_4679) : void
      {
         obf_A_0_3964[param1] = param2;
      }
      
      private static function getEffectSound(param1:String) : obf_W_4679
      {
         return obf_A_0_3964[param1];
      }
      
      private static function removeEffectSound(param1:String) : void
      {
         delete obf_A_0_3964[param1];
      }
   }
}

