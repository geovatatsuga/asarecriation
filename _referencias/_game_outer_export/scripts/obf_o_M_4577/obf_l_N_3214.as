package obf_o_M_4577
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import flash.events.Event;
   
   public dynamic class obf_l_N_3214 extends Event
   {
      
      public static const obf_R_4392:String = "connectSuccess";
      
      public static const obf_r_H_4569:String = "connectFailure";
      
      public static const obf_N_7_3895:String = "disconnected";
      
      public static const obf_m_x_2716:String = "command";
      
      private var _command:obf_C_m_1350 = null;
      
      public var detail:String;
      
      public function obf_l_N_3214(param1:String, param2:obf_C_m_1350 = null)
      {
         super(param1);
         this._command = param2;
      }
      
      public function get command() : obf_C_m_1350
      {
         return this._command;
      }
   }
}

