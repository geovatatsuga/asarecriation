package obf_c_C_2026
{
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.BoothItemBoxUIMC;
   
   public class obf_0_9_P_664 extends BoothItemBoxUIMC
   {
      
      public static const obf_0_7_f_116:String = "closeclick";
      
      public static const obf_V_u_3135:String = "barclick";
      
      private var _iconBag:IconItemBag;
      
      private var _gold:int;
      
      public function obf_0_9_P_664(param1:IIconItemUI, param2:int = 0)
      {
         super();
         this._iconBag = new IconItemBag(iconBar,param1,param2);
         this._iconBag.addValidType(GameItemType.ALL);
         cmdClose.visible = false;
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(obf_0_7_f_116));
      }
      
      private function obf_o_v_1110(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(obf_V_u_3135));
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      public function get gold() : int
      {
         return this._gold;
      }
      
      override public function get height() : Number
      {
         return bg.height;
      }
      
      override public function get width() : Number
      {
         return bg.width;
      }
      
      public function setGold(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getGoldDisplay(param1);
         this._gold = param1;
         while(pointGold.numChildren > 0)
         {
            pointGold.removeChildAt(0);
         }
         pointGold.addChild(_loc2_);
      }
      
      public function destroy() : void
      {
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
   }
}

