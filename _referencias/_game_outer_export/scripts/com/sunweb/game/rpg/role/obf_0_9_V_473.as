package com.sunweb.game.rpg.role
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_W_E_4480;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class obf_0_9_V_473
   {
      
      private static var _effectMap:Object;
      
      public static var obf_r_E_2000:Function;
      
      public static var stopEffectSoundFun:Function;
      
      public static var obf_D_Q_834:Object = new Object();
      
      private static var obf_k_x_4441:int = 0;
      
      public var limitMode:int = 0;
      
      public var obf_C_u_1591:int = 100;
      
      public var obf_W_V_1312:int = 20;
      
      public function obf_0_9_V_473()
      {
         super();
      }
      
      public static function initialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_d_j_2550 = null;
         _effectMap = new Object();
         for each(_loc2_ in param1)
         {
            _loc3_ = new obf_d_j_2550(_loc2_);
            if(getEffect(_loc3_.code) == null)
            {
               _effectMap[_loc2_.code] = _loc3_;
            }
            else
            {
               obf_x_0_1295.obf_r_w_3556("==== obf_______2466：" + _loc3_.code);
            }
         }
      }
      
      public static function getEffect(param1:String) : obf_d_j_2550
      {
         return _effectMap[param1];
      }
      
      public static function getEffectRaw(param1:String) : Boolean
      {
         var _loc2_:obf_d_j_2550 = _effectMap[param1];
         if(!_loc2_)
         {
            return false;
         }
         if(_loc2_.atLayer == obf_d_j_2550.obf_q_t_1678 || _loc2_.atLayer == obf_d_j_2550.obf_j_7_2818)
         {
            return true;
         }
         return false;
      }
      
      public static function showEffects(param1:Map, param2:MapInteractiveObject, param3:Point, param4:Array, param5:int = 0, param6:String = null, param7:int = -1, param8:Boolean = false, param9:int = -1) : Array
      {
         var _loc11_:String = null;
         var _loc12_:obf_W_E_4480 = null;
         if(param1 == null)
         {
            return null;
         }
         if(param2 == null && param3 == null)
         {
            return null;
         }
         if(param4 == null || param4.length == 0)
         {
            return null;
         }
         var _loc10_:Array = new Array();
         for each(_loc11_ in param4)
         {
            _loc12_ = null;
            if(param2 != null)
            {
               _loc12_ = showEffectOnObject(param1,param2,_loc11_,param5,param6,param7,false,param8,param9);
            }
            else
            {
               _loc12_ = showEffectOnPoint(param1,param3,_loc11_,param5,param6,param7,param8,param9);
            }
            if(_loc12_ != null)
            {
               _loc10_.push(_loc12_);
            }
         }
         return _loc10_;
      }
      
      public static function showAlwaysEffect(param1:Map, param2:MapInteractiveObject, param3:String) : String
      {
         var _loc4_:obf_W_E_4480 = showEffectOnObject(param1,param2,param3,0,null,-1,true,false,999);
         if(!_loc4_)
         {
            return "";
         }
         ++obf_k_x_4441;
         obf_D_Q_834[param3 + "#" + obf_k_x_4441] = _loc4_;
         return param3 + "#" + obf_k_x_4441;
      }
      
      public static function obf_0_8_h_66(param1:String) : void
      {
         var effect:obf_d_j_2550;
         var alwaysId:String = param1;
         var thisEffect:obf_W_E_4480 = obf_D_Q_834[alwaysId] as obf_W_E_4480;
         if(!thisEffect)
         {
            return;
         }
         effect = getEffect(alwaysId.split("#")[0]);
         if(Boolean(effect) && stopEffectSoundFun != null)
         {
            try
            {
               stopEffectSoundFun.apply(null,[effect.effectSound]);
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
         if(thisEffect.parent)
         {
            thisEffect.parent.removeChild(thisEffect);
         }
         delete obf_D_Q_834[alwaysId];
      }
      
      public static function showEffectOnObject(param1:Map, param2:MapInteractiveObject, param3:String, param4:int = 0, param5:String = null, param6:int = -1, param7:Boolean = false, param8:Boolean = false, param9:int = -1, param10:Array = null) : obf_W_E_4480
      {
         var effect:obf_d_j_2550;
         var mc:MovieClip;
         var tmc:obf_W_E_4480;
         var rect:Rectangle;
         var c:obf_0_Y_3475 = null;
         var soundLoop:int = 0;
         var map:Map = param1;
         var atObject:MapInteractiveObject = param2;
         var effectCode:String = param3;
         var playTimeInMs:int = param4;
         var suffix:String = param5;
         var angle:int = param6;
         var alwaysShow:Boolean = param7;
         var autoSpeed:Boolean = param8;
         var effectSoundLoop:int = param9;
         var effectPar:Array = param10;
         if(atObject == null)
         {
            return null;
         }
         effect = getEffect(effectCode);
         if(effect == null)
         {
            return null;
         }
         if(!map && (effect.atLayer == obf_d_j_2550.obf_v_k_1747 || effect.atLayer == obf_d_j_2550.obf_b_B_4190))
         {
            return null;
         }
         if(angle < 0)
         {
            c = atObject as obf_0_Y_3475;
            angle = c == null ? 0 : c.actionManager.obf_e_O_820;
         }
         mc = getEffectMC(effect.res,effect.dirNum,angle,suffix,effectPar);
         if(mc == null)
         {
            obf_T_k_1059(effect.res);
            return null;
         }
         try
         {
            mc.initEffect(angle,suffix);
            setEffectMCArgs(mc,effectPar);
         }
         catch(e:Error)
         {
         }
         tmc = new obf_6_t_3568(mc);
         tmc.rewind();
         if(playTimeInMs > 0)
         {
            tmc.maxPlayTime = playTimeInMs;
            if(autoSpeed)
            {
               tmc.allowRepeat = false;
               tmc.obf_N_B_1760(playTimeInMs);
            }
            else
            {
               tmc.allowRepeat = true;
            }
         }
         else
         {
            tmc.allowRepeat = false;
         }
         tmc.autoRemove = true;
         rect = null;
         if(effect.atObjectX == obf_d_j_2550.obf_d_D_1247)
         {
            tmc.x = 0;
         }
         else
         {
            if(atObject is obf_0_Y_3475)
            {
               rect = (atObject as obf_0_Y_3475).bodySprite.getRect(atObject);
            }
            else
            {
               rect = atObject.getRect(atObject);
            }
            tmc.x = rect.x + rect.width * effect.atObjectX;
         }
         if(effect.atObjectY == obf_d_j_2550.obf_d_D_1247)
         {
            tmc.y = 0;
         }
         else
         {
            if(rect == null)
            {
               if(atObject is obf_0_Y_3475)
               {
                  rect = (atObject as obf_0_Y_3475).bodySprite.getRect(atObject);
                  if(atObject is obf_0_M_3913)
                  {
                     rect.y = (atObject as obf_0_M_3913).getTopmostY();
                     rect.height = rect.y > 0 ? rect.y : -rect.y;
                  }
               }
               else
               {
                  rect = atObject.getRect(atObject);
               }
            }
            tmc.y = rect.y + rect.height * (1 - effect.atObjectY);
         }
         if(effect.atLayer == obf_d_j_2550.obf_v_k_1747 || effect.atLayer == obf_d_j_2550.obf_b_B_4190)
         {
            tmc.x += atObject.rootPX;
            tmc.y += atObject.rootPY;
         }
         if(effect.atLayer == obf_d_j_2550.obf_v_k_1747)
         {
            if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               map.bgObjectLayer.addChild(tmc);
            }
         }
         else if(effect.atLayer == obf_d_j_2550.obf_b_B_4190)
         {
            if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               map.magicLayer.addChild(tmc);
            }
         }
         else if(effect.atLayer == obf_d_j_2550.obf_W_h_4258)
         {
            if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               atObject.addChildAt(tmc,0);
            }
         }
         else if(effect.atLayer == obf_d_j_2550.obf_H_X_1512)
         {
            if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               atObject.addChild(tmc);
            }
         }
         else if(effect.atLayer == obf_d_j_2550.obf_q_t_1678)
         {
            if(Boolean(atObject is obf_0_M_3913 && (atObject as obf_0_M_3913).obf_C_J_3472) && Boolean((atObject as obf_0_M_3913).obf_C_J_3472.isRaw) && Boolean((atObject as obf_0_M_3913).playerEffect))
            {
               tmc.y = 0;
               tmc.x = 0;
               (atObject as obf_0_M_3913).playerEffect.addChild(tmc);
               if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
               {
                  (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild((atObject as obf_0_M_3913).playerEffect);
               }
            }
            else if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               atObject.addChild(tmc);
            }
         }
         else if(effect.atLayer == obf_d_j_2550.obf_j_7_2818)
         {
            if(Boolean(atObject is obf_0_M_3913 && (atObject as obf_0_M_3913).obf_C_J_3472) && Boolean((atObject as obf_0_M_3913).obf_C_J_3472.isRaw) && Boolean((atObject as obf_0_M_3913).playerEffectD))
            {
               tmc.y = 0;
               tmc.x = 0;
               (atObject as obf_0_M_3913).playerEffectD.addChild(tmc);
               if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
               {
                  (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild((atObject as obf_0_M_3913).playerEffectD);
               }
            }
            else if(Boolean(!obf_L_l_4100.isEmpty(effect.coverFlag)) && Boolean((atObject as obf_0_Y_3475).flagMap) && Boolean((atObject as obf_0_Y_3475).flagMap[effect.coverFlag]))
            {
               (atObject as obf_0_Y_3475).flagMap[effect.coverFlag].addChild(tmc);
            }
            else
            {
               atObject.addChildAt(tmc,0);
            }
         }
         else
         {
            obf_x_0_1295.obf_r_w_3556("EffectManager.showEffectOnObject error, invalid layer: " + effect.atLayer);
         }
         if(alwaysShow)
         {
            tmc.allowRepeat = true;
            tmc.maxPlayTime = 0;
            tmc.autoRemove = false;
         }
         if(!obf_L_l_4100.isEmpty(effect.effectSound) && obf_r_E_2000 != null)
         {
            soundLoop = effectSoundLoop < 0 ? effect.effectSoundLoop : effectSoundLoop;
            try
            {
               obf_r_E_2000.apply(null,[effect.effectSound,soundLoop]);
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
         if(!obf_L_l_4100.isEmpty(effect.stopEffectSound) && stopEffectSoundFun != null)
         {
            try
            {
               stopEffectSoundFun.apply(null,[effect.stopEffectSound]);
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
         return tmc;
      }
      
      public static function showEffectOnPoint(param1:Map, param2:Point, param3:String, param4:int = 0, param5:String = null, param6:int = -1, param7:Boolean = false, param8:int = -1) : obf_W_E_4480
      {
         var effect:obf_d_j_2550;
         var mc:MovieClip;
         var tmc:obf_W_E_4480;
         var soundLoop:int = 0;
         var map:Map = param1;
         var atPoint:Point = param2;
         var effectCode:String = param3;
         var playTimeInMs:int = param4;
         var suffix:String = param5;
         var angle:int = param6;
         var autoSpeed:Boolean = param7;
         var effectSoundLoop:int = param8;
         if(atPoint == null)
         {
            return null;
         }
         effect = getEffect(effectCode);
         if(effect == null)
         {
            return null;
         }
         if(angle < 0)
         {
            angle = 0;
         }
         mc = getEffectMC(effect.res,effect.dirNum,angle,suffix);
         if(mc == null)
         {
            obf_T_k_1059(effect.res);
            return null;
         }
         tmc = new obf_6_t_3568(mc);
         tmc.rewind();
         if(playTimeInMs > 0)
         {
            tmc.maxPlayTime = playTimeInMs;
            if(autoSpeed)
            {
               tmc.allowRepeat = false;
               tmc.obf_N_B_1760(playTimeInMs);
            }
            else
            {
               tmc.allowRepeat = true;
            }
         }
         else
         {
            tmc.allowRepeat = false;
         }
         tmc.autoRemove = true;
         tmc.x = atPoint.x;
         tmc.y = atPoint.y;
         if(effect.atLayer == obf_d_j_2550.obf_v_k_1747 || effect.atLayer == obf_d_j_2550.obf_W_h_4258)
         {
            map.bgObjectLayer.addChild(tmc);
         }
         else if(effect.atLayer == obf_d_j_2550.obf_b_B_4190 || effect.atLayer == obf_d_j_2550.obf_H_X_1512)
         {
            map.magicLayer.addChild(tmc);
         }
         else
         {
            obf_x_0_1295.obf_r_w_3556("EffectManager.showEffectOnPoint error, invalid layer: " + effect.atLayer);
         }
         if(!obf_L_l_4100.isEmpty(effect.effectSound) && obf_r_E_2000 != null)
         {
            soundLoop = effectSoundLoop < 0 ? effect.effectSoundLoop : effectSoundLoop;
            try
            {
               obf_r_E_2000.apply(null,[effect.effectSound,soundLoop]);
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
         if(!obf_L_l_4100.isEmpty(effect.stopEffectSound) && stopEffectSoundFun != null)
         {
            try
            {
               stopEffectSoundFun.apply(null,[effect.stopEffectSound]);
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
         return tmc;
      }
      
      public static function getEffectMC(param1:String, param2:int = 1, param3:int = 0, param4:String = null, param5:Array = null) : MovieClip
      {
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         if(param2 <= 1 && (param4 == null || param4 == ""))
         {
            return ResourceManager.instance.getMovieClip(param1);
         }
         var _loc6_:obf_b_8_4256 = new obf_b_8_4256(param1);
         if(param4 != null && param4 != "")
         {
            _loc6_.name += param4;
         }
         if(param2 > 1)
         {
            _loc8_ = obf_D_0_1300.getDirectionByAngle(param3,param2);
            _loc6_.name += obf_D_0_1300.directionToSuffix(_loc8_);
         }
         var _loc7_:MovieClip = ResourceManager.instance.getMovieClip(_loc6_.toString());
         if(param4 != null && param4 != "")
         {
            return _loc7_ == null ? getEffectMC(param1,param2,param3) : _loc7_;
         }
         return _loc7_;
      }
      
      public static function obf_T_k_1059(param1:String) : void
      {
         var _loc2_:ResourceBag = ResourceManager.instance.getBag("effectBag",true);
         _loc2_.obf_0_4_P_124(param1);
         _loc2_.load();
      }
      
      public static function setEffectMCArgs(param1:MovieClip, param2:Array) : void
      {
         var effectMC:MovieClip = param1;
         var args:Array = param2;
         if(Boolean(effectMC) && Boolean(args) && args.length > 0)
         {
            try
            {
               effectMC.setArgs.apply(effectMC,args);
            }
            catch(e:Error)
            {
            }
         }
      }
   }
}

