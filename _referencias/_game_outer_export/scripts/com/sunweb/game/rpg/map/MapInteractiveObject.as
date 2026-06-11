package com.sunweb.game.rpg.map
{
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_7_4687;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import mapCommon.TalkBox;
   
   public class MapInteractiveObject extends MapObject
   {
      
      public var id:String;
      
      protected var obf_D_I_1250:Boolean = false;
      
      protected var obf_V_l_1928:Boolean = false;
      
      protected var _labelText:String;
      
      protected var _labelTextField:TextField;
      
      protected var _labelSprite:Sprite;
      
      protected var _labelColor:uint = 16777215;
      
      protected var obf_C_a_2892:TalkBox = null;
      
      protected var obf_0_1_F_156:TimeLimiter = null;
      
      protected var obf_F_7_2340:int = 0;
      
      public function MapInteractiveObject()
      {
         super();
         rootX = rootY = 0;
         rootPXYAvailable = true;
         this.x = rootPX = Map.obf_7_7_3297 / 2;
         this.y = rootPY = Map.TILE_HEIGHT_IN_PIXEL / 2;
         this.initializeLabel();
      }
      
      override public function get area() : Rectangle
      {
         var _loc1_:Rectangle = null;
         if(!this.isInStage)
         {
            _loc1_ = this.getBounds(this);
            _loc1_.x += this.rootPX;
            _loc1_.y += this.rootPY;
            return _loc1_;
         }
         return this.getBounds(this.parent);
      }
      
      public function getTopmostY() : int
      {
         return -120;
      }
      
      public function get centerPoint() : Point
      {
         var _loc1_:Rectangle = this.getRect(this);
         _loc1_.y += this.rootPY;
         return new Point(this.rootPX,_loc1_.y + _loc1_.height / 2);
      }
      
      public function get isTracked() : Boolean
      {
         return this.obf_D_I_1250;
      }
      
      public function set isTracked(param1:Boolean) : void
      {
         this.obf_D_I_1250 = param1;
      }
      
      public function get isSelected() : Boolean
      {
         return this.obf_V_l_1928;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         this.obf_V_l_1928 = param1;
      }
      
      public function getManhattanDistance(param1:MapInteractiveObject) : int
      {
         return obf_1_q_4613.getManhattanDistance(this.rootPX,this.rootPY,param1.rootPX,param1.rootPY);
      }
      
      public function getManhattanDistancePt(param1:int, param2:int) : int
      {
         return obf_1_q_4613.getManhattanDistance(this.rootPX,this.rootPY,param1,param2);
      }
      
      public function getLineDistance(param1:MapInteractiveObject) : int
      {
         return obf_1_q_4613.getLineDistance(this.rootPX,this.rootPY,param1.rootPX,param1.rootPY);
      }
      
      public function getLineDistancePt(param1:int, param2:int) : int
      {
         return obf_1_q_4613.getLineDistance(this.rootPX,this.rootPY,param1,param2);
      }
      
      public function isBlockedFrom(param1:MapInteractiveObject) : Boolean
      {
         if(this.getMap() == null || param1 == null)
         {
            return true;
         }
         if(this.getMap() != param1.getMap())
         {
            return true;
         }
         return getMap().isBlocked2Objects(this,param1);
      }
      
      public function isBlockedFromPt(param1:int, param2:int) : Boolean
      {
         if(getMap() == null)
         {
            return true;
         }
         return getMap().isBlocked(this.rootPX,this.rootPY,param1,param2);
      }
      
      public function initializeLabel() : void
      {
         this._labelTextField = new TextField();
         this._labelTextField.autoSize = TextFieldAutoSize.LEFT;
         this._labelTextField.multiline = true;
         this._labelTextField.textColor = this._labelColor;
         this._labelTextField.filters = [new GlowFilter(0,1,2,2,1000,1)];
         this._labelSprite = new Sprite();
         this._labelSprite.addChild(this._labelTextField);
      }
      
      public function get labelColor() : uint
      {
         return this._labelColor;
      }
      
      public function set labelColor(param1:uint) : void
      {
         this._labelColor = param1;
         if(this._labelTextField != null)
         {
            this._labelTextField.textColor = param1;
         }
      }
      
      public function setAndShowLabel(param1:String) : void
      {
         this.label = param1;
         this.showLabel = true;
      }
      
      public function set label(param1:String) : void
      {
         this._labelText = param1;
         this._labelTextField.htmlText = "<p align=\'center\'>" + param1 + "</p>";
         this.updateLabelSize();
      }
      
      public function get label() : String
      {
         return this._labelText;
      }
      
      public function get showLabel() : Boolean
      {
         return this._labelSprite.parent != null;
      }
      
      public function set showLabel(param1:Boolean) : void
      {
         if(param1 == this.showLabel)
         {
            return;
         }
         if(param1)
         {
            this.addChild(this._labelSprite);
            this.updateLabelPosition();
         }
         else
         {
            this.removeChild(this._labelSprite);
         }
      }
      
      public function updateLabelPosition() : void
      {
         this._labelSprite.x = 0;
         this._labelSprite.y = this.getTopmostY() - 10;
      }
      
      public function updateLabelSize() : void
      {
         var _loc1_:Rectangle = this._labelTextField.getRect(this._labelTextField);
         this._labelTextField.x = -(_loc1_.width / 2);
         this._labelTextField.y = -_loc1_.height;
      }
      
      public function say(param1:String, param2:int = 3) : void
      {
         if(this.obf_C_a_2892 == null)
         {
            this.obf_C_a_2892 = new TalkBox();
            this.obf_C_a_2892.txtLabel.wordWrap = true;
         }
         if(this.obf_C_a_2892.parent == null)
         {
            this.addChild(this.obf_C_a_2892);
         }
         this.obf_C_a_2892.txtLabel.htmlText = param1;
         this.obf_C_a_2892.txtLabel.height = this.obf_C_a_2892.txtLabel.textHeight + 5;
         this.obf_C_a_2892.bgBox.width = this.obf_C_a_2892.txtLabel.textWidth + 15;
         this.obf_C_a_2892.bgBox.height = this.obf_C_a_2892.txtLabel.height + 10;
         this.obf_C_a_2892.fromBox.y = this.obf_C_a_2892.bgBox.height - 2;
         this.obf_C_a_2892.fromBox.width = this.obf_C_a_2892.bgBox.width / 2;
         this.obf_0_1_F_156 = new TimeLimiter(param2 * 1000);
         this.updateSayLabel();
      }
      
      protected function updateSayLabel() : void
      {
         if(this.obf_C_a_2892 == null || this.obf_C_a_2892.parent == null)
         {
            return;
         }
         this.obf_C_a_2892.x = -this.obf_C_a_2892.txtLabel.textWidth / 2;
         this.obf_C_a_2892.y = this.getTopmostY() - this.obf_C_a_2892.bgBox.height - 15;
         if(this.obf_0_1_F_156 == null)
         {
            return;
         }
         if(this.obf_0_1_F_156.checkTimeout())
         {
            this.removeChild(this.obf_C_a_2892);
            this.obf_C_a_2892 = null;
            this.obf_0_1_F_156 = null;
         }
      }
      
      public function getAbsoluteAttributes() : int
      {
         var _loc1_:int = this.obf_F_7_2340;
         if(this is obf_0_M_3913)
         {
            if((this as obf_0_M_3913).isDead)
            {
               _loc1_ |= obf_7_4687.obf_Z_d_3478;
            }
         }
         return _loc1_;
      }
      
      public function getRelativeAttributes(param1:MapInteractiveObject) : int
      {
         var _loc3_:obf_0_M_3913 = null;
         var _loc4_:obf_e_1465 = null;
         var _loc5_:obf_0_M_3913 = null;
         var _loc6_:obf_0_M_3913 = null;
         var _loc7_:obf_e_1465 = null;
         var _loc8_:obf_0_M_3913 = null;
         var _loc2_:int = 0;
         if(param1 == this)
         {
            if(this is obf_0_M_3913)
            {
               return obf_7_4687.obf_W_K_4417 | obf_7_4687.obf_0_4_V_416 | obf_7_4687.obf_9_f_3336 | obf_7_4687.obf_Y_4_3946 | obf_7_4687.obf_K_1996;
            }
            return obf_7_4687.obf_W_K_4417;
         }
         if(param1 is obf_0_M_3913)
         {
            _loc6_ = param1 as obf_0_M_3913;
            if(this is obf_0_M_3913)
            {
               _loc3_ = this as obf_0_M_3913;
               if(_loc6_.isMyEnemyFinal(_loc3_))
               {
                  _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_U_w_1821;
               }
               if(_loc3_.isInSameTeam(_loc6_))
               {
                  _loc2_ |= obf_7_4687.obf_0_4_V_416;
               }
               if(_loc3_.isInSameFamily(_loc6_))
               {
                  _loc2_ |= obf_7_4687.obf_K_1996;
               }
               if(_loc3_.isMyFriend(_loc6_.id) || _loc6_.isMyFriend(_loc3_.id))
               {
                  _loc2_ |= obf_7_4687.obf_Y_4_3946;
               }
            }
            else if(this is obf_e_1465)
            {
               _loc4_ = this as obf_e_1465;
               _loc5_ = _loc4_.getOwnerPlayer();
               if(_loc5_ == _loc6_)
               {
                  _loc2_ |= obf_7_4687.obf_O_6_3565;
               }
               else if(!(this.getMap() != null && this.getMap().enablePK && this.getMap().isArenaMode && _loc6_.side == _loc4_.side))
               {
                  if(_loc5_ == null || _loc6_.isMyEnemyFinal(_loc5_))
                  {
                     _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_b_x_4528;
                  }
               }
            }
         }
         else if(param1 is obf_e_1465)
         {
            _loc7_ = param1 as obf_e_1465;
            _loc8_ = _loc7_.getOwnerPlayer();
            if(this is obf_0_M_3913)
            {
               _loc3_ = this as obf_0_M_3913;
               if(_loc3_ == _loc8_)
               {
                  _loc2_ |= obf_7_4687.obf_I_O_3491;
               }
               else if(!(this.getMap() != null && this.getMap().enablePK && this.getMap().isArenaMode && _loc7_.side == _loc3_.side))
               {
                  if(_loc8_ == null || _loc8_.isMyEnemyFinal(_loc3_))
                  {
                     _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_U_w_1821;
                  }
               }
            }
            else if(this is obf_e_1465)
            {
               _loc4_ = this as obf_e_1465;
               _loc5_ = _loc4_.getOwnerPlayer();
               if(this.getMap() != null && this.getMap().enablePK && this.getMap().isArenaMode && _loc7_.side != _loc4_.side)
               {
                  _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_b_x_4528;
               }
               else if(!(_loc5_ == null && _loc8_ == null))
               {
                  if(_loc5_ != null && _loc8_ != null)
                  {
                     if(_loc8_.isMyEnemyFinal(_loc5_))
                     {
                        _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_b_x_4528;
                     }
                  }
                  else
                  {
                     _loc2_ |= obf_7_4687.obf_C_4201 | obf_7_4687.obf_b_x_4528;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function isValidSkillTarget(param1:MapInteractiveObject, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         if(param3 == 0)
         {
            return (this.getAbsoluteAttributes() & param2) != 0 || (this.getRelativeAttributes(param1) & param2) != 0;
         }
         _loc4_ = this.getAbsoluteAttributes() | this.getRelativeAttributes(param1);
         return (_loc4_ & param2) != 0 && (_loc4_ & param3) == 0;
      }
      
      public function obf_n_V_3862() : void
      {
         if(_map != null && _map.isUsingMaskArray)
         {
            if(_map.isMaskTile(this.rootX,this.rootY))
            {
               this.alpha = 0.6;
            }
            else
            {
               this.alpha = 1;
            }
         }
      }
      
      override public function setMap(param1:Map) : void
      {
         super.setMap(param1);
         this.obf_n_V_3862();
      }
      
      override public function moveToPixel(param1:int, param2:int) : void
      {
         super.moveToPixel(param1,param2);
         this.obf_n_V_3862();
      }
      
      override public function moveToTile(param1:int, param2:int) : void
      {
         super.moveToTile(param1,param2);
         this.obf_n_V_3862();
      }
   }
}

