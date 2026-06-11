package com.sunweb.game.rpg.sound
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class obf_W_4679 extends EventDispatcher
   {
      
      private var obf_l_S_2587:Sound;
      
      private var obf_T_m_2406:SoundChannel;
      
      private var obf_u_x_3995:String;
      
      public function obf_W_4679(param1:String)
      {
         var _loc2_:ResourceBag = null;
         super(this);
         this.obf_u_x_3995 = param1;
         this.obf_l_S_2587 = ResourceManager.instance.getSound(param1);
         if(!this.obf_l_S_2587)
         {
            _loc2_ = ResourceManager.instance.getBag("soundBag",true);
            _loc2_.obf_z_U_2156(obf_L_l_4100.getResLibStringByResID(param1));
            _loc2_.load();
         }
      }
      
      public function get obf_Y_o_1862() : Boolean
      {
         return this.obf_l_S_2587 != null;
      }
      
      public function get obf_4_v_4068() : String
      {
         return this.obf_u_x_3995;
      }
      
      public function play(param1:int = 0, param2:SoundTransform = null) : void
      {
         this.stop();
         if(!this.obf_l_S_2587)
         {
            return;
         }
         this.obf_T_m_2406 = this.obf_l_S_2587.play(0,param1,param2);
      }
      
      public function stop() : void
      {
         if(!this.obf_l_S_2587 || !this.obf_T_m_2406)
         {
            return;
         }
         this.obf_T_m_2406.stop();
      }
      
      public function destroy() : void
      {
      }
   }
}

