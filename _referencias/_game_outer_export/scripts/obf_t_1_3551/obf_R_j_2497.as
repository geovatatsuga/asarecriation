package obf_t_1_3551
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.obf_T_t_4142;
   import playerUI.RollBoxUIMC;
   
   public class obf_R_j_2497 extends RollBoxUIMC
   {
      
      public static const obf_M_W_3989:String = "RollNeed";
      
      public static const obf_0_0_v_490:String = "RollQuit";
      
      public static const obf_x_S_4022:String = "RollTimeOut";
      
      private var _itemBag:IconItemBag;
      
      private var itemTime:TimeLimiter;
      
      private var obf_o_F_4350:Sprite;
      
      private var timeInv:TimeLimiter = new TimeLimiter(200);
      
      public function obf_R_j_2497(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this.obf_o_F_4350 = new Sprite();
         while(this.numChildren > 0)
         {
            this.obf_o_F_4350.addChild(this.getChildAt(0));
         }
         this.addChild(this.obf_o_F_4350);
         this._itemBag = new IconItemBag(iconBar,param1,0);
         this._itemBag.lockDrag = true;
         this._itemBag.addValidType(GameItemType.ALL);
         this.addListener();
         this.obf_o_F_4350.x = 100;
         this.obf_o_F_4350.alpha = 0.5;
         TweenLite.to(this.obf_o_F_4350,1,{
            "x":0,
            "y":0,
            "alpha":1,
            "ease":obf_T_t_4142.easeOut
         });
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdNeed.label = DiversityManager.getString("TeamItemRollUI","cmdNeed");
         cmdQuit.label = DiversityManager.getString("TeamItemRollUI","cmdQuit");
      }
      
      public function get itemBag() : IconItemBag
      {
         return this._itemBag;
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdNeed.addEventListener(MouseEvent.CLICK,this.onClickNeed);
         cmdQuit.addEventListener(MouseEvent.CLICK,this.obf_z_s_3262);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdNeed.removeEventListener(MouseEvent.CLICK,this.onClickNeed);
         cmdQuit.removeEventListener(MouseEvent.CLICK,this.obf_z_s_3262);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.timeInv.checkTimeout())
         {
            _loc2_ = 0;
            if(this.itemTime)
            {
               _loc2_ = this.itemTime.totalTimeInMS / this.itemTime.timelimit * 100;
            }
            barTime.gotoAndStop(_loc2_);
            if(Boolean(this.itemTime) && this.itemTime.checkTimeout())
            {
               this.dispatchEvent(new Event(obf_x_S_4022));
            }
         }
      }
      
      private function onClickNeed(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_M_W_3989));
      }
      
      private function obf_z_s_3262(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_0_0_v_490));
      }
      
      public function setRollTimeLimit(param1:int) : void
      {
         this.itemTime = new TimeLimiter(param1);
      }
      
      public function setItemShow(param1:String, param2:String, param3:int, param4:int) : void
      {
         this._itemBag.dropIconItem();
         var _loc5_:IconItem = IconItemManager.getIconItemByCode(param1,param2);
         if(!_loc5_)
         {
            return;
         }
         _loc5_.itemCount = param3;
         this._itemBag.pushIconItem(_loc5_);
         this.itemTime = new TimeLimiter(param4);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

