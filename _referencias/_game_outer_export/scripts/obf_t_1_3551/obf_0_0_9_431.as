package obf_t_1_3551
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamRollItemInfo;
   import efc.ItemRollPointEffect;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.obf_T_t_4142;
   import playerUI.ItemRollUIMC;
   
   public class obf_0_0_9_431 extends ItemRollUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var rollBoxList:Array;
      
      private var rollScrollIndex:int;
      
      private var obf_x_T_3015:int;
      
      public function obf_0_0_9_431()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2 - 160;
         this.y = GameContext.gameStage.stageHeight - 200;
         this.visible = false;
         this.rollBoxList = new Array();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function addListener() : void
      {
         cmdLeft.addEventListener(MouseEvent.CLICK,this.obf_8_h_1734);
         cmdRight.addEventListener(MouseEvent.CLICK,this.obf_q_o_1421);
      }
      
      private function removeListener() : void
      {
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.obf_8_h_1734);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.obf_q_o_1421);
      }
      
      private function onClickNeed(param1:Event) : void
      {
         var _loc2_:obf_R_j_2497 = param1.currentTarget as obf_R_j_2497;
         if(_loc2_)
         {
            TeamManager.sendRollItem(_loc2_.itemBag.haveIconItem.itemId,false);
            obf_6_D_3816.print(DiversityManager.getString("TeamItemRollUI","rollItem_Need",[obf_7_6_4416.getItemLinkA(_loc2_.itemBag.haveIconItem.itemCode,_loc2_.itemBag.haveIconItem.itemId) + " x" + _loc2_.itemBag.haveIconItem.itemCount]));
         }
      }
      
      private function obf_z_s_3262(param1:Event) : void
      {
         var _loc2_:obf_R_j_2497 = param1.currentTarget as obf_R_j_2497;
         if(_loc2_)
         {
            TeamManager.sendRollItem(_loc2_.itemBag.haveIconItem.itemId,true);
            obf_6_D_3816.print(DiversityManager.getString("TeamItemRollUI","rollItem_Quit",[obf_7_6_4416.getItemLinkA(_loc2_.itemBag.haveIconItem.itemCode,_loc2_.itemBag.haveIconItem.itemId) + " x" + _loc2_.itemBag.haveIconItem.itemCount]));
         }
      }
      
      private function obf_8_h_1734(param1:Event) : void
      {
         --this.rollScrollIndex;
         this.obf_R_h_3197();
      }
      
      private function obf_q_o_1421(param1:Event) : void
      {
         ++this.rollScrollIndex;
         this.obf_R_h_3197();
      }
      
      private function onRollTimeOut(param1:Event) : void
      {
         var _loc2_:obf_R_j_2497 = param1.currentTarget as obf_R_j_2497;
         if(_loc2_)
         {
            this.removeRollBox(_loc2_.itemBag.haveIconItem.itemId);
         }
      }
      
      private function obf_T_x_739() : void
      {
         var _loc2_:obf_R_j_2497 = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.rollBoxList.length)
         {
            _loc2_ = this.rollBoxList[_loc1_];
            _loc2_.x = _loc2_.bgBox.width * _loc1_;
            this.obf_x_T_3015 = _loc2_.bgBox.width;
            _loc1_++;
         }
         this.obf_R_h_3197();
      }
      
      private function obf_R_h_3197() : void
      {
         this.rollScrollIndex = Math.max(Math.min(this.rollScrollIndex,this.rollBoxList.length - 4 + 1),1);
         cmdLeft.visible = this.rollScrollIndex > 1;
         cmdRight.visible = this.rollScrollIndex + 4 <= this.rollBoxList.length;
         pointRollBox.scrollRect = new Rectangle((this.rollScrollIndex - 1) * this.obf_x_T_3015,0,this.obf_x_T_3015 * 4,100);
      }
      
      public function getRollBoxIndex(param1:String) : int
      {
         var _loc3_:obf_R_j_2497 = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.rollBoxList.length)
         {
            _loc3_ = this.rollBoxList[_loc2_];
            if(Boolean(_loc3_) && Boolean(_loc3_.itemBag.haveIconItem) && _loc3_.itemBag.haveIconItem.itemId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getRollBox(param1:String) : obf_R_j_2497
      {
         var _loc2_:obf_R_j_2497 = null;
         for each(_loc2_ in this.rollBoxList)
         {
            if(Boolean(_loc2_) && Boolean(_loc2_.itemBag.haveIconItem) && _loc2_.itemBag.haveIconItem.itemId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function showRollPoint(param1:String, param2:int) : void
      {
         var _loc3_:int = this.getRollBoxIndex(param1);
         if(_loc3_ == -1)
         {
            return;
         }
         var _loc4_:obf_R_j_2497 = this.rollBoxList[_loc3_];
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:ItemRollPointEffect = new ItemRollPointEffect();
         _loc5_.obf_o_A_1238.txtNumber.text = param2 + "";
         var _loc6_:Point = this.globalToLocal(_loc4_.localToGlobal(new Point()));
         _loc5_.x = _loc6_.x;
         _loc5_.y = _loc6_.y;
         var _loc7_:obf_6_t_3568 = new obf_6_t_3568(_loc5_);
         _loc7_.allowRepeat = false;
         _loc7_.autoRemove = true;
         this.addChild(_loc7_);
      }
      
      public function obf_v_L_4021(param1:TeamRollItemInfo) : void
      {
         var _loc3_:obf_R_j_2497 = null;
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(param1.itemCode,param1.itemId);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.itemCount = param1.itemCount;
         var _loc4_:int = this.getRollBoxIndex(param1.itemId);
         if(_loc4_ > -1)
         {
            _loc3_ = this.rollBoxList[_loc4_];
         }
         if(!_loc3_)
         {
            _loc3_ = new obf_R_j_2497(this);
         }
         _loc3_.setRollTimeLimit(param1.rollTimeMSLeft);
         _loc3_.itemBag.pushIconItem(_loc2_);
         this.bags.push(_loc3_.itemBag);
         this.rollBoxList.push(_loc3_);
         _loc3_.addEventListener(obf_R_j_2497.obf_M_W_3989,this.onClickNeed);
         _loc3_.addEventListener(obf_R_j_2497.obf_0_0_v_490,this.obf_z_s_3262);
         _loc3_.addEventListener(obf_R_j_2497.obf_x_S_4022,this.onRollTimeOut);
         pointRollBox.addChild(_loc3_);
         this.obf_T_x_739();
      }
      
      public function removeRollBox(param1:String) : void
      {
         var _loc2_:int = this.getRollBoxIndex(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:obf_R_j_2497 = this.rollBoxList[_loc2_];
         if(!_loc3_)
         {
            return;
         }
         this.obf_c_W_4391(_loc3_);
         this.rollBoxList.splice(_loc2_,1);
         this.obf_T_x_739();
         if(!this.rollBoxList || this.rollBoxList.length <= 0)
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function obf_M_9_3076() : void
      {
         var _loc1_:obf_R_j_2497 = null;
         for each(_loc1_ in this.rollBoxList)
         {
            if(_loc1_)
            {
               this.obf_c_W_4391(_loc1_);
            }
         }
         this.bags = new Array();
         this.rollBoxList = new Array();
      }
      
      public function removeRollBoxByTween(param1:String) : void
      {
         var _loc2_:obf_R_j_2497 = this.getRollBox(param1);
         if(!_loc2_)
         {
            return;
         }
         this.removerRollEvent(_loc2_);
         TweenLite.to(_loc2_,1.5,{
            "x":_loc2_.x,
            "y":_loc2_.y + 50,
            "alpha":0,
            "ease":obf_T_t_4142.easeOut,
            "onComplete":this.removeRollBox,
            "onCompleteParams":[param1]
         });
      }
      
      private function obf_c_W_4391(param1:obf_R_j_2497) : void
      {
         this.removerRollEvent(param1);
         if(pointRollBox.contains(param1))
         {
            pointRollBox.removeChild(param1);
         }
         param1.destroy();
      }
      
      private function removerRollEvent(param1:obf_R_j_2497) : void
      {
         param1.removeEventListener(obf_R_j_2497.obf_M_W_3989,this.onClickNeed);
         param1.removeEventListener(obf_R_j_2497.obf_0_0_v_490,this.obf_z_s_3262);
         param1.removeEventListener(obf_R_j_2497.obf_x_S_4022,this.onRollTimeOut);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_M_9_3076();
      }
      
      public function destroy() : void
      {
         this.obf_M_9_3076();
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

