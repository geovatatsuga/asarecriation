package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.rpg.role.obf_7_4687;
   import com.sunweb.game.util.obf_3_9_3148;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.MovieClip;
   
   public class obf_0_1_1_203 extends FarmObject
   {
      
      public static var obf_K_0_1105:String = "b41@sc3";
      
      public var kind:int;
      
      protected var obf_D_S_1009:String;
      
      protected var obf_9_A_2792:Boolean;
      
      protected var obf_h_g_1471:Boolean;
      
      public function obf_0_1_1_203(param1:String)
      {
         var _loc2_:Object = obf_P_f_3747.getFarmHarvestInfo(param1);
         if(_loc2_ != null)
         {
            super(_loc2_,obf_K_0_1105);
            this.kind = _loc2_.kind;
            obf_F_7_2340 |= obf_7_4687.obf_X_a_3948;
            if(this.kind == obf_3_U_4495.PLANT)
            {
               obf_F_7_2340 |= obf_7_4687.obf_0_4_S_123;
            }
            else if(this.kind == obf_3_U_4495.obf_0___D_549)
            {
               obf_F_7_2340 |= obf_7_4687.obf_J_A_2140;
            }
            else if(this.kind == obf_3_U_4495.obf_d_z_1837)
            {
               obf_F_7_2340 |= obf_7_4687.obf_W_D_2893;
            }
            else if(this.kind == obf_3_U_4495.obf_A_q_1072)
            {
               obf_F_7_2340 |= obf_7_4687.obf_1_H_3014;
            }
            return;
         }
         throw new Error("无法找到FarmHarvest模型obf__c_o_d_e_4682=" + param1);
      }
      
      public function showPhase(param1:String, param2:Boolean = false, param3:Boolean = false) : void
      {
         var frameLabel:String;
         var mc:MovieClip;
         var phaseId:String = param1;
         var isIll:Boolean = param2;
         var isHarvest:Boolean = param3;
         this.obf_D_S_1009 = phaseId;
         this.obf_9_A_2792 = isIll;
         this.obf_h_g_1471 = isHarvest;
         frameLabel = phaseId;
         if(isHarvest)
         {
            frameLabel += "_har";
         }
         if(isIll)
         {
            frameLabel += "_ill";
         }
         mc = _displayObject as MovieClip;
         if(mc == null)
         {
            return;
         }
         try
         {
            if(mc.currentLabel == frameLabel)
            {
               return;
            }
            if(obf_3_9_3148.mcContainsLabel(mc,frameLabel))
            {
               mc.gotoAndStop(frameLabel);
               return;
            }
            if(frameLabel != phaseId && obf_3_9_3148.mcContainsLabel(mc,phaseId))
            {
               mc.gotoAndStop(phaseId);
               return;
            }
         }
         catch(e:Error)
         {
         }
         obf_x_0_1295.obf_r_w_3556("==== FarmHarvest.showPhase() error: can not find frameLabel \'" + frameLabel + "\' in \'" + _res + "\'!");
      }
      
      override protected function onModelUpdated() : void
      {
         this.showPhase(this.obf_D_S_1009,this.obf_9_A_2792,this.obf_h_g_1471);
      }
   }
}

