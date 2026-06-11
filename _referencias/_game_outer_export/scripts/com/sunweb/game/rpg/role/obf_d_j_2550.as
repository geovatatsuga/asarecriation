package com.sunweb.game.rpg.role
{
   public class obf_d_j_2550
   {
      
      public static const obf_d_D_1247:Number = 99;
      
      public static const obf_v_k_1747:Number = 0;
      
      public static const obf_W_h_4258:Number = 1;
      
      public static const obf_H_X_1512:Number = 2;
      
      public static const obf_b_B_4190:Number = 3;
      
      public static const obf_q_t_1678:Number = 4;
      
      public static const obf_j_7_2818:Number = 5;
      
      public var code:String;
      
      public var res:String;
      
      public var dirNum:int;
      
      public var availableSuffix:String;
      
      public var atLayer:int;
      
      public var atObjectX:Number;
      
      public var atObjectY:Number;
      
      public var effectSound:String;
      
      public var effectSoundLoop:int;
      
      public var stopEffectSound:String;
      
      public var coverFlag:String;
      
      public function obf_d_j_2550(param1:Object)
      {
         super();
         this.code = param1.code;
         this.res = param1.res;
         this.dirNum = param1.dirNum;
         this.availableSuffix = param1.availableSuffix;
         this.atLayer = param1.atLayer;
         this.atObjectX = param1.atObjectX;
         this.atObjectY = param1.atObjectY;
         this.effectSound = param1.effectSound;
         this.effectSoundLoop = param1.effectSoundLoop;
         this.stopEffectSound = param1.stopEffectSound;
         this.coverFlag = param1.coverFlag;
         if(this.dirNum < 1)
         {
            this.dirNum = 1;
         }
         if(isNaN(this.atObjectX))
         {
            this.atObjectX = obf_d_D_1247;
         }
         if(isNaN(this.atObjectY))
         {
            this.atObjectY = obf_d_D_1247;
         }
         if(this.code == null || this.code == "")
         {
            throw new Error("obf_________38!");
         }
         if(this.res == null || this.res == "")
         {
            throw new Error("obf_________54：" + this.code);
         }
      }
   }
}

