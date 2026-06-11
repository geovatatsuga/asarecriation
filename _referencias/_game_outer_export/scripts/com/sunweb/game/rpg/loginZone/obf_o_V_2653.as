package com.sunweb.game.rpg.loginZone
{
   import flash.events.Event;
   
   public dynamic class obf_o_V_2653 extends Event
   {
      
      public static const obf_G_U_4383:String = "accountWelcome";
      
      public static const obf_u_T_3112:String = "loginSuccess";
      
      public static const obf_k_u_2062:String = "loginFailure";
      
      public static const obf_0___R_732:String = "loginDisconnected";
      
      public static const obf_d_t_3108:String = "logout";
      
      public static const obf_0_7_T_404:String = "serverList";
      
      public var sessionId:String;
      
      public var failureReason:String;
      
      public var serverList:Array;
      
      public var selectedServer:String;
      
      public function obf_o_V_2653(param1:String)
      {
         super(param1);
      }
   }
}

