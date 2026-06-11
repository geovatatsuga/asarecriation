package com.sunweb.game.rpg.role
{
   import obf_0_1_A_296.obf_I_t_863;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.farm.FarmType;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.netRole.AIObjectsBufferManager;
   import com.sunweb.game.rpg.role.action.obf_0_2_514;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_L_S_1960;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.role.action.obf_b_Y_1298;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import mapCommon.LoadingMC;
   import org.superkaka.kakalib.struct.BitmapFrameInfo;
   import org.superkaka.kakalib.utils.obf_0_9_X_707;
   
   public class obf_0_M_3913 extends obf_0_Y_3475
   {
      
      public static var obf_F_A_1014:Boolean = false;
      
      public static var pkSafeLevel:int = 15;
      
      protected static var obf_Y_c_1353:Object = new Object();
      
      protected var obf_e_Y_3991:String;
      
      protected var obf_v_3985:int;
      
      protected var effectSprite:Sprite;
      
      protected var obf_I_c_3261:Sprite;
      
      private var _downloadModel:DisplayObject;
      
      private var _downloadRideModel:DisplayObject;
      
      protected var obf_b_U_3406:TimeLimiter;
      
      protected var _titleIndex:int;
      
      protected var obf_l_Z_2902:String;
      
      public var teamMemberList:Array;
      
      protected var _familyName:String;
      
      public var familyMemberSet:Object;
      
      public var obf_Z_b_1393:Object;
      
      public var pkMode:int = 1;
      
      public var pkValue:int;
      
      protected var _equipmentModelInUse:Object;
      
      protected var obf_N_H_845:Object;
      
      protected var _rideModelCode:String;
      
      protected var obf_M_g_2489:Object;
      
      protected var _isRiding:Boolean = false;
      
      protected var _rideCapacity:int = 1;
      
      protected var _ridingPlayers:Array;
      
      protected var _rideModelHeight:int;
      
      protected var obf_b_1675:Boolean = false;
      
      protected var _ridingMaster:obf_0_M_3913 = null;
      
      protected var obf_p_c_1558:Boolean = false;
      
      protected var obf_c_a_s_e_1538:Boolean = false;
      
      protected var obf_S_i_3966:Boolean = false;
      
      protected var _loadingEquipmentRes:Array;
      
      protected var _loadingRideRes:Array;
      
      protected var _loadingMC:LoadingMC = null;
      
      protected var _loadedBaseCount:Number = 0;
      
      protected var _resourceBagName:String = null;
      
      protected var _playerBaseModelResList:Array;
      
      protected var obf_0_1_z_298:Boolean = false;
      
      protected var obf_M_E_3819:Boolean = false;
      
      public function obf_0_M_3913(param1:String, param2:DisplayObject = null, param3:String = "")
      {
         var _loc5_:ResourceBag = null;
         this.effectSprite = new Sprite();
         this.obf_I_c_3261 = new Sprite();
         this.obf_b_U_3406 = new TimeLimiter(500);
         this._equipmentModelInUse = new Object();
         this.obf_N_H_845 = new Object();
         this.obf_M_g_2489 = new Object();
         this._ridingPlayers = new Array();
         this._loadingEquipmentRes = new Array();
         this._loadingRideRes = new Array();
         super();
         obf_F_7_2340 |= obf_7_4687.obf_K_g_2044;
         var _loc4_:Object = RoleModel.getPlayerModel(param1);
         if(_loc4_ == null)
         {
            throw new Error("Can not find player model: " + param1);
         }
         if(!param3)
         {
            obf_8_J_2121 = new obf_b_Y_1298(_bodySprite,_loc4_.actions,true);
         }
         else
         {
            useMonsterModel(param3,obf_e_1465.obf_M_o_2357,true);
            this.obf_c_a_s_e_1538 = true;
            _loc5_ = AIObjectsBufferManager.getResBag("m_" + param3);
            _loc5_.obf_z_U_2156(RoleModel.getMonsterModelResId(param3));
            _loc5_.load();
         }
         this.obf_e_Y_3991 = param1;
         if(param2)
         {
            if(!BitmapFrameInfo.isBeingBitmapFrameInfo("loadMoodel"))
            {
               BitmapFrameInfo.storeBitmapInfo("loadMoodel",obf_0_9_X_707.cacheBitmap(param2,true,13421772));
            }
            this._downloadModel = new obf_I_t_863(BitmapFrameInfo.getBitmapFrameInfo("loadMoodel"));
         }
         if(_loc4_.walkStepLength != null && _loc4_.walkStepLength > 0)
         {
            walkStepLength = _loc4_.walkStepLength;
         }
         this.obf_v_3985 = _loc4_.maxModelHeight;
         walkSpeed = 200;
         stopAction();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.addChild(this.effectSprite);
         this.addChildAt(this.obf_I_c_3261,0);
      }
      
      public function get playerModelCode() : String
      {
         return this.obf_e_Y_3991;
      }
      
      public function get playerEffect() : Sprite
      {
         return this.effectSprite;
      }
      
      public function get playerEffectD() : Sprite
      {
         return this.obf_I_c_3261;
      }
      
      public function set obf_j_2_3973(param1:Boolean) : void
      {
         if(this.obf_I_c_3261.visible == param1)
         {
            return;
         }
         this.obf_I_c_3261.visible = param1;
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         if(_map != null)
         {
            _map.addAsyncRefreshPlayer(this);
         }
         else
         {
            this.obf_A_j_2560();
         }
      }
      
      override public function onUpdate() : void
      {
         super.onUpdate();
         if(this.obf_b_U_3406.checkTimeout())
         {
            if(this.obf_M_E_3819)
            {
               this.obf_A_j_2560();
            }
         }
         this.obf_t_9_2605();
      }
      
      public function get obf_C_J_3472() : obf_0_2_514
      {
         if(!obf_8_J_2121)
         {
            return null;
         }
         var _loc1_:obf_L_S_1960 = obf_8_J_2121.currentAnimation as obf_L_S_1960;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:obf_0_2_514 = _loc1_.frameArray[_loc1_.currentFrame] as obf_0_2_514;
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function obf_t_9_2605() : void
      {
         var currFrame:obf_0_2_514 = null;
         var isMirrored:Boolean = false;
         try
         {
            currFrame = this.obf_C_J_3472;
            if(!currFrame)
            {
               return;
            }
            if(!obf_8_J_2121)
            {
               return;
            }
            if(!this.effectSprite || !this.obf_I_c_3261)
            {
               return;
            }
            if(currFrame.isRaw)
            {
               this.obf_I_c_3261.x = this.effectSprite.x = currFrame.obf_s_8_1954;
               this.obf_I_c_3261.y = this.effectSprite.y = currFrame.obf_D_C_2024;
               isMirrored = false;
               if(obf_8_J_2121.currentDirection == obf_D_0_1300.RIGHT)
               {
                  isMirrored = true;
               }
               else if(obf_8_J_2121.currentDirection == obf_D_0_1300.obf_J_j_3523)
               {
                  isMirrored = true;
               }
               else if(obf_8_J_2121.currentDirection == obf_D_0_1300.obf_m_g_3030)
               {
                  isMirrored = true;
               }
               if(isMirrored)
               {
                  this.obf_I_c_3261.x = this.effectSprite.x = -currFrame.obf_s_8_1954;
               }
            }
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("Player.refreshEffectFrame() error: " + e);
         }
      }
      
      override public function getTopmostY() : int
      {
         return this.obf_v_3985 > 0 ? int(-this.obf_v_3985) : int(super.getTopmostY());
      }
      
      public function get titleIndex() : int
      {
         return this._titleIndex;
      }
      
      public function set titleIndex(param1:int) : void
      {
         this._titleIndex = param1;
      }
      
      public function get teamName() : String
      {
         return this.obf_l_Z_2902;
      }
      
      public function set teamName(param1:String) : void
      {
         this.obf_l_Z_2902 = param1;
      }
      
      public function hasTeam() : Boolean
      {
         return this.obf_l_Z_2902 != null && this.obf_l_Z_2902 != "";
      }
      
      public function isInTeam(param1:String) : Boolean
      {
         return param1 != null && param1 != "" && param1 == this.teamName;
      }
      
      public function isInSameTeam(param1:obf_0_M_3913) : Boolean
      {
         return this.isInTeam(param1.teamName);
      }
      
      public function isInSameTeamByPlayerId(param1:String) : Boolean
      {
         return this.teamMemberList != null && this.teamMemberList.indexOf(param1) > -1;
      }
      
      public function get familyName() : String
      {
         return this._familyName;
      }
      
      public function set familyName(param1:String) : void
      {
         this._familyName = param1;
      }
      
      public function isInFamily(param1:String) : Boolean
      {
         return param1 != null && param1 != "" && param1 == this.familyName;
      }
      
      public function isInSameFamily(param1:obf_0_M_3913) : Boolean
      {
         return this.isInFamily(param1.familyName);
      }
      
      public function isInSameFamilyByPlayerId(param1:String) : Boolean
      {
         return this.familyMemberSet != null && param1 != null && this.familyMemberSet[param1] != null;
      }
      
      public function isMyFriend(param1:String) : Boolean
      {
         return this.obf_Z_b_1393 != null && param1 != null && this.obf_Z_b_1393[param1] != null;
      }
      
      public function isFarmOwner(param1:obf_0_1_N_478) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.farmType == FarmType.obf_0_7_w_551)
         {
            return this.id == param1.ownerId;
         }
         if(param1.farmType == FarmType.obf_U_z_3456)
         {
            return this.isInTeam(param1.ownerId);
         }
         if(param1.farmType == FarmType.FAMILY_FARM)
         {
            return this.isInFamily(param1.ownerId);
         }
         return false;
      }
      
      public function get isRedName() : Boolean
      {
         return this.pkValue > 0;
      }
      
      public function isMyEnemyByPlayerPKMode(param1:obf_0_M_3913) : Boolean
      {
         if(param1 == this)
         {
            return false;
         }
         if(this.pkMode == PKMode.PEACE_MODE)
         {
            return false;
         }
         if(this.pkMode == PKMode.obf_N_W_2421)
         {
            if(param1.obf_I_z_3437(obf_c_y_957.obf_5_Z_1667) && param1.pkMode == PKMode.PEACE_MODE && !param1.isRedName)
            {
               return false;
            }
            return true;
         }
         if(this.pkMode == PKMode.obf_F_J_1081)
         {
            return param1.isRedName;
         }
         if(this.pkMode == PKMode.obf_9_P_3540)
         {
            if((param1.pkMode == PKMode.PEACE_MODE || param1.pkMode == PKMode.obf_F_J_1081) && !param1.isRedName)
            {
               return false;
            }
            if(param1.isInSameTeam(this))
            {
               return false;
            }
            return true;
         }
         if(this.pkMode == PKMode.obf_f_U_3730)
         {
            if((param1.pkMode == PKMode.PEACE_MODE || param1.pkMode == PKMode.obf_F_J_1081) && !param1.isRedName)
            {
               return false;
            }
            if(param1.isInSameFamily(this))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function isMyEnemyByFarmPKRule(param1:obf_0_M_3913) : Boolean
      {
         if(param1 == this)
         {
            return false;
         }
         var _loc2_:obf_0_1_N_478 = this.getFarm();
         if(_loc2_ == null || _loc2_ != param1.getFarm())
         {
            return false;
         }
         if(param1.isFarmOwner(_loc2_))
         {
            return false;
         }
         if(this.isFarmOwner(_loc2_))
         {
            return true;
         }
         return false;
      }
      
      public function isMyEnemyFinal(param1:obf_0_M_3913) : Boolean
      {
         if(param1 == this)
         {
            return false;
         }
         if(param1.isInSameTeam(this))
         {
            return false;
         }
         if(param1.obf_I_z_3437(obf_c_y_957.obf_J_4_2515))
         {
            return true;
         }
         if(param1.obf_I_z_3437(obf_c_y_957.obf_A_l_970))
         {
            if(!param1.isInSameFamily(this))
            {
               return true;
            }
         }
         if(this.getFarm() != null || param1.getFarm() != null)
         {
            return this.isMyEnemyByFarmPKRule(param1);
         }
         if(param1.level <= pkSafeLevel)
         {
            return false;
         }
         if(this.level <= pkSafeLevel)
         {
            return false;
         }
         if(this.getMap() == null || !this.getMap().enablePK)
         {
            return false;
         }
         if(this.getMap().isArenaMode)
         {
            return this.side != param1.side;
         }
         return this.isMyEnemyByPlayerPKMode(param1);
      }
      
      public function getUsingEquipmentModel(param1:String) : String
      {
         return this._equipmentModelInUse[param1];
      }
      
      public function setUsingEquipmentModel(param1:String, param2:String) : void
      {
         if(param2 == this.getUsingEquipmentModel(param1))
         {
            return;
         }
         this._equipmentModelInUse[param1] = param2;
         this.obf_p_c_1558 = true;
         this.obf_S_i_3966 = true;
      }
      
      public function obf_K_r_3562() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._equipmentModelInUse)
         {
            delete this._equipmentModelInUse[_loc1_];
         }
         this.obf_p_c_1558 = true;
         this.obf_S_i_3966 = true;
      }
      
      public function getDefaultEquipmentModel(param1:String) : String
      {
         return this.obf_N_H_845[param1];
      }
      
      public function setDefaultEquipmentModel(param1:String, param2:String) : void
      {
         if(param2 == this.getDefaultEquipmentModel(param1))
         {
            return;
         }
         this.obf_N_H_845[param1] = param2;
         this.obf_p_c_1558 = true;
         this.obf_S_i_3966 = true;
      }
      
      public function setRideModel(param1:String, param2:int = 1) : void
      {
         var _loc3_:Object = null;
         if(param1 == this._rideModelCode && param2 == this._rideCapacity)
         {
            return;
         }
         if(this._ridingPlayers.length == 0)
         {
            this._ridingPlayers.push(this);
         }
         this._rideModelCode = param1;
         this._rideCapacity = param2;
         this.obf_S_i_3966 = true;
         if(this._rideModelCode != null && this._rideModelCode != "")
         {
            _loc3_ = obf_o_2392.getRideModel(this._rideModelCode);
            if(_loc3_ != null)
            {
               this._rideModelHeight = _loc3_.maxModelHeight;
            }
         }
      }
      
      public function getRideModel() : String
      {
         return this._rideModelCode;
      }
      
      public function ride(param1:Boolean) : void
      {
         var _loc2_:* = 0;
         if(param1 == this._isRiding)
         {
            return;
         }
         if(this._rideModelCode == null || this._rideModelCode == "")
         {
            return;
         }
         if(param1 && this.isTransfiguration)
         {
            if(this._ridingPlayers.length == 0)
            {
               this._ridingPlayers.push(this);
            }
            this.obf_A_j_2560();
            this.obf_L_0_1411(param1);
         }
         else
         {
            this.obf_L_0_1411(param1);
            if(this._ridingPlayers.length > 1)
            {
               this.obf_S_i_3966 = true;
            }
            _loc2_ = int(this._ridingPlayers.length - 1);
            while(_loc2_ >= 1)
            {
               (this._ridingPlayers[_loc2_] as obf_0_M_3913).obf_X_x_4358(false,this);
               _loc2_--;
            }
            this._ridingPlayers.length = 1;
            this.obf_A_j_2560();
         }
         if(obf_8_J_2121 != null)
         {
            obf_8_J_2121.refreshAction();
         }
         updateLabelPosition();
      }
      
      public function obf_4_Y_4598(param1:obf_0_M_3913, param2:Boolean = false) : Boolean
      {
         if(this._ridingPlayers.length >= this._rideCapacity)
         {
            return false;
         }
         if(param1 == null || param1.isPassiveRiding && param1.obf_Z_T_3864.id != this.id)
         {
            return false;
         }
         if(this._ridingPlayers.indexOf(param1) > -1)
         {
            return false;
         }
         this._ridingPlayers.push(param1);
         param1.obf_X_x_4358(true,this);
         if(param2)
         {
            this.obf_S_i_3966 = true;
         }
         else
         {
            this.refreshRideView();
         }
         return true;
      }
      
      public function removeRidingPlayer(param1:obf_0_M_3913, param2:Boolean = false) : void
      {
         var _loc3_:int = this._ridingPlayers.indexOf(param1,1);
         if(_loc3_ < 0)
         {
            return;
         }
         param1.obf_X_x_4358(false,this);
         this._ridingPlayers.splice(_loc3_,1);
         if(param2)
         {
            this.obf_S_i_3966 = true;
         }
         else
         {
            this.refreshRideView();
         }
      }
      
      public function get obf_N_u_1040() : Array
      {
         return this._ridingPlayers;
      }
      
      protected function obf_L_0_1411(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         this._isRiding = param1;
         if(obf_8_J_2121 == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_G_e_4471];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_q_P_4083] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_r_q_3113];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_r_q_3113] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_G_e_4471];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_0_2_Q_460];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_0_2_3_441] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_h_4_3537];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_h_4_3537] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_0_2_Q_460];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_0_8_Z_323];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_g_k_4413] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_Q_L_2061];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_Q_L_2061] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_0_8_Z_323];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_X_3_3308];
            _loc3_ = obf_8_J_2121.actionMap[obf_S_c_3330.obf_R_z_4156];
            if(_loc2_ != null || _loc3_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_A_2_3026] = _loc3_;
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_R_z_4156] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_X_3_3308];
            }
         }
         else
         {
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_q_P_4083];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_G_e_4471] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_r_q_3113];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_r_q_3113] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_q_P_4083];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_0_2_3_441];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_0_2_Q_460] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_h_4_3537];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_h_4_3537] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_0_2_3_441];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_g_k_4413];
            if(_loc2_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_0_8_Z_323] = obf_8_J_2121.actionMap[obf_S_c_3330.obf_Q_L_2061];
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_Q_L_2061] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_g_k_4413];
            }
            _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_A_2_3026];
            _loc3_ = obf_8_J_2121.actionMap[obf_S_c_3330.obf_R_z_4156];
            if(_loc2_ != null || _loc3_ != null)
            {
               this.obf_M_g_2489[obf_S_c_3330.obf_X_3_3308] = _loc3_;
               obf_8_J_2121.actionMap[obf_S_c_3330.obf_R_z_4156] = _loc2_;
               delete this.obf_M_g_2489[obf_S_c_3330.obf_A_2_3026];
            }
         }
      }
      
      public function get isActiveRiding() : Boolean
      {
         return this._isRiding;
      }
      
      public function get isActiveOrPassiveRiding() : Boolean
      {
         return this._isRiding || this.obf_b_1675;
      }
      
      public function obf_X_x_4358(param1:Boolean, param2:obf_0_M_3913) : void
      {
         if(param1)
         {
            this.obf_b_1675 = true;
            this._ridingMaster = param2;
            stopAction();
            this.visible = false;
         }
         else
         {
            if(this._ridingMaster != null && param2.id != this._ridingMaster.id)
            {
               return;
            }
            this.obf_b_1675 = false;
            this._ridingMaster = null;
            stopAction();
            this.visible = true;
         }
      }
      
      public function get isPassiveRiding() : Boolean
      {
         return this.obf_b_1675;
      }
      
      public function get obf_Z_T_3864() : obf_0_M_3913
      {
         return this._ridingMaster;
      }
      
      public function obf_A_j_2560() : Boolean
      {
         var t:int;
         var refreshed:Boolean;
         if(!this.isInStage || this.isTransfiguration)
         {
            return false;
         }
         if(!this.obf_z_i_4009())
         {
            if(Boolean(this._downloadModel) && !this.contains(this._downloadModel))
            {
               this.addChild(this._downloadModel);
            }
            return false;
         }
         if(Boolean(this._downloadModel) && this.contains(this._downloadModel))
         {
            try
            {
               this.removeChild(this._downloadModel);
               this._downloadModel = null;
            }
            catch(e:Error)
            {
               obf_x_0_1295.obf_r_w_3556("Player.refreshView() error: " + e);
            }
         }
         t = 0;
         if(obf_8_J_2121 != null)
         {
            t = getTimer();
            if(obf_8_J_2121.checkAndCreateActions())
            {
               trace(">>>> " + this.id + " createActions: " + (getTimer() - t) + "ms.");
            }
         }
         refreshed = false;
         if(this.obf_p_c_1558)
         {
            t = getTimer();
            this.obf_X_l_842();
            refreshed = true;
            trace(">>>> " + this.id + " refreshPlayerView: " + (getTimer() - t) + "ms.");
         }
         if(this.obf_S_i_3966)
         {
            t = getTimer();
            this.refreshRideView();
            refreshed = true;
            trace(">>>> " + this.id + " refreshRideView: " + (getTimer() - t) + "ms.");
         }
         return refreshed;
      }
      
      public function get isTransfiguration() : Boolean
      {
         return this.obf_c_a_s_e_1538;
      }
      
      public function obf_X_l_842(param1:Boolean = true, param2:Boolean = true) : void
      {
         var orgRidingState:Boolean;
         var actionName:String = null;
         var action:obf_S_c_3330 = null;
         var dirName:String = null;
         var dirAnimation:obf_L_S_1960 = null;
         var direction:int = 0;
         var rightDirection:int = 0;
         var idx:int = 0;
         var frameObj:obf_0_2_514 = null;
         var rightFrame:obf_0_2_514 = null;
         var checkRes:Boolean = param1;
         var isLazyFrames:Boolean = param2;
         if(obf_8_J_2121 == null)
         {
            return;
         }
         if(checkRes)
         {
            this.obf_I_G_3539("equip");
         }
         orgRidingState = this._isRiding;
         if(this._isRiding)
         {
            this.obf_L_0_1411(false);
         }
         for(actionName in obf_8_J_2121.actionMap)
         {
            action = obf_8_J_2121.actionMap[actionName];
            if(action != null)
            {
               for(dirName in action.obf_o_S_1886)
               {
                  dirAnimation = action.obf_o_S_1886[dirName];
                  direction = obf_D_0_1300.obf_5_k_4384("_" + dirName);
                  if(!(direction == obf_D_0_1300.RIGHT || direction == obf_D_0_1300.obf_J_j_3523 || direction == obf_D_0_1300.obf_m_g_3030))
                  {
                     rightDirection = -1;
                     if(direction == obf_D_0_1300.LEFT)
                     {
                        rightDirection = obf_D_0_1300.RIGHT;
                     }
                     else if(direction == obf_D_0_1300.obf_S_d_907)
                     {
                        rightDirection = obf_D_0_1300.obf_J_j_3523;
                     }
                     else if(direction == obf_D_0_1300.obf_3_3_2145)
                     {
                        rightDirection = obf_D_0_1300.obf_m_g_3030;
                     }
                     idx = 0;
                     while(idx < dirAnimation.obf_7_8_2732.length)
                     {
                        frameObj = dirAnimation.obf_7_8_2732[idx];
                        rightFrame = null;
                        try
                        {
                           rightFrame = rightDirection >= 0 ? (action.getAnimation(rightDirection) as obf_L_S_1960).obf_7_8_2732[idx] as obf_0_2_514 : null;
                        }
                        catch(e:Error)
                        {
                        }
                        if(isLazyFrames)
                        {
                           frameObj.obf_G_l_4306 = true;
                           frameObj.isEquipOrRide = true;
                           frameObj.player = this;
                           frameObj.actionName = actionName;
                           frameObj.direction = direction;
                           frameObj.rawFrameIndex = idx;
                           frameObj.rightFrame = rightFrame;
                           if(rightFrame != null)
                           {
                              rightFrame.obf_G_l_4306 = true;
                              rightFrame.isEquipOrRide = true;
                              rightFrame.leftFrame = frameObj;
                           }
                        }
                        else
                        {
                           frameObj.obf_G_l_4306 = false;
                           this._refreshPlayerFrame(frameObj,actionName,direction,idx,rightFrame);
                        }
                        idx++;
                     }
                  }
               }
            }
         }
         if(this._isRiding != orgRidingState)
         {
            this.obf_L_0_1411(orgRidingState);
         }
         this.obf_p_c_1558 = false;
         obf_8_J_2121.refreshAction();
         updateLabelPosition();
      }
      
      public function _refreshPlayerFrame(param1:obf_0_2_514, param2:String, param3:int, param4:int, param5:obf_0_2_514) : void
      {
         var _loc11_:Rectangle = null;
         var _loc6_:obf_S_c_3330 = this.getActionNotRiding(param2);
         var _loc7_:String = obf_D_0_1300.directionToName(param3);
         var _loc8_:obf_L_S_1960 = _loc6_.obf_o_S_1886[_loc7_];
         var _loc9_:Object = _loc6_.actionInfo.dirAnimations[_loc7_][param4];
         var _loc10_:Sprite = this.assembleEquipmentImages(param2,param3,param4);
         if(_loc8_.isBitmapMode)
         {
            _loc11_ = _loc10_.getBounds(_loc10_);
            if(_loc11_.width == 0)
            {
               _loc11_.width = 1;
            }
            if(_loc11_.height == 0)
            {
               _loc11_.height = 1;
            }
            param1.rootPX = _loc9_.rootPX - _loc11_.x;
            param1.rootPY = _loc9_.rootPY - _loc11_.y;
            param1.imageData = new BitmapData(_loc11_.width,_loc11_.height,true,0);
            param1.imageData.draw(_loc10_,new Matrix(1,0,0,1,-_loc11_.x,-_loc11_.y));
         }
         else
         {
            if(obf_F_A_1014 && _loc10_.numChildren > 1)
            {
               _loc10_.cacheAsBitmap = true;
            }
            param1.imageSprite = _loc10_;
         }
         param1.obf_G_l_4306 = false;
         if(param5 != null)
         {
            if(_loc8_.isBitmapMode)
            {
               param5.imageData = param1.imageData;
               param5.rootPX = param1.rootPX;
               param5.rootPY = param1.rootPY;
            }
            else
            {
               param5.imageSprite = param1.imageSprite;
            }
            param5.obf_G_l_4306 = false;
         }
      }
      
      public function assembleEquipmentImages(param1:String, param2:int, param3:int) : Sprite
      {
         var isMirrored:Boolean;
         var container:Sprite;
         var playerFrameInfo:Object;
         var picOrder:String;
         var picOrderArray:Array;
         var bmp:Bitmap = null;
         var action:obf_S_c_3330 = null;
         var dirName:String = null;
         var equipmentKind:String = null;
         var equipCode:String = null;
         var equipModelInfo:Object = null;
         var resList:Array = null;
         var equipmentFrameInfo:Object = null;
         var actionName:String = param1;
         var direction:int = param2;
         var frameIndex:int = param3;
         if(obf_8_J_2121 == null)
         {
            return null;
         }
         isMirrored = false;
         if(direction == obf_D_0_1300.RIGHT)
         {
            isMirrored = true;
            direction = obf_D_0_1300.LEFT;
         }
         else if(direction == obf_D_0_1300.obf_J_j_3523)
         {
            isMirrored = true;
            direction = obf_D_0_1300.obf_S_d_907;
         }
         else if(direction == obf_D_0_1300.obf_m_g_3030)
         {
            isMirrored = true;
            direction = obf_D_0_1300.obf_3_3_2145;
         }
         container = new Sprite();
         action = this.getActionNotRiding(actionName);
         dirName = obf_D_0_1300.directionToName(direction);
         playerFrameInfo = action.actionInfo.dirAnimations[dirName][frameIndex];
         picOrder = playerFrameInfo.picOrder;
         picOrderArray = picOrder.split(",");
         for each(equipmentKind in picOrderArray)
         {
            if(!(equipmentKind == null || equipmentKind == ""))
            {
               equipCode = this._equipmentModelInUse[equipmentKind];
               if(equipCode == null || equipCode == "")
               {
                  bmp = this.getDefaultEquipmentBitmap(equipmentKind,playerFrameInfo,actionName,dirName,frameIndex);
                  if(bmp != null)
                  {
                     container.addChild(bmp);
                  }
               }
               else
               {
                  equipModelInfo = obf_E_k_1445.getEquipmentModel(equipmentKind,equipCode);
                  if(equipModelInfo != null)
                  {
                     resList = this.findEquipmentResIdList(equipmentKind,equipCode);
                     if(!this.isResListLoaded(resList))
                     {
                        bmp = this.getDefaultEquipmentBitmap(equipmentKind,playerFrameInfo,actionName,dirName,frameIndex);
                        if(bmp != null)
                        {
                           container.addChild(bmp);
                        }
                     }
                     else
                     {
                        try
                        {
                           equipmentFrameInfo = equipModelInfo.images[this.obf_e_Y_3991][action.name][dirName][frameIndex];
                           bmp = ResourceManager.instance.getBitmap(equipmentFrameInfo.img);
                           if(bmp == null)
                           {
                              obf_x_0_1295.obf_r_w_3556("Player.assembleEquipmentImages() can not find res: " + equipmentFrameInfo.img + " of " + equipModelInfo.code + "." + this.obf_e_Y_3991);
                           }
                           else
                           {
                              bmp.x = equipmentFrameInfo.px;
                              bmp.y = equipmentFrameInfo.py;
                              container.addChild(bmp);
                           }
                        }
                        catch(e:Error)
                        {
                           obf_x_0_1295.obf_r_w_3556("Player.assembleEquipmentImages error:" + equipModelInfo.code + "." + obf_e_Y_3991 + "." + action.name + "." + dirName + "." + frameIndex);
                           continue;
                        }
                     }
                  }
               }
            }
         }
         if(isMirrored)
         {
            container.scaleX = -container.scaleX;
         }
         return container;
      }
      
      private function isResListLoaded(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         if(param1 == null || param1.length == 0)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(!ResourceManager.instance.isResourceLoaded(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      protected function getDefaultEquipmentBitmap(param1:String, param2:Object, param3:String, param4:String, param5:int) : Bitmap
      {
         var defModelInfo:Object;
         var bmp:Bitmap = null;
         var frameInfo:Object = null;
         var equipmentKind:String = param1;
         var playerFrameInfo:Object = param2;
         var actionName:String = param3;
         var dirName:String = param4;
         var frameIndex:int = param5;
         var defaultModelCode:String = this.getDefaultEquipmentModel(equipmentKind);
         if(defaultModelCode == null || defaultModelCode == "")
         {
            if(equipmentKind == obf_E_k_1445.CLOTHES)
            {
               bmp = new Bitmap(ResourceManager.instance.getBitmapData(playerFrameInfo.img));
               return bmp;
            }
            return null;
         }
         defModelInfo = obf_E_k_1445.getEquipmentModel(equipmentKind,defaultModelCode);
         if(defModelInfo == null)
         {
            return null;
         }
         try
         {
            frameInfo = defModelInfo.images[this.obf_e_Y_3991][actionName][dirName][frameIndex];
            bmp = new Bitmap(ResourceManager.instance.getBitmapData(frameInfo.img));
            bmp.x = frameInfo.px;
            bmp.y = frameInfo.py;
         }
         catch(err:Error)
         {
            obf_x_0_1295.obf_r_w_3556("Player.getDefaultEquipmentBitmap() error:" + obf_e_Y_3991 + "." + actionName + "." + dirName + "." + frameIndex);
         }
         return bmp;
      }
      
      public function refreshRideView(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.obf_I_G_3539("ride");
         }
         if(this.obf_p_c_1558)
         {
            this.obf_X_l_842();
         }
         var _loc2_:Boolean = this._isRiding;
         if(this._isRiding)
         {
            this.obf_L_0_1411(false);
         }
         if(this._rideModelCode != null && this._rideModelCode != "")
         {
            this.obf_P_h_2267();
         }
         if(this._isRiding != _loc2_)
         {
            this.obf_L_0_1411(_loc2_);
         }
         this.obf_S_i_3966 = false;
         obf_8_J_2121.refreshAction();
      }
      
      protected function obf_P_h_2267() : void
      {
         var _loc3_:Object = null;
         var _loc1_:Object = obf_o_2392.getRideModel(this._rideModelCode);
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:Array = _loc1_.actions;
         for each(_loc3_ in _loc2_)
         {
            this.obf_M_g_2489[_loc3_.name + "_riding"] = this.obf_H_7_779(_loc3_);
         }
      }
      
      protected function obf_H_7_779(param1:Object, param2:Boolean = true) : obf_S_c_3330
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:Object = null;
         var _loc12_:obf_L_S_1960 = null;
         var _loc13_:int = 0;
         var _loc14_:obf_0_2_514 = null;
         var _loc15_:Object = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:obf_S_c_3330 = new obf_S_c_3330();
         _loc3_.actionInfo = param1;
         _loc3_.name = param1.name;
         _loc3_.dirNum = param1.dirNum == null ? 8 : int(param1.dirNum);
         var _loc4_:Object = param1.dirAnimations;
         _loc3_.obf_o_S_1886 = new Object();
         if(_loc3_.dirNum == 8 || _loc3_.dirNum == 4 || _loc3_.dirNum == 2)
         {
            _loc5_ = 8 / _loc3_.dirNum;
            _loc6_ = 0;
            while(_loc6_ < _loc3_.dirNum)
            {
               _loc7_ = _loc6_ * _loc5_;
               if(!(_loc7_ == obf_D_0_1300.RIGHT || _loc7_ == obf_D_0_1300.obf_J_j_3523 || _loc7_ == obf_D_0_1300.obf_m_g_3030))
               {
                  _loc8_ = obf_D_0_1300.directionToName(_loc7_);
                  _loc9_ = _loc4_[_loc8_];
                  if(!(_loc9_ == null || _loc9_.length == 0))
                  {
                     _loc10_ = new Array();
                     for each(_loc11_ in _loc9_)
                     {
                        _loc14_ = new obf_0_2_514();
                        _loc10_.push(_loc14_);
                        if(param2)
                        {
                           _loc14_.obf_G_l_4306 = true;
                           _loc14_.isEquipOrRide = false;
                           _loc14_.player = this;
                           _loc14_.frameInfo = _loc11_;
                           _loc14_.frames = _loc11_.frames;
                           for each(_loc15_ in _loc11_.images)
                           {
                              if(Boolean(_loc15_.player) && _loc15_.player != "")
                              {
                                 if((_loc15_.player as String).charAt(0) == "0")
                                 {
                                    _loc14_.obf_s_8_1954 = _loc15_.px;
                                    _loc14_.obf_D_C_2024 = _loc15_.py;
                                    _loc14_.isRaw = true;
                                    break;
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc14_.obf_G_l_4306 = false;
                           this._refreshRideFrame(_loc14_,_loc11_);
                        }
                     }
                     _loc12_ = new obf_L_S_1960();
                     _loc12_.obf_7_8_2732 = _loc10_;
                     _loc3_.setAnimation(_loc7_,_loc12_);
                     _loc13_ = -1;
                     if(_loc7_ == obf_D_0_1300.LEFT)
                     {
                        _loc13_ = obf_D_0_1300.RIGHT;
                     }
                     else if(_loc7_ == obf_D_0_1300.obf_S_d_907)
                     {
                        _loc13_ = obf_D_0_1300.obf_J_j_3523;
                     }
                     else if(_loc7_ == obf_D_0_1300.obf_3_3_2145)
                     {
                        _loc13_ = obf_D_0_1300.obf_m_g_3030;
                     }
                     if(_loc13_ >= 0)
                     {
                        _loc12_ = new obf_L_S_1960(null,true);
                        _loc12_.obf_7_8_2732 = _loc10_;
                        _loc3_.setAnimation(_loc13_,_loc12_);
                     }
                  }
               }
               _loc6_++;
            }
            return _loc3_;
         }
         throw new Error("createRideAction error: none direction animation not allowed!");
      }
      
      public function _refreshRideFrame(param1:obf_0_2_514, param2:Object) : void
      {
         var _loc4_:Rectangle = null;
         var _loc5_:Object = null;
         var _loc3_:Sprite = this.assembleRideImages(param2);
         if(param1.isBitmapMode)
         {
            _loc4_ = _loc3_.getBounds(_loc3_);
            if(_loc4_.width == 0)
            {
               _loc4_.width = 1;
            }
            if(_loc4_.height == 0)
            {
               _loc4_.height = 1;
            }
            param1.rootPX = param2.rootPX - _loc4_.x;
            param1.rootPY = param2.rootPY - _loc4_.y;
            param1.frames = param2.frames;
            for each(_loc5_ in param2.images)
            {
               if(Boolean(_loc5_.player) && _loc5_.player != "")
               {
                  if((_loc5_.player as String).charAt(0) == "0")
                  {
                     param1.obf_s_8_1954 = _loc5_.px;
                     param1.obf_D_C_2024 = _loc5_.py;
                     param1.isRaw = true;
                     break;
                  }
               }
            }
            param1.imageData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            param1.imageData.draw(_loc3_,new Matrix(1,0,0,1,-_loc4_.x,-_loc4_.y));
         }
         else
         {
            param1.rootPX = param2.rootPX;
            param1.rootPY = param2.rootPY;
            param1.frames = param2.frames;
            if(obf_F_A_1014 && _loc3_.numChildren > 1)
            {
               _loc3_.cacheAsBitmap = true;
            }
            param1.imageSprite = _loc3_;
         }
         param1.obf_G_l_4306 = false;
      }
      
      protected function assembleRideImages(param1:Object) : Sprite
      {
         var container:Sprite;
         var arr:Array;
         var bmp:Bitmap = null;
         var bmd:BitmapData = null;
         var imgInfo:Object = null;
         var parr:Array = null;
         var playerIndex:int = 0;
         var actionName:String = null;
         var direction:int = 0;
         var frameIndex:int = 0;
         var plyr:obf_0_M_3913 = null;
         var mc:obf_L_S_1960 = null;
         var frame:obf_0_2_514 = null;
         var sprite:Sprite = null;
         var frameInfo:Object = param1;
         if(obf_8_J_2121 == null)
         {
            return null;
         }
         if(frameInfo == null)
         {
            return null;
         }
         container = new Sprite();
         arr = frameInfo.images;
         for each(imgInfo in arr)
         {
            if(imgInfo.res != null && imgInfo.res != "")
            {
               bmd = ResourceManager.instance.getBitmapData(imgInfo.res);
               bmp = new Bitmap(bmd);
               bmp.x = imgInfo.px;
               bmp.y = imgInfo.py;
               container.addChild(bmp);
            }
            else
            {
               try
               {
                  parr = (imgInfo.player as String).split(".");
                  playerIndex = int(parr[0]);
                  actionName = parr[1];
                  direction = obf_D_0_1300.obf_5_k_4384("_" + parr[2]);
                  frameIndex = int(parr[3]);
                  plyr = this._ridingPlayers[playerIndex];
                  mc = plyr.getActionNotRiding(actionName).getAnimation(direction) as obf_L_S_1960;
                  frame = mc.obf_7_8_2732[frameIndex];
                  if(frame.isBitmapMode)
                  {
                     if(frame.obf_G_l_4306)
                     {
                        frame.redraw();
                     }
                     bmd = frame.imageData;
                     bmp = new Bitmap(bmd);
                     bmp.y = imgInfo.py - frame.rootPY;
                     if(mc.isMirrored)
                     {
                        bmp.scaleX = -bmp.scaleX;
                        bmp.x = imgInfo.px + frame.rootPX;
                     }
                     else
                     {
                        bmp.x = imgInfo.px - frame.rootPX;
                     }
                     container.addChild(bmp);
                  }
                  else
                  {
                     if(direction == obf_D_0_1300.RIGHT)
                     {
                        direction = obf_D_0_1300.LEFT;
                     }
                     else if(direction == obf_D_0_1300.obf_J_j_3523)
                     {
                        direction = obf_D_0_1300.obf_S_d_907;
                     }
                     else if(direction == obf_D_0_1300.obf_m_g_3030)
                     {
                        direction = obf_D_0_1300.obf_3_3_2145;
                     }
                     sprite = plyr.assembleEquipmentImages(actionName,direction,frameIndex);
                     sprite.y = imgInfo.py - frame.rootPY;
                     if(mc.isMirrored)
                     {
                        sprite.scaleX = -sprite.scaleX;
                        sprite.x = imgInfo.px + frame.rootPX;
                     }
                     else
                     {
                        sprite.x = imgInfo.px - frame.rootPX;
                     }
                     container.addChild(sprite);
                  }
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         return container;
      }
      
      public function getActionNotRiding(param1:String) : obf_S_c_3330
      {
         var _loc2_:obf_S_c_3330 = null;
         if(this._isRiding)
         {
            if(param1 == obf_S_c_3330.obf_r_q_3113)
            {
               _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_q_P_4083];
            }
            else if(param1 == obf_S_c_3330.obf_R_z_4156)
            {
               _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_A_2_3026];
            }
            else if(param1 == obf_S_c_3330.obf_h_4_3537)
            {
               _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_0_2_3_441];
            }
            else if(param1 == obf_S_c_3330.obf_Q_L_2061)
            {
               _loc2_ = this.obf_M_g_2489[obf_S_c_3330.obf_g_k_4413];
            }
         }
         return _loc2_ == null ? actionManager.getAction(param1) : _loc2_;
      }
      
      protected function obf_I_G_3539(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         if(param1 == "equip")
         {
            for(_loc2_ in this._equipmentModelInUse)
            {
               _loc3_ = this._equipmentModelInUse[_loc2_];
               _loc4_ = this.findEquipmentResIdList(_loc2_,_loc3_);
               if(_loc4_ != null && _loc4_.length > 0)
               {
                  for each(_loc5_ in _loc4_)
                  {
                     this.obf_f_u_835(_loc5_,param1);
                  }
               }
            }
         }
         else if(param1 == "ride")
         {
            if(this._rideModelCode != null && this._rideModelCode != "")
            {
               _loc6_ = obf_o_2392.getRideModel(this._rideModelCode);
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_.res;
                  this.obf_f_u_835(_loc7_,param1);
               }
            }
         }
      }
      
      protected function obf_f_u_835(param1:String, param2:String) : void
      {
         var _loc4_:Array = null;
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc3_:ResourceBag = this.getResourceBag(true);
         _loc3_.obf_z_U_2156(param1);
         if(ResourceManager.instance.getResourceContent(param1) == null)
         {
            _loc4_ = param2 == "equip" ? this._loadingEquipmentRes : this._loadingRideRes;
            if(_loc4_.indexOf(param1) < 0)
            {
               if(this._loadingEquipmentRes.length == 0 && this._loadingRideRes.length == 0)
               {
                  _loc3_.loader.addEventListener(obf_J_Y_3494.obf_7_1_3649,this.obf_J_p_2107);
                  _loc3_.loader.addEventListener(obf_J_Y_3494.obf_9_a_1908,this.obf_J_p_2107);
                  _loc3_.loader.addEventListener(obf_J_Y_3494.PROGRESS,this.updateLoadingState);
                  this.showLoadingState(true);
               }
               _loc4_.push(param1);
               _loc3_.load();
            }
         }
      }
      
      protected function obf_J_p_2107(param1:obf_J_Y_3494) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ResourceBag = null;
         var _loc2_:String = param1.itemCurrent.id;
         _loc3_ = this._loadingEquipmentRes.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            this._loadingEquipmentRes.splice(_loc3_,1);
            if(this._loadingEquipmentRes.length == 0)
            {
               this.obf_X_l_842(false);
               this.refreshRideView(false);
               updateLabelPosition();
            }
         }
         _loc3_ = this._loadingRideRes.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            this._loadingRideRes.splice(_loc3_,1);
            if(this._loadingRideRes.length == 0)
            {
               this.refreshRideView(false);
               updateLabelPosition();
            }
         }
         if(this._loadingEquipmentRes.length == 0 && this._loadingRideRes.length == 0)
         {
            _loc4_ = this.getResourceBag();
            _loc4_.loader.removeEventListener(obf_J_Y_3494.obf_7_1_3649,this.obf_J_p_2107);
            _loc4_.loader.removeEventListener(obf_J_Y_3494.obf_9_a_1908,this.obf_J_p_2107);
            _loc4_.loader.removeEventListener(obf_J_Y_3494.PROGRESS,this.updateLoadingState);
            this.showLoadingState(false);
         }
      }
      
      protected function showLoadingState(param1:Boolean) : void
      {
         var _loc2_:ResourceBag = null;
         if(param1)
         {
            if(this._loadingMC != null)
            {
               return;
            }
            this._loadingMC = new LoadingMC();
            this._loadingMC.percentLabel.text = "0%";
            this.addChild(this._loadingMC);
            _loc2_ = this.getResourceBag();
            if(_loc2_ == null)
            {
               this._loadedBaseCount = 0;
            }
            else
            {
               this._loadedBaseCount = _loc2_.loader.getItemsLoaded() + _loc2_.loader.getLoadingLoadedCount();
            }
         }
         else if(this._loadingMC)
         {
            this._loadingMC.parent.removeChild(this._loadingMC);
            this._loadingMC = null;
         }
      }
      
      protected function updateLoadingState(param1:obf_J_Y_3494) : void
      {
         if(this._loadingMC == null)
         {
            return;
         }
         var _loc2_:ResourceBag = this.getResourceBag();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Number = _loc2_.loader.getItemsTotal() - this._loadedBaseCount;
         var _loc4_:Number = 0;
         if(_loc3_ <= 0)
         {
            _loc4_ = 100;
         }
         else
         {
            _loc4_ = (_loc2_.loader.getItemsLoaded() + _loc2_.loader.getLoadingLoadedCount() - this._loadedBaseCount) / _loc3_ * 100;
         }
         this._loadingMC.percentLabel.text = int(_loc4_) + "%";
      }
      
      protected function getEquipModelKey(param1:String, param2:String) : String
      {
         return param1 + "|" + param2 + "|" + this.obf_e_Y_3991;
      }
      
      protected function findEquipmentResIdList(param1:String, param2:String) : Array
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc3_:Array = obf_Y_c_1353[this.getEquipModelKey(param1,param2)];
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = new Array();
         obf_Y_c_1353[this.getEquipModelKey(param1,param2)] = _loc3_;
         var _loc4_:Object = obf_E_k_1445.getEquipmentImagesForPlayerModel(param1,param2,this.obf_e_Y_3991);
         if(_loc4_ == null)
         {
            return _loc3_;
         }
         for each(_loc5_ in _loc4_)
         {
            for each(_loc6_ in _loc5_)
            {
               for each(_loc7_ in _loc6_)
               {
                  _loc8_ = obf_b_8_4256.getResIdToImport(_loc7_.img);
                  if(_loc8_ != null && _loc8_ != "")
                  {
                     if(_loc3_.indexOf(_loc8_) < 0)
                     {
                        _loc3_.push(_loc8_);
                     }
                     break;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function getResourceBag(param1:Boolean = false) : ResourceBag
      {
         if(this._resourceBagName == null)
         {
            if(this.id == null || this.id == "")
            {
               this._resourceBagName = "player|" + int(Math.random() * 10000000).toString(36);
            }
            else
            {
               this._resourceBagName = "player|" + this.id;
            }
         }
         return ResourceManager.instance.getBag(this._resourceBagName,param1);
      }
      
      protected function destroyResourceBag() : void
      {
         if(this._resourceBagName == null)
         {
            if(this.id == null || this.id == "")
            {
               return;
            }
            this._resourceBagName = "player|" + this.id;
         }
         ResourceManager.instance.destroyBag(this._resourceBagName);
      }
      
      protected function obf_z_i_4009() : Boolean
      {
         if(this.obf_0_1_z_298)
         {
            return true;
         }
         this.makePlayerBaseModelResList();
         if(this.obf_0_3_r_704())
         {
            this.obf_0_1_z_298 = true;
            return true;
         }
         if(!this.obf_M_E_3819)
         {
            this.obf_M_E_3819 = true;
            this.obf_Z_a_1428();
         }
         return false;
      }
      
      protected function makePlayerBaseModelResList() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         if(this._playerBaseModelResList == null)
         {
            this._playerBaseModelResList = new Array();
            _loc1_ = RoleModel.getPlayerModel(this.obf_e_Y_3991);
            this._playerBaseModelResList.push(_loc1_.res);
            for(_loc2_ in this.obf_N_H_845)
            {
               _loc3_ = this.obf_N_H_845[_loc2_];
               _loc4_ = this.findEquipmentResIdList(_loc2_,_loc3_);
               for each(_loc5_ in _loc4_)
               {
                  this._playerBaseModelResList.push(_loc5_);
               }
            }
         }
      }
      
      protected function obf_Z_a_1428() : void
      {
         var _loc2_:String = null;
         if(this._playerBaseModelResList == null)
         {
            return;
         }
         var _loc1_:ResourceBag = ResourceManager.instance.getBag("plyBaseModel",true);
         for each(_loc2_ in this._playerBaseModelResList)
         {
            _loc1_.obf_z_U_2156(_loc2_);
         }
         _loc1_.load();
      }
      
      protected function obf_0_3_r_704() : Boolean
      {
         return this.isResListLoaded(this._playerBaseModelResList);
      }
      
      override protected function obf_0_2_2429() : void
      {
         if(obf_r_t_1891)
         {
            try
            {
               this.getMap().remotePlayerSet.removeObject(this);
            }
            catch(e:Error)
            {
            }
         }
         super.obf_0_2_2429();
      }
      
      override public function die(param1:Boolean = true, param2:Function = null, param3:int = 0) : void
      {
         super.die(param1,param2,param3);
         if(param3 <= 0)
         {
            this.doAction(obf_S_c_3330.obf_0_3_U_524,-1,false,0,this.obf_0_2_2429);
         }
         else
         {
            this.doAction(obf_S_c_3330.obf_0_3_U_524,-1,true,param3,this.obf_0_2_2429);
         }
      }
      
      override public function destroy() : void
      {
         var bag:ResourceBag = null;
         var name:String = null;
         var i:int = 0;
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._equipmentModelInUse = null;
         try
         {
            bag = ResourceManager.instance.getBag("equipment");
            bag.loader.removeEventListener(obf_J_Y_3494.obf_7_1_3649,this.obf_J_p_2107);
            bag.loader.removeEventListener(obf_J_Y_3494.obf_9_a_1908,this.obf_J_p_2107);
         }
         catch(e:Error)
         {
         }
         this.destroyResourceBag();
         if(this.obf_M_g_2489 != null)
         {
            for(name in this.obf_M_g_2489)
            {
               delete this.obf_M_g_2489[name];
            }
            this.obf_M_g_2489 = null;
         }
         this._ridingMaster = null;
         if(this._ridingPlayers != null)
         {
            i = 0;
            while(i < this._ridingPlayers.length)
            {
               this._ridingPlayers[i] = null;
               i++;
            }
            this._ridingPlayers = null;
         }
         super.destroy();
      }
   }
}

